/*
 * Implementation file for: pwm_blinky_external_mode
 * Generated with         : PLECS 4.8.2
 *                          STM32G4x 1.4.3
 * Generated on           : 5 Jun 2024 14:21:21
 */
#include "pwm_blinky_external_mode.h"
#ifndef PLECS_HEADER_pwm_blinky_external_mode_h_
#error The wrong header file "pwm_blinky_external_mode.h" was included.
#error Please check your include path to see whether this file name
#error conflicts with the name of another header file.
#endif /* PLECS_HEADER_pwm_blinky_external_mode_h_ */
#if defined(__GNUC__) && (__GNUC__ > 4)
#   define _ALIGNMENT 16
#   define _RESTRICT __restrict
#   define _ALIGN __attribute__((aligned(_ALIGNMENT)))
#   if defined(__clang__)
#      if __has_builtin(__builtin_assume_aligned)
#         define _ASSUME_ALIGNED(a) __builtin_assume_aligned(a, _ALIGNMENT)
#      else
#         define _ASSUME_ALIGNED(a) a
#      endif
#   else
#      define _ASSUME_ALIGNED(a) __builtin_assume_aligned(a, _ALIGNMENT)
#   endif
#else
#   ifndef _RESTRICT
#      define _RESTRICT
#   endif
#   ifndef _ALIGN
#      define _ALIGN
#   endif
#   ifndef _ASSUME_ALIGNED
#      define _ASSUME_ALIGNED(a) a
#   endif
#endif
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>
#include "plx_hal.h"
#include <stdlib.h>
#define PLECSRunTimeError(msg) pwm_blinky_external_mode_errorStatus = msg
static const uint32_t pwm_blinky_external_mode_subTaskPeriod[1]= {
   /* [1, 0], [0, 0] */
   1000
};
static uint32_t pwm_blinky_external_mode_subTaskTick[1];
static char pwm_blinky_external_mode_subTaskHit[1];
#define pwm_blinky_external_mode_UNCONNECTED 0
static float pwm_blinky_external_mode_D_float[2];
static uint32_t pwm_blinky_external_mode_D_uint32_t[1];
static uint32_t pwm_blinky_external_mode_tickLo;
static int32_t pwm_blinky_external_mode_tickHi;
pwm_blinky_external_mode_BlockOutputs pwm_blinky_external_mode_B;
#if defined(EXTERNAL_MODE) && EXTERNAL_MODE
const float * const pwm_blinky_external_mode_ExtModeSignals[] = {
   &pwm_blinky_external_mode_B.PulseGenerator,
   &pwm_blinky_external_mode_B.Product
};
#endif /* defined(EXTERNAL_MODE) */
pwm_blinky_external_mode_Parameters pwm_blinky_external_mode_P = {
   /* Parameter 'Amplitude' of
    *  Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave'
    */
   1.f,
   /* Parameter 'Bias' of
    *  Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave'
    */
   1.f
};
const char * pwm_blinky_external_mode_errorStatus;
const float pwm_blinky_external_mode_sampleTime = 0.001f;
const char * const pwm_blinky_external_mode_checksum =
   "5403e23ceec67f7a0d571f7bd5530f19725cfe53";
/* Target declarations */
#define sin sinf
#define cos cosf
extern void pwm_blinky_external_mode_initHal();

void pwm_blinky_external_mode_initialize(void)
{
   pwm_blinky_external_mode_tickHi = 0;
   pwm_blinky_external_mode_tickLo = 0;
   /* Initialize sub-task tick counters */
   pwm_blinky_external_mode_subTaskTick[0] = 0; /* [0, 0], [1, 0] */


   /* Target pre-initialization */
   pwm_blinky_external_mode_initHal();


   /* Initialization for Pulse Generator : 'pwm_blinky_external_mode/Pulse\nGenerator' */
   pwm_blinky_external_mode_D_uint32_t[0] = 0;

   /* Initialization for Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave' */
   pwm_blinky_external_mode_D_float[0] = sinf(10.f*0.f);
   pwm_blinky_external_mode_D_float[1] = cosf(10.f*0.f);
}

