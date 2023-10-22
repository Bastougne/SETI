#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include "displayManager.h"
#include "iDisplay.h"
#include "iAcquisitionManager.h"
#include "iMessageAdder.h"
#include "msg.h"
#include "multitaskingAccumulator.h"
#include "debug.h"

// DisplayManager thread.
pthread_t displayThread;

/**
 * Display manager entry point.
 * */
static void *display( void *parameters );


void displayManagerInit(void)
{
	pthread_create(&displayThread, NULL, display, NULL);
}

void displayManagerJoin(void)
{
	pthread_join(displayThread, NULL);
} 

static void *display( void *parameters )
{
	MSG_BLOCK mess;
	D(printf("[displayManager]Thread created for display with id %d\n", gettid()));
	unsigned int diffCount = 0;
	while(diffCount < DISPLAY_LOOP_LIMIT)
	{
		sleep(DISPLAY_SLEEP_TIME);
		mess = getCurrentSum();
		messageDisplay(&mess);
		print(getProducedCount(), getConsumedCount());
		
		if(getProducedCount()-getConsumedCount()==0)
			diffCount = DISPLAY_LOOP_LIMIT;		
	}
	printf("[displayManager] %d termination\n", gettid());
   	pthread_exit(NULL);
}


