#include "acquisitionManager.h"
#include "debug.h"
#include "iAcquisitionManager.h"
#include "iSensor.h"
#include "msg.h"
#include "multitaskingAccumulator.h"
#include <fcntl.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// message buffer
#define BUFF_SIZE 20
MSG_BLOCK buffer[BUFF_SIZE];
volatile unsigned int i_occupied, i_free;

// producer count storage
volatile unsigned int produceCount = 0;

pthread_t producers[PRODUCER_COUNT];

static void *produce();

/**
 * Semaphores and Mutex
 */
#define SEM_FREE "/sem_free"
#define SEM_OCCUPIED "/sem_occupied"

sem_t *sem_free;
sem_t *sem_occupied;

pthread_mutex_t mut_buffer = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_prod = PTHREAD_MUTEX_INITIALIZER;

/*
 * Creates the synchronization elements.
 * @return ERROR_SUCCESS if the init is ok, ERROR_INIT otherwise
 */
static unsigned int createSynchronizationObjects();

/*
 * Increments the produce count.
 */
static void incrementProducedCount();

static unsigned int createSynchronizationObjects() {
    printf( "[acquisitionManager]Creating semaphores\n" );

    sem_unlink( SEM_FREE );
    sem_free = sem_open( SEM_FREE, O_CREAT, 0644, BUFF_SIZE );

    sem_unlink( SEM_OCCUPIED );
    sem_occupied = sem_open( SEM_OCCUPIED, O_CREAT, 0644, 0 );

    if ( sem_free == SEM_FAILED || sem_occupied == SEM_FAILED ) {
        perror( "[sem_open" );
        return ERROR_INIT;
    }

    printf( "[acquisitionManager]Semaphores created\n" );
    return ERROR_SUCCESS;
}

static void incrementProducedCount() { // shared resource : produceCount => mutex mut_prod
    if ( pthread_mutex_lock( &mut_prod ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    produceCount++;

    if ( pthread_mutex_unlock( &mut_prod ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_unlock" );
        (void)exit;
    }
}

unsigned int getProducedCount() { // shared resource : produceCount => mutex mut_prod
    unsigned int p;

    if ( pthread_mutex_lock( &mut_prod ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    p = produceCount;

    if ( pthread_mutex_unlock( &mut_prod ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_unlock" );
        (void)exit;
    }

    return p;
}

MSG_BLOCK getMessage() { // shared resource : buffer => mutex mut_buffer
    MSG_BLOCK message;

    if ( pthread_mutex_lock( &mut_buffer ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    if ( sem_wait( sem_occupied ) != ERROR_SUCCESS ) { // take occupied slot
        perror( "[sem_wait" );
        (void)exit;
    }

    message = buffer[i_occupied];
    i_occupied = ( i_occupied + 1 ) % BUFF_SIZE;

    if ( sem_post( sem_free ) != ERROR_SUCCESS ) { // give free slot
        perror( "[sem_post" );
        (void)exit;
    }

    if ( pthread_mutex_unlock( &mut_buffer ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_unlock" );
        (void)exit;
    }

    return message;
}

// TODO create accessors to limit semaphore and mutex usage outside of this C module.

unsigned int acquisitionManagerInit() {
    i_free = 0;
    i_occupied = 0;

    printf( "[acquisitionManager]Synchronization initialization in progress...\n" );
    fflush( stdout );

    if ( createSynchronizationObjects() == ERROR_INIT )
        return ERROR_INIT;

    printf( "[acquisitionManager]Synchronization initialization done.\n" );

    printf( "[acquisitionManager]Creating threads\n" );

    for ( unsigned int i = 0; i < PRODUCER_COUNT; i++ ) {

        if ( pthread_create( &producers[i], NULL, produce, NULL ) != ERROR_SUCCESS ) {
            perror( "[pthread_create" );
            return ERROR_INIT;
        }
    }

    printf( "[acquisitionManager]Threads created\n" );
    return ERROR_SUCCESS;
}

unsigned int acquisitionManagerJoin() {
    printf( "[acquisitionManager]Joining threads\n" );

    for ( unsigned int i = 0; i < PRODUCER_COUNT; i++ ) {

        if ( pthread_join( producers[i], NULL ) != ERROR_SUCCESS ) {
            perror( "[pthread_join" );
            return ERROR_INIT;
        }
    }

    printf( "[acquisitionManager]Threads joined\n" );

    sem_destroy( sem_free );
    sem_destroy( sem_occupied );

    printf( "[acquisitionManager]Semaphores cleaned\n" );
    return ERROR_SUCCESS;
}

void *produce() { // shared resource : buffer => mutex mut_buffer
    D( printf( "[acquisitionManager]Thread created for produce with id %d\n", gettid() ) );
    unsigned int i = 0;

    while ( i < PRODUCER_LOOP_LIMIT ) {

        i++;
        sleep( PRODUCER_SLEEP_TIME + ( rand() % 5 ) );

        if ( pthread_mutex_lock( &mut_buffer ) != ERROR_SUCCESS ) {
            perror( "[pthread_mutex_lock" );
            (void)exit;
        }

        if ( sem_wait( sem_free ) != ERROR_SUCCESS ) { // take free slot
            perror( "[sem_wait" );
            (void)exit;
        }

        getInput( i, &buffer[i_free] );
        i_free = ( i_free + 1 ) % BUFF_SIZE;

        if ( sem_post( sem_occupied ) != ERROR_SUCCESS ) { // give occupied slot
            perror( "[sem_post" );
            (void)exit;
        }

        if ( pthread_mutex_unlock( &mut_buffer ) != ERROR_SUCCESS ) {
            perror( "[pthread_mutex_unlock" );
            (void)exit;
        }

        incrementProducedCount();
    }

    D( printf( "[acquisitionManager] %d termination\n", gettid() ) );
    pthread_exit( NULL );
}