void pwm_blinky_external_mode_step(void)
{
   if (pwm_blinky_external_mode_errorStatus)
   {
      return;
   }
   {
      size_t i;
      for (i = 0; i < 1; ++i)
      {
         pwm_blinky_external_mode_subTaskHit[i] =
            (pwm_blinky_external_mode_subTaskTick[i] == 0);
      }
   }
   if (pwm_blinky_external_mode_subTaskHit[0])
   {
      /* Pulse Generator : 'pwm_blinky_external_mode/Pulse\nGenerator' */
      pwm_blinky_external_mode_B.PulseGenerator =
         pwm_blinky_external_mode_D_uint32_t[0] < 1 ? 1.f : 0.f;
   }
   /* Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave' */
   pwm_blinky_external_mode_B.SineWave =
      pwm_blinky_external_mode_P.SineWave_Bias +
      pwm_blinky_external_mode_P.SineWave_Amplitude *
      (1.f*pwm_blinky_external_mode_D_float[0] + 0.f*
    pwm_blinky_external_mode_D_float[1]);

   /* Product : 'pwm_blinky_external_mode/Product'
    * incorporates
    *  Digital In : 'pwm_blinky_external_mode/Digital In'
    */
   pwm_blinky_external_mode_B.Product = pwm_blinky_external_mode_B.SineWave *
                                        (PLXHAL_DIO_get(0));

   /* PWM  : 'pwm_blinky_external_mode/PWM' */
   PLXHAL_TIM_setDuty(0, 1, pwm_blinky_external_mode_B.Product);
   /* Digital Out : 'pwm_blinky_external_mode/Digital Out' */
   PLXHAL_DIO_set(0, pwm_blinky_external_mode_B.PulseGenerator);
   if (pwm_blinky_external_mode_errorStatus)
   {
      return;
   }
   if (pwm_blinky_external_mode_subTaskHit[0])
   {
      /* Update for Pulse Generator : 'pwm_blinky_external_mode/Pulse\nGenerator' */
      pwm_blinky_external_mode_D_uint32_t[0] += 1;
      if (pwm_blinky_external_mode_D_uint32_t[0] > 1)
      {
         pwm_blinky_external_mode_D_uint32_t[0] = 0;
      }
   }
   /* Update for Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave' */
   {
      float scaling, scaledX, scaledY;
      scaling = 1.f +
                (0.5f *
       (pwm_blinky_external_mode_D_float[0]*
       pwm_blinky_external_mode_D_float[0] +
       pwm_blinky_external_mode_D_float[1]*
       pwm_blinky_external_mode_D_float[1] - 1.f));
      scaledX = pwm_blinky_external_mode_D_float[0] / scaling;
      scaledY = pwm_blinky_external_mode_D_float[1] / scaling;
      pwm_blinky_external_mode_D_float[0] = 0.99995f * scaledX +
                                            0.00999983333f * scaledY;
      pwm_blinky_external_mode_D_float[1] = -0.00999983333f * scaledX +
                                            0.99995f * scaledY;
   }

   /* Update for PWM  : 'pwm_blinky_external_mode/PWM' */
   PLXHAL_TIM_enablePwmOutputs(0);
   /* Increment sub-task tick counters */
   {
      size_t i;
      for (i = 0; i < 1; ++i)
      {
         pwm_blinky_external_mode_subTaskTick[i]++;
         if (pwm_blinky_external_mode_subTaskTick[i] >=
             pwm_blinky_external_mode_subTaskPeriod[i])
         {
            pwm_blinky_external_mode_subTaskTick[i] = 0;
         }
      }
   }
}

void pwm_blinky_external_mode_terminate(void)
{
}
