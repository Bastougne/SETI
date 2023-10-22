/*
 * Tp.c
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

#include "Tp_trc_ptr.h"
#include "Tp.h"
#include "Tp_private.h"

/* Block signals (auto storage) */
B_Tp_T Tp_B;

/* Block states (auto storage) */
DW_Tp_T Tp_DW;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_Tp_T Tp_Y;

/* Real-time model */
RT_MODEL_Tp_T Tp_M_;
RT_MODEL_Tp_T *const Tp_M = &Tp_M_;

/* Model output function */
void Tp_output(void)
{
  real_T denAccum;
  real_T u1;
  real_T u2;

  /* S-Function (rti_commonblock): '<S1>/S-Function' incorporates:
   *  Outport: '<Root>/Tension génétachy '
   */
  /* This comment workarounds a code generation problem */

  /* dSPACE I/O Board DS1104 #1 Unit:ADC Group:NON_MUX */
  Tp_Y.Tensiongntachy = (real_T) ds1104_adc_read_conv(2);

  /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
  Tp_B.PulseGenerator = (Tp_DW.clockTickCounter < Tp_P.PulseGenerator_Duty) &&
    (Tp_DW.clockTickCounter >= 0) ? Tp_P.monAmplitude : 0.0;
  if (Tp_DW.clockTickCounter >= Tp_P.PulseGenerator_Period - 1.0) {
    Tp_DW.clockTickCounter = 0;
  } else {
    Tp_DW.clockTickCounter++;
  }

  /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

  /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  denAccum = Tp_B.PulseGenerator;
  denAccum -= Tp_P.DiscreteTransferFcn_DenCoef[1] *
    Tp_DW.DiscreteTransferFcn_states;
  denAccum /= Tp_P.DiscreteTransferFcn_DenCoef[0];
  Tp_DW.DiscreteTransferFcn_tmp = denAccum;
  denAccum = Tp_P.DiscreteTransferFcn_NumCoef[0] * Tp_DW.DiscreteTransferFcn_tmp;
  denAccum += Tp_P.DiscreteTransferFcn_NumCoef[1] *
    Tp_DW.DiscreteTransferFcn_states;
  Tp_B.DiscreteTransferFcn = denAccum;

  /* Gain: '<Root>/Gain1' incorporates:
   *  Outport: '<Root>/Tension génétachy '
   */
  Tp_B.Gain1 = Tp_P.Gain1_Gain * Tp_Y.Tensiongntachy;

  /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn1' */
  denAccum = Tp_B.Gain1;
  denAccum -= Tp_P.DiscreteTransferFcn1_DenCoef[1] *
    Tp_DW.DiscreteTransferFcn1_states;
  denAccum /= Tp_P.DiscreteTransferFcn1_DenCoef[0];
  Tp_DW.DiscreteTransferFcn1_tmp = denAccum;
  denAccum = Tp_P.DiscreteTransferFcn1_NumCoef[0] *
    Tp_DW.DiscreteTransferFcn1_tmp;
  denAccum += Tp_P.DiscreteTransferFcn1_NumCoef[1] *
    Tp_DW.DiscreteTransferFcn1_states;
  Tp_B.DiscreteTransferFcn1 = denAccum;

  /* Sum: '<Root>/Subtract' */
  Tp_B.Subtract = Tp_B.DiscreteTransferFcn - Tp_B.DiscreteTransferFcn1;

  /* Gain: '<Root>/Gain2' */
  Tp_B.Gain2 = Tp_P.Gain2_Gain * Tp_B.Subtract;

  /* Saturate: '<Root>/Saturation' */
  denAccum = Tp_B.Gain2;
  u1 = Tp_P.Saturation_LowerSat;
  u2 = Tp_P.Saturation_UpperSat;
  if (denAccum > u2) {
    Tp_B.Saturation = u2;
  } else if (denAccum < u1) {
    Tp_B.Saturation = u1;
  } else {
    Tp_B.Saturation = denAccum;
  }

  /* End of Saturate: '<Root>/Saturation' */

  /* S-Function (rti_commonblock): '<S2>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* dSPACE I/O Board DS1104 #1 Unit:DAC */
  ds1104_dac_write(1, Tp_B.Saturation);
}

/* Model update function */
void Tp_update(void)
{
  /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  Tp_DW.DiscreteTransferFcn_states = Tp_DW.DiscreteTransferFcn_tmp;

  /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn1' */
  Tp_DW.DiscreteTransferFcn1_states = Tp_DW.DiscreteTransferFcn1_tmp;

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++Tp_M->Timing.clockTick0)) {
    ++Tp_M->Timing.clockTickH0;
  }

  Tp_M->Timing.taskTime0 = Tp_M->Timing.clockTick0 * Tp_M->Timing.stepSize0 +
    Tp_M->Timing.clockTickH0 * Tp_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void Tp_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)Tp_M, 0,
                sizeof(RT_MODEL_Tp_T));
  Tp_M->Timing.stepSize0 = 0.001;

  /* block I/O */
  (void) memset(((void *) &Tp_B), 0,
                sizeof(B_Tp_T));

  /* states (dwork) */
  (void) memset((void *)&Tp_DW, 0,
                sizeof(DW_Tp_T));

  /* external outputs */
  Tp_Y.Tensiongntachy = 0.0;

  {
    /* user code (registration function declaration) */
    /*Initialize global TRC pointers. */
    Tp_rti_init_trc_pointers();
  }

  /* Start for DiscretePulseGenerator: '<Root>/Pulse Generator' */
  Tp_DW.clockTickCounter = -1000;

  /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  Tp_DW.DiscreteTransferFcn_states = Tp_P.DiscreteTransferFcn_InitialStat;

  /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn1' */
  Tp_DW.DiscreteTransferFcn1_states = Tp_P.DiscreteTransferFcn1_InitialSta;
}

/* Model terminate function */
void Tp_terminate(void)
{
  /* Terminate for S-Function (rti_commonblock): '<S2>/S-Function1' */

  /* dSPACE I/O Board DS1104 #1 Unit:DAC */
  ds1104_dac_write(1, 0);
}
