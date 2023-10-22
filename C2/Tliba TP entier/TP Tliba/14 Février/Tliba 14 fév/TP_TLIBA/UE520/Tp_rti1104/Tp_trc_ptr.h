/*********************** dSPACE target specific file *************************

   Header file Tp_trc_ptr.h:

   Declaration of function that initializes the global TRC pointers

   RTI1104 7.9 (02-Nov-2017)
   Tue Feb 14 17:39:34 2023

   Copyright 2023, dSPACE GmbH. All rights reserved.

 *****************************************************************************/
#ifndef RTI_HEADER_Tp_trc_ptr_h_
#define RTI_HEADER_Tp_trc_ptr_h_

/* Include the model header file. */
#include "Tp.h"
#include "Tp_private.h"
#ifdef EXTERN_C
#undef EXTERN_C
#endif

#ifdef __cplusplus
#define EXTERN_C                       extern "C"
#else
#define EXTERN_C                       extern
#endif

/*
 *  Declare the global TRC pointers
 */
EXTERN_C volatile real_T *p_0_Tp_real_T_0;
EXTERN_C volatile real_T *p_1_Tp_real_T_0;
EXTERN_C volatile real_T *p_2_Tp_real_T_0;
EXTERN_C volatile int32_T *p_2_Tp_int32_T_1;
EXTERN_C volatile real_T *p_3_Tp_real_T_0;

/*
 *  Declare the general function for TRC pointer initialization
 */
EXTERN_C void Tp_rti_init_trc_pointers(void);

#endif                                 /* RTI_HEADER_Tp_trc_ptr_h_ */
