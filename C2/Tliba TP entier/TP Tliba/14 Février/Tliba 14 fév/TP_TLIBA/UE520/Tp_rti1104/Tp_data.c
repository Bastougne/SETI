/*
 * Tp_data.c
 *
 * Classroom License -- for classroom instructional use only.  Not for
 * government, commercial, academic research, or other organizational use.
 *
 * Code generation for model "Tp".
 *
 * Model version              : 1.5
 * Simulink Coder version : 8.13 (R2017b) 24-Jul-2017
 * C source code generated on : Tue Feb 14 17:39:34 2023
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
  3.5,

  /* Computed Parameter: PulseGenerator_Period
   * Referenced by: '<Root>/Pulse Generator'
   */
  8000.0,

  /* Computed Parameter: PulseGenerator_Duty
   * Referenced by: '<Root>/Pulse Generator'
   */
  4000.0,

  /* Expression: monRetard
   * Referenced by: '<Root>/Pulse Generator'
   */
  1.0,

  /* Expression: [t1, t0]
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 3.3379991860228886, -0.5742856154007614 },

  /* Expression: [1 -1]
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 1.0, -1.0 },

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  0.0,

  /* Expression: 10
   * Referenced by: '<Root>/Gain1'
   */
  10.0,

  /* Expression: [s1, s0]
   * Referenced by: '<Root>/Discrete Transfer Fcn1'
   */
  { 10.125232886678729, -7.3615193160566008 },

  /* Expression: [1 -1]
   * Referenced by: '<Root>/Discrete Transfer Fcn1'
   */
  { 1.0, -1.0 },

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn1'
   */
  0.0,

  /* Expression: 0.1
   * Referenced by: '<Root>/Gain2'
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
