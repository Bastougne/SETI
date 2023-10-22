#ifndef ACQUISITION_MANAGER_H
#define ACQUISITION_MANAGER_H

/**
 * Initializes the acquisitions
 */
unsigned int acquisitionManagerInit();

/**
 * Waits that acquisitions terminate
 */
unsigned int acquisitionManagerJoin();

#endif
