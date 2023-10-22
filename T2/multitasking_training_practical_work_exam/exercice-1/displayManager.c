#include "displayManager.h"
#include "debug.h"
#include "iAcquisitionManager.h"
#include "iDisplay.h"
#include "iMessageAdder.h"
#include "msg.h"
#include "multitaskingAccumulator.h"
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

// DisplayManager thread.
pthread_t displayThread;

/**
 * Display manager entry point.
 * */
static void *display();

unsigned int displayManagerInit() {
    printf( "[displayManager]Creating thread\n" );

    if ( pthread_create( &displayThread, NULL, display, NULL ) != ERROR_SUCCESS ) {
        perror( "[pthread_create" );
        return ERROR_INIT;
    }

    printf( "[displayManager]Threads created\n" );
    return ERROR_SUCCESS;
}

unsigned int displayManagerJoin() {
    printf( "[displayManager]Joining thread\n" );

    if ( pthread_join( displayThread, NULL ) != ERROR_SUCCESS ) {
        perror( "[pthread_join" );
        return ERROR_INIT;
    }

    printf( "[displayManager]Threads joined\n" );
    return ERROR_SUCCESS;
}

static void *display() {
    D( printf( "[displayManager]Thread created for display with id %d\n", gettid() ) );
    unsigned int diffCount = 0;
    MSG_BLOCK sum;

    while ( diffCount < DISPLAY_LOOP_LIMIT ) {

        diffCount++;
        sleep( DISPLAY_SLEEP_TIME );

        sum = getCurrentSum();
        messageDisplay( &sum );
        print( getProducedCount(), getConsumedCount() );
    }

    D( printf( "[displayManager] %d termination\n", gettid() ) );
    pthread_exit( NULL );
}
