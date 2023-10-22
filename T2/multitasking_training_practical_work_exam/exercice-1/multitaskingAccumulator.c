#include "multitaskingAccumulator.h"
#include "acquisitionManager.h"
#include "debug.h"
#include "displayManager.h"
#include "messageAdder.h"
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// The entry point of the process
int main() {
    printf( "[multitaskingAccumulator]Software initialization in progress...\n" );
    acquisitionManagerInit();
    messageAdderInit();
    displayManagerInit();
    printf( "[multitaskingAccumulator]Task initialization done.\n" );

    printf( "[multitaskingAccumulator]Scheduling in progress...\n" );

    displayManagerJoin();
    messageAdderJoin();
    acquisitionManagerJoin();

    printf( "[multitaskingAccumulator]Threads terminated\n" );

    exit( EXIT_SUCCESS );
}
