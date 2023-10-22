#ifndef I_ACQUISITION_MANAGER_H
#define I_ACQUISITION_MANAGER_H

#include "msg.h"

/**
 * Get the number of produced messages.
 */
unsigned int getProducedCount();

/**
 * Gets a message if any, otherwise waits for a message.
 */
MSG_BLOCK getMessage();

// TODO create message accessors prototype here.

#endif
