#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <unistd.h>
#include <pthread.h>
#include <fcntl.h>
#include "acquisitionManager.h"
#include "msg.h"
#include "iSensor.h"
#include "multitaskingAccumulator.h"
#include "iAcquisitionManager.h"
#include "debug.h"

#define BUFFER_SIZE 5
#define ERROR_INIT 1
#define ERROR_SUCCESS 0
#define SEMAPHORE_INITIAL_VALUE 0
#define SEM_NAME1 "/preambule_sem1"
#define SEM_NAME2 "/preambule_sem2"
#define SEM_NAME3 "/preambule_sem3"
#define SEM_NAME4 "/preambule_sem4"
#define SEM_NAME5 "/preambule_semLecture"
#define SEM_NAME6 "/preambule_semEcriture"

//producer count storage
volatile unsigned int produceCount = 0;
volatile unsigned int consommeCount = 0;

pthread_t producers[4];
MSG_BLOCK* myBuffer[BUFFER_SIZE] = {NULL};
int tabIndiceOcc[BUFFER_SIZE];
int tabIndiceLib[BUFFER_SIZE];
int iLibre = 0;
int iOcc = 0;
int jLibre = 0;
int jOcc = 0;

static void *produce(void *params);

/**
* Semaphores and Mutex
*/

pthread_mutex_t m1 = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t m2 = PTHREAD_MUTEX_INITIALIZER;
sem_t *semaphore1; // Sem Ecriture
sem_t *semaphore2; // Sem Ecriture
sem_t *semaphore3; // Sem Lecture
sem_t *semaphore4; // Sem Lecture
sem_t *semaphoreL; // Sem Libre
sem_t *semaphoreO; // Sem Occupe

/*
* Creates the synchronization elements.
* @return ERROR_SUCCESS if the init is ok, ERROR_INIT otherwise
*/


static unsigned int createSynchronizationObjects(void);

/*
* Increments the produce count.
*/
static void incrementProducedCount(void);

static unsigned int createSynchronizationObjects(void)
{
    sem_unlink(SEM_NAME1);
    sem_unlink(SEM_NAME2);
    sem_unlink(SEM_NAME3);
    sem_unlink(SEM_NAME4);
    sem_unlink(SEM_NAME5);
    sem_unlink(SEM_NAME6);
    semaphore1 = sem_open(SEM_NAME1, O_CREAT, 0644, SEMAPHORE_INITIAL_VALUE);
    semaphore2 = sem_open(SEM_NAME2, O_CREAT, 0644, SEMAPHORE_INITIAL_VALUE);
    semaphore3 = sem_open(SEM_NAME3, O_CREAT, 0644, SEMAPHORE_INITIAL_VALUE);
    semaphore4 = sem_open(SEM_NAME4, O_CREAT, 0644, SEMAPHORE_INITIAL_VALUE);
    semaphoreL = sem_open(SEM_NAME5, O_CREAT, 0644, BUFFER_SIZE);
    semaphoreO = sem_open(SEM_NAME6, O_CREAT, 0644, SEMAPHORE_INITIAL_VALUE);
    
    if ((semaphore1 == SEM_FAILED) || (semaphore2 == SEM_FAILED) || (semaphore3 == SEM_FAILED) ||
        (semaphore4 == SEM_FAILED) || (semaphoreL == SEM_FAILED) || (semaphoreO == SEM_FAILED)) 
    {
        perror("[sem_open]");
    	return ERROR_INIT;
    }
    
    for(int i=0; i<BUFFER_SIZE; i++)
    {
    	tabIndiceOcc[i]=i;
    	tabIndiceLib[i]=i;
    }
    
    return 0;
}

static void incrementProducedCount(void)
{
	pthread_mutex_lock(&m1);
	produceCount++;
	pthread_mutex_unlock(&m1);
}

unsigned int getProducedCount(void)
{
	unsigned int p = 0;
	pthread_mutex_lock(&m2);
	p = produceCount;
	pthread_mutex_unlock(&m2);
	return p;	
}

MSG_BLOCK getMessage(void)
{
	int jBuffer;
	MSG_BLOCK* temp;
	
	sem_wait(semaphoreO); // Diminue le nombre de case occupée
	
	sem_post(semaphore3);
		jBuffer = tabIndiceOcc[jOcc];
		jOcc = ((jOcc + 1)%BUFFER_SIZE);
	sem_wait(semaphore3);
					
	temp = myBuffer[jBuffer];
	//consommeCount++;
	//printf("MESSAGE CONSOMME : %d\n",consommeCount);
					
	sem_post(semaphore4);
		tabIndiceLib[jLibre] = jBuffer;
		jLibre = ((jLibre + 1)%BUFFER_SIZE);
	sem_wait(semaphore4);

	sem_post(semaphoreL); // augmente de valeur le nombre de case libre 
	
	return *temp;
}

unsigned int acquisitionManagerInit(void)
{
	unsigned int i;
	printf("[acquisitionManager]Synchronization initialization in progress...\n");
	fflush( stdout );
	if (createSynchronizationObjects() == ERROR_INIT)
		return ERROR_INIT;

	printf("[acquisitionManager]Synchronization initialization done.\n");

	for (i = 0; i < PRODUCER_COUNT; i++)
	{
		pthread_create(&producers[i], NULL, produce, NULL);
	}

	return ERROR_SUCCESS;
}

void acquisitionManagerJoin(void)
{
	unsigned int i;
	for (i = 0; i < PRODUCER_COUNT; i++)
	{
		pthread_join(producers[i], NULL);
	}

	sem_destroy(semaphore1);
	sem_destroy(semaphore2);
	sem_destroy(semaphore3);
	sem_destroy(semaphore4);
	sem_destroy(semaphoreL);
	sem_destroy(semaphoreO);
	printf("[acquisitionManager]Semaphore cleaned\n");
}

void *produce(void* params)
{
	int iBuffer;
	
	
	D(printf("[acquisitionManager]Producer created with id %d\n", gettid()));
	unsigned int i = 0;
	MSG_BLOCK temp;
		
	while (i < PRODUCER_LOOP_LIMIT)
	{
		sem_wait(semaphoreL); // Baisse de valeur le nombre de case libre 
		i++;
		sleep(PRODUCER_SLEEP_TIME+(rand() % 5));
		getInput(i,&temp);

		if(messageCheck(&temp)==1)
        	{		
        		// CODE MULTI-WRITE
			sem_post(semaphore1);
				iBuffer = tabIndiceLib[iLibre];
				iLibre = ((iLibre + 1)%BUFFER_SIZE);
			sem_wait(semaphore1);
		
			myBuffer[iBuffer] = &temp; //Je place dans mon buffer mon tempon
			incrementProducedCount(); // J'incrémente le nombre d'éléments produit
			//printf("MESSAGE PRODUIT : %d\n", getProducedCount());
			
			sem_post(semaphore2);
				tabIndiceOcc[iOcc]= iBuffer;
				iOcc = ((iOcc + 1)%BUFFER_SIZE);
			sem_wait(semaphore2);
        	}
        	sem_post(semaphoreO); // Augmente de valeur le nombre de case occupée 	
	}
	D(printf("[acquisitionManager] %d termination\n", gettid()));
	
	pthread_exit(NULL);	
}





