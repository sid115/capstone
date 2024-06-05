/*
 * Header file for: blinky
 * Generated with : PLECS 4.8.2
 *                  STM32G4x 1.4.3
 * Generated on   : 5 Jun 2024 13:15:11
 */
#ifndef PLECS_HEADER_blinky_h_
#define PLECS_HEADER_blinky_h_

#include <stdbool.h>
#include <stdint.h>

/* Model floating point type */
typedef float blinky_FloatType;

/* Model checksum */
extern const char * const blinky_checksum;

/* Model error status */
extern const char * blinky_errorStatus;


/* Model sample time */
extern const float blinky_sampleTime;


/* Block outputs */
typedef struct
{
   float PulseGenerator;            /* blinky/Pulse Generator */
} blinky_BlockOutputs;
extern blinky_BlockOutputs blinky_B;

#if defined(EXTERNAL_MODE) && EXTERNAL_MODE
/* External mode signals */
#define blinky_NumExtModeSignals 1
extern const float * const blinky_ExtModeSignals[];
/* Tunable parameters */
#define blinky_NumTunableParameters 0
#endif /* defined(EXTERNAL_MODE) */


/* Entry point functions */
void blinky_initialize(void);
void blinky_step(void);
void blinky_terminate(void);

#endif /* PLECS_HEADER_blinky_h_ */
