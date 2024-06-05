/*
 * Implementation file for: blinky
 * Generated with         : PLECS 4.8.2
 *                          STM32G4x 1.4.3
 * Generated on           : 5 Jun 2024 13:15:11
 */
#include "blinky.h"
#ifndef PLECS_HEADER_blinky_h_
#error The wrong header file "blinky.h" was included. Please check your
#error include path to see whether this file name conflicts with the name
#error of another header file.
#endif /* PLECS_HEADER_blinky_h_ */
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
#define PLECSRunTimeError(msg) blinky_errorStatus = msg
static const uint32_t blinky_subTaskPeriod[1]= {
   /* [0.05, 0], [0, 0] */
   50
};
static uint32_t blinky_subTaskTick[1];
static char blinky_subTaskHit[1];
#define blinky_UNCONNECTED 0
static uint32_t blinky_D_uint32_t[1];
static uint32_t blinky_tickLo;
static int32_t blinky_tickHi;
blinky_BlockOutputs blinky_B;
#if defined(EXTERNAL_MODE) && EXTERNAL_MODE
const float * const blinky_ExtModeSignals[] = {
   &blinky_B.PulseGenerator
};
#endif /* defined(EXTERNAL_MODE) */
const char * blinky_errorStatus;
const float blinky_sampleTime = 0.001f;
const char * const blinky_checksum =
   "8c69f7b3eb38863f2e286b5ac8b0413025785326";
/* Target declarations */
#define sin sinf
#define cos cosf
extern void blinky_initHal();

void blinky_initialize(void)
{
   blinky_tickHi = 0;
   blinky_tickLo = 0;
   /* Initialize sub-task tick counters */
   blinky_subTaskTick[0] = 0;       /* [0, 0], [0.05, 0] */


   /* Target pre-initialization */
   blinky_initHal();


   /* Initialization for Pulse Generator : 'blinky/Pulse\nGenerator' */
   blinky_D_uint32_t[0] = 0;
}

void blinky_step(void)
{
   if (blinky_errorStatus)
   {
      return;
   }
   {
      size_t i;
      for (i = 0; i < 1; ++i)
      {
         blinky_subTaskHit[i] = (blinky_subTaskTick[i] == 0);
      }
   }
   if (blinky_subTaskHit[0])
   {
      /* Pulse Generator : 'blinky/Pulse\nGenerator' */
      blinky_B.PulseGenerator = blinky_D_uint32_t[0] < 1 ? 1.f : 0.f;
   }

   /* Digital Out : 'blinky/Digital Out' */
   PLXHAL_DIO_set(0, blinky_B.PulseGenerator);
   if (blinky_errorStatus)
   {
      return;
   }
   if (blinky_subTaskHit[0])
   {
      /* Update for Pulse Generator : 'blinky/Pulse\nGenerator' */
      blinky_D_uint32_t[0] += 1;
      if (blinky_D_uint32_t[0] > 1)
      {
         blinky_D_uint32_t[0] = 0;
      }
   }

   /* Increment sub-task tick counters */
   {
      size_t i;
      for (i = 0; i < 1; ++i)
      {
         blinky_subTaskTick[i]++;
         if (blinky_subTaskTick[i] >= blinky_subTaskPeriod[i])
         {
            blinky_subTaskTick[i] = 0;
         }
      }
   }
}

void blinky_terminate(void)
{
}
