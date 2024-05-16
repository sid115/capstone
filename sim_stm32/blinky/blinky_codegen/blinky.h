/*
 * Header file for: blinky
 * Generated with : PLECS 4.8.2
 *                  STM32G4x 1.4.3
 * Generated on   : 16 May 2024 15:04:30
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


/*
 * Model states */
typedef struct
{
   bool Delay;                      /* blinky/Delay */
} blinky_ModelStates;
extern blinky_ModelStates blinky_X;


/* Block outputs */
typedef struct
{
   bool Delay;                      /* blinky/Delay */
   bool LogicalOperator;            /* blinky/Logical Operator */
} blinky_BlockOutputs;
extern blinky_BlockOutputs blinky_B;

/* Entry point functions */
void blinky_initialize(void);
void blinky_step(void);
void blinky_terminate(void);

#endif /* PLECS_HEADER_blinky_h_ */
