#include "messageAdder.h"
#include "debug.h"
#include "iAcquisitionManager.h"
#include "iMessageAdder.h"
#include "msg.h"
#include "multitaskingAccumulator.h"
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// consumer thread
pthread_t consumer;
// Message computed
volatile MSG_BLOCK out;
// Consumer count storage
volatile unsigned int consumeCount = 0;

pthread_mutex_t mut_out = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_cons = PTHREAD_MUTEX_INITIALIZER;

/**
 * Increments the consume count.
 */
static void incrementConsumeCount();

/**
 * Consumer entry point.
 */
static void *sum();

static void incrementConsumeCount() { // shared resource : consumeCount => mutex mut_cons
    if ( pthread_mutex_lock( &mut_cons ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    consumeCount++;

    if ( pthread_mutex_unlock( &mut_cons ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }
}

MSG_BLOCK getCurrentSum() { // shared resource : out => mutex mut_out
    MSG_BLOCK s;

    if ( pthread_mutex_lock( &mut_out ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    s = out;

    if ( pthread_mutex_unlock( &mut_out ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_unlock" );
        (void)exit;
    }

    return s;
}

unsigned int getConsumedCount() { // shared resource : consumeCount => mutex mut_cons
    unsigned int c;

    if ( pthread_mutex_lock( &mut_cons ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    c = consumeCount;

    if ( pthread_mutex_unlock( &mut_cons ) != ERROR_SUCCESS ) {
        perror( "[pthread_mutex_lock" );
        (void)exit;
    }

    return c;
}

unsigned int messageAdderInit() {
    out.checksum = 0;
    for ( size_t i = 0; i < DATA_SIZE; i++ ) {
        out.mData[i] = 0;
    }

    printf( "[messageAdder]Creating thread\n" );

    if ( pthread_create( &consumer, NULL, sum, NULL ) != ERROR_SUCCESS ) {
        perror( "[pthread_create" );
        return ERROR_INIT;
    }

    printf( "[messageAdder]Threads created\n" );
    return ERROR_SUCCESS;
}

unsigned int messageAdderJoin() {
    printf( "[messageAdder]Joining thread\n" );

    if ( pthread_join( consumer, NULL ) != ERROR_SUCCESS ) {
        perror( "[pthread_join" );
        return ERROR_INIT;
    }

    printf( "[messageAdder]Threads joined\n" );
    return ERROR_SUCCESS;
}

static void *sum() { // shared resource : out => mutex mut_out
    D( printf( "[messageAdder]Thread created for sum with id %d\n", gettid() ) );
    unsigned int i = 0;
    MSG_BLOCK message;

    while ( i < ADDER_LOOP_LIMIT ) {

        i++;
        sleep( ADDER_SLEEP_TIME );

        message = getMessage();

        if ( pthread_mutex_lock( &mut_out ) != ERROR_SUCCESS ) {
            perror( "[pthread_mutex_lock" );
            (void)exit;
        }

        messageAdd( &out, &message );

        if ( pthread_mutex_unlock( &mut_out ) != ERROR_SUCCESS ) {
            perror( "[pthread_mutex_unlock" );
            (void)exit;
        }

        incrementConsumeCount();
    }

    D( printf( "[messageAdder] %d termination\n", gettid() ) );
    pthread_exit( NULL );
}
