/*
 * Header file for: pwm_blinky_external_mode
 * Generated with : PLECS 4.8.2
 *                  STM32G4x 1.4.3
 * Generated on   : 5 Jun 2024 14:21:21
 */
#ifndef PLECS_HEADER_pwm_blinky_external_mode_h_
#define PLECS_HEADER_pwm_blinky_external_mode_h_

#include <stdbool.h>
#include <stdint.h>

/* Model floating point type */
typedef float pwm_blinky_external_mode_FloatType;

/* Model checksum */
extern const char * const pwm_blinky_external_mode_checksum;

/* Model error status */
extern const char * pwm_blinky_external_mode_errorStatus;


/* Model sample time */
extern const float pwm_blinky_external_mode_sampleTime;


/* Block outputs */
typedef struct
{
   float PulseGenerator;            /* pwm_blinky_external_mode/Pulse Generator */
   float SineWave;                  /* pwm_blinky_external_mode/Sine Wave */
   float Product;                   /* pwm_blinky_external_mode/Product */
} pwm_blinky_external_mode_BlockOutputs;
extern pwm_blinky_external_mode_BlockOutputs pwm_blinky_external_mode_B;

#if defined(EXTERNAL_MODE) && EXTERNAL_MODE
/* External mode signals */
#define pwm_blinky_external_mode_NumExtModeSignals 2
extern const float * const pwm_blinky_external_mode_ExtModeSignals[];
/* Tunable parameters */
#define pwm_blinky_external_mode_NumTunableParameters 2
#endif /* defined(EXTERNAL_MODE) */


/* Block parameters */
typedef struct
{
   /* Parameter 'Amplitude' of
    *  Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave'
    */
   float SineWave_Amplitude;
   /* Parameter 'Bias' of
    *  Sine Wave Generator : 'pwm_blinky_external_mode/Sine Wave'
    */
   float SineWave_Bias;
} pwm_blinky_external_mode_Parameters;
extern pwm_blinky_external_mode_Parameters pwm_blinky_external_mode_P;

/* Entry point functions */
void pwm_blinky_external_mode_initialize(void);
void pwm_blinky_external_mode_step(void);
void pwm_blinky_external_mode_terminate(void);

#endif /* PLECS_HEADER_pwm_blinky_external_mode_h_ */
