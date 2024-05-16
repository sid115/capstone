/*
 * Implementation file for: blinky
 * Generated with         : PLECS 4.8.2
 *                          STM32G4x 1.4.3
 * Generated on           : 16 May 2024 15:04:30
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
#define PLECSRunTimeError(msg) blinky_errorStatus = msg
#define blinky_UNCONNECTED 0
static uint32_t blinky_tickLo;
static int32_t blinky_tickHi;
blinky_BlockOutputs blinky_B;
blinky_ModelStates blinky_X _ALIGN;
const char * blinky_errorStatus;
const float blinky_sampleTime = 1.f;
const char * const blinky_checksum =
   "243e80b207436bb50c32280a5b93d501db2d56b4";
/* Target declarations */
#define sin sinf
#define cos cosf
extern void blinky_initHal();

void blinky_initialize(void)
{
   blinky_tickHi = 0;
   blinky_tickLo = 0;
   memset(&blinky_X, 0, sizeof(blinky_X));

   /* Target pre-initialization */
   blinky_initHal();


   /* Initialization for Delay : 'blinky/Delay' */
   blinky_X.Delay = false;
}

void blinky_step(void)
{
   if (blinky_errorStatus)
   {
      return;
   }

   /* Delay : 'blinky/Delay' */
   blinky_B.Delay = blinky_X.Delay;

   /* Logical Operator : 'blinky/Logical\nOperator' */
   blinky_B.LogicalOperator = !blinky_B.Delay;
   /* Digital Out : 'blinky/Digital Out' */
   PLXHAL_DIO_set(0, blinky_B.LogicalOperator);
   if (blinky_errorStatus)
   {
      return;
   }

   /* Update for Delay : 'blinky/Delay' */
   blinky_X.Delay = blinky_B.LogicalOperator;
}

void blinky_terminate(void)
{
}
