/*
 * Tp_data.c
 *
 * Classroom License -- for classroom instructional use only.  Not for
 * government, commercial, academic research, or other organizational use.
 *
 * Code generation for model "Tp".
 *
 * Model version              : 1.2
 * Simulink Coder version : 8.13 (R2017b) 24-Jul-2017
 * C source code generated on : Tue Feb  7 15:14:18 2023
 *
 * Target selection: rti1104.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Custom Processor->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Tp.h"
#include "Tp_private.h"

/* Block parameters (auto storage) */
P_Tp_T Tp_P = {
  /* Variable: monAmplitude
   * Referenced by: '<Root>/Pulse Generator'
   */
  10.0,

  /* Computed Parameter: PulseGenerator_Period
   * Referenced by: '<Root>/Pulse Generator'
   */
  80000.0,

  /* Computed Parameter: PulseGenerator_Duty
   * Referenced by: '<Root>/Pulse Generator'
   */
  400.0,

  /* Expression: monRetard
   * Referenced by: '<Root>/Pulse Generator'
   */
  1.0,

  /* Expression: 0.1
   * Referenced by: '<Root>/Gain'
   */
  0.1,

  /* Expression: 1
   * Referenced by: '<Root>/Saturation'
   */
  1.0,

  /* Expression: -1
   * Referenced by: '<Root>/Saturation'
   */
  -1.0
};
