/*
 * Hardware configuration file for: STM32G4x
 * Generated with                 : PLECS 4.8.2
 * Generated on                   : Wed Jun  5 13:15:11 2024
 */

/* HAL Includes */
#include "plx_hal.h"
#include "FreeRTOSConfig.h"
#include "plx_dispatcher.h"
#include "plx_gpio.h"
#include "pil.h"
#include "blinky.h"
#include "plx_uart.h"
#include "plx_dio.h"
#include "plx_timer.h"

/* HAL Declarations */
__STATIC_INLINE void SystemClock_Config(void)
{
   RCC_ClkInitTypeDef RCC_ClkInitStruct = {
      0
   };
   RCC_OscInitTypeDef RCC_OscInitStruct = {
      0
   };
   RCC_PeriphCLKInitTypeDef PeriphClkInit = {
      0
   };
   // enable voltage range 1 boost mode for frequency above 150 Mhz
   __HAL_RCC_PWR_CLK_ENABLE();
   HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1_BOOST);
   __HAL_RCC_PWR_CLK_DISABLE();
   // activate PLL with HSI as source
   RCC_OscInitStruct.OscillatorType      = RCC_OSCILLATORTYPE_HSI;
   RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
   RCC_OscInitStruct.HSIState            = RCC_HSI_ON;
   RCC_OscInitStruct.PLL.PLLState        = RCC_PLL_ON;
   RCC_OscInitStruct.PLL.PLLSource       = RCC_PLLSOURCE_HSI;
   RCC_OscInitStruct.PLL.PLLM            = RCC_PLLM_DIV4;
   RCC_OscInitStruct.PLL.PLLN            = 85;
   RCC_OscInitStruct.PLL.PLLP            = RCC_PLLP_DIV2;
   RCC_OscInitStruct.PLL.PLLQ            = RCC_PLLQ_DIV2;
   RCC_OscInitStruct.PLL.PLLR            = RCC_PLLR_DIV2;
   if(HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
   {
      PLX_ASSERT(0);
   }

   // select PLL as system clock source and configure the HCLK, PCLK1 and PCLK2 clocks dividers */
   RCC_ClkInitStruct.ClockType           =
      (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | \
       RCC_CLOCKTYPE_PCLK1 |
       RCC_CLOCKTYPE_PCLK2);
   RCC_ClkInitStruct.SYSCLKSource        = RCC_SYSCLKSOURCE_PLLCLK;
   RCC_ClkInitStruct.AHBCLKDivider       = RCC_SYSCLK_DIV1;
   RCC_ClkInitStruct.APB1CLKDivider      = RCC_HCLK_DIV1;
   RCC_ClkInitStruct.APB2CLKDivider      = RCC_HCLK_DIV1;
   if(HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
   {
      PLX_ASSERT(0);
   }

   // initialize the peripherals clocks
   PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_RTC|RCC_PERIPHCLK_ADC12|
                                        RCC_PERIPHCLK_ADC345|
                                        RCC_PERIPHCLK_FDCAN;
   PeriphClkInit.Adc12ClockSelection = RCC_ADC12CLKSOURCE_PLL;
   PeriphClkInit.Adc345ClockSelection = RCC_ADC345CLKSOURCE_PLL;
   PeriphClkInit.RTCClockSelection = RCC_RTCCLKSOURCE_LSI;
   PeriphClkInit.FdcanClockSelection = RCC_FDCANCLKSOURCE_PCLK1;
   if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
   {
      PLX_ASSERT(0);
   }

}

PIL_Obj_t PilObj;
PIL_Handle_t PilHandle = 0;
PLX_UART_Obj_t UartObj;
PLX_UART_Handle_t UartHandle;
uint16_t ScopeBuffer[1004] /*__attribute__((aligned(16)))*/;
extern void PIL_setAndConfigScopeBuffer(PIL_Handle_t aPilHandle,
                                        uint16_t* aBufPtr, uint16_t aBufSize,
                                        uint16_t aMaxTraceWidthInWords);
extern const char * const blinky_checksum;

// external mode helper symbols

PIL_CONFIG_DEF(uint32_t, ExtMode_targetFloat_Size, sizeof(blinky_FloatType));

PIL_CONFIG_DEF(uint32_t, ExtMode_targetPointer_Size,
               sizeof(blinky_FloatType*));

PIL_CONFIG_DEF(uint32_t, ExtMode_sampleTime_Ptr,
               (uint32_t)&blinky_sampleTime);

PIL_CONFIG_DEF(uint32_t, ExtMode_checksum_Ptr, (uint32_t)&blinky_checksum);

#if defined(blinky_NumTunableParameters) && (blinky_NumTunableParameters > 0)

PIL_CONFIG_DEF(uint32_t, ExtMode_P_Ptr, (uint32_t)&blinky_P);

PIL_CONFIG_DEF(uint32_t, ExtMode_P_Size,
               (uint32_t)blinky_NumTunableParameters);

#endif

#if defined(blinky_NumExtModeSignals) && (blinky_NumExtModeSignals > 0)

PIL_CONFIG_DEF(uint32_t, ExtMode_ExtModeSignals_Ptr,
               (uint32_t)&blinky_ExtModeSignals[0]);

PIL_CONFIG_DEF(uint32_t, ExtMode_ExtModeSignals_Size,
               (uint32_t)blinky_NumExtModeSignals);

#endif


#define CODE_GUID {0x09, 0x3c, 0x97, 0x5e, 0xdb, 0x2d, 0xb8, 0x40};
PIL_CONST_DEF(unsigned char, Guid[], CODE_GUID);
PIL_CONST_DEF(unsigned char, CompiledDate[], "06/05/2024 01:15 PM");
PIL_CONST_DEF(unsigned char, CompiledBy[], "PLECS Coder");
PIL_CONST_DEF(uint16_t, FrameworkVersion, PIL_FRAMEWORK_VERSION);
PIL_CONST_DEF(char, FirmwareDescription[], "STM32 Project");
PIL_CONST_DEF(uint16_t, StationAddress, 0);
PIL_CONST_DEF(uint32_t, BaudRate, 14400);
static void SciPoll(PIL_Handle_t aHandle)
{
   if(PLX_UART_breakOccurred(UartHandle))
   {
      PLX_UART_reset(UartHandle);
   }
   while(PLX_UART_rxReady(UartHandle))
   {
      // assuming that there will be a "break" when FIFO is empty
      PIL_SERIAL_IN(aHandle, (int16_t)PLX_UART_getChar(UartHandle));
   }
   int16_t ch;
   if(!PLX_UART_txIsBusy(UartHandle))
   {
      if(PIL_SERIAL_OUT(aHandle, &ch))
      {
         PLX_UART_putChar(UartHandle, ch);
      }
   }
}


PLX_DIO_Handle_t DoutHandles[1];
PLX_DIO_Obj_t DoutObj[1];
void PLXHAL_DIO_set(uint16_t aHandle, bool aVal)
{
   PLX_DIO_set(DoutHandles[aHandle], aVal);
}
PLX_TIM_Handle_t TimerHandles[1];
PLX_TIM_Obj_t TimerObj[1];
void TIM3_IRQHandler(void)
{
   if (PLX_TIM_processInt(TimerHandles[0]))
   {
      DISPR_dispatch();
   }
}


bool blinky_checkOverrun()
{
   return HAL_NVIC_GetPendingIRQ(TIM3_IRQn);
}

extern PIL_Handle_t PilHandle;
DISPR_TaskObj_t TaskObj[1];
extern void blinky_step();
extern void blinky_enableTasksInterrupt();
extern void blinky_syncTimers();
extern bool blinky_checkOverrun();
static bool Tasks(uint16_t aTaskId)
{
   bool overrun = false;
   blinky_step();
   DISPR_sampleScopes();
   overrun = blinky_checkOverrun();
   return overrun;
}



/* Interrupt Enable Code */
void blinky_enableTasksInterrupt(void)
{

   HAL_NVIC_SetPriority(TIM3_IRQn,
                        configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY, 0);
   HAL_NVIC_EnableIRQ(TIM3_IRQn);
}

/* Timer Synchronization Code */
void blinky_syncTimers(void)
{
   LL_TIM_EnableCounter(TIM3);
}

/* Background tasks */
void blinky_background(void)
{

}
/* HAL Initialization Code */
static bool HalInitialized = false;
void blinky_initHal()
{
   if(HalInitialized == true)
   {
      return;
   }
   HalInitialized = true;
   // Pre init code
   SystemClock_Config();
   SystemCoreClockUpdate();

   PLX_ASSERT(SystemCoreClock == 170000000L);
   PLX_ASSERT( HAL_RCC_GetPCLK1Freq() == 170000000L);

   {
      // early system configuration
      PLX_GPIO_sinit();
   }
   PilHandle = PIL_init(&PilObj, sizeof(PilObj));
   PIL_setGuid(PilHandle, PIL_GUID_PTR);
   PIL_setChecksum(PilHandle, blinky_checksum);
   PIL_setAndConfigScopeBuffer(PilHandle, (uint16_t *)&ScopeBuffer, 1004, 2);
   PIL_setSerialComCallback(PilHandle, (PIL_CommCallbackPtr_t)SciPoll);
   UartHandle = PLX_UART_init(&UartObj, sizeof(UartObj));
   PLX_UART_configure(UartHandle, PLX_USART2);
   (void)PLX_UART_setupPort(UartHandle, 14400);

   {
      int i;
      for(i=0; i < 1; i++)
      {
         DoutHandles[i] = PLX_DIO_init(&DoutObj[i], sizeof(DoutObj[i]));
      }
   }

   PLX_DIO_configureOut(DoutHandles[0], PLX_PORTA, 5, true);
   {
      PLX_TIM_sinit();
      int i;
      for(i=0; i < 1; i++)
      {
         TimerHandles[i] = PLX_TIM_init(&TimerObj[i], sizeof(TimerObj[i]));
      }
   }

   {

      LL_TIM_InitTypeDef initStruct = {
         0
      };
      initStruct.Prescaler =  4-1;
      initStruct.Autoreload = 42500-1;
      initStruct.CounterMode = LL_TIM_COUNTERMODE_UP;
      initStruct.ClockDivision = LL_TIM_CLOCKDIVISION_DIV1;
      initStruct.RepetitionCounter = 0;

      PLX_TIM_setup(TimerHandles[0], PLX_TIM3, &initStruct, 0, 1000.000000);

      TIM_TypeDef* handle = PLX_TIM_getStmLLHandle(TimerHandles[0]);
      LL_TIM_SetSlaveMode(handle, LL_TIM_SLAVEMODE_DISABLED);
      LL_TIM_SetTriggerInput(handle, LL_TIM_TS_ITR0);
      LL_TIM_SetTriggerOutput(handle, LL_TIM_TRGO_UPDATE);
      LL_TIM_SetTriggerOutput2(handle, LL_TIM_TRGO2_RESET);
      LL_TIM_DisableMasterSlaveMode(handle);

   }
   DISPR_sinit();
   DISPR_configure((uint32_t)(170000), PilHandle, &TaskObj[0],
                   sizeof(TaskObj)/sizeof(DISPR_TaskObj_t));
   DISPR_registerIdleTask(&blinky_background);
   DISPR_registerSyncCallback(&blinky_syncTimers);
   DISPR_registerEnableInterrupt(&blinky_enableTasksInterrupt);
   DISPR_setPowerupDelay(1);
   {
      // Task 0 at 1.000000e+03 Hz
      DISPR_registerTask(0, &Tasks, 170000L);
   }

   // Post init code (for modules that depend on other modules)

   {
      // late system configuration
      {
         LL_GPIO_InitTypeDef gpioInit = {
            0
         };
         gpioInit.Pin = LL_GPIO_PIN_5;
         gpioInit.Mode = LL_GPIO_MODE_OUTPUT;
         gpioInit.Speed = LL_GPIO_SPEED_FREQ_HIGH;
         gpioInit.OutputType = LL_GPIO_OUTPUT_PUSHPULL;
         gpioInit.Pull = LL_GPIO_PULL_NO;
         gpioInit.Alternate = LL_GPIO_AF_0;
         PLX_GPIO_setGpioConfig(PLX_PORTA, &gpioInit);
      }

      {
         LL_GPIO_InitTypeDef gpioInit = {
            0
         };
         gpioInit.Pin = LL_GPIO_PIN_2;
         gpioInit.Mode = LL_GPIO_MODE_ALTERNATE;
         gpioInit.Speed = LL_GPIO_SPEED_FREQ_HIGH;
         gpioInit.OutputType = LL_GPIO_OUTPUT_PUSHPULL;
         gpioInit.Pull = LL_GPIO_PULL_NO;
         gpioInit.Alternate = LL_GPIO_AF_7;
         PLX_GPIO_setGpioConfig(PLX_PORTA, &gpioInit);
      }

      {
         LL_GPIO_InitTypeDef gpioInit = {
            0
         };
         gpioInit.Pin = LL_GPIO_PIN_3;
         gpioInit.Mode = LL_GPIO_MODE_ALTERNATE;
         gpioInit.Speed = LL_GPIO_SPEED_FREQ_HIGH;
         gpioInit.OutputType = LL_GPIO_OUTPUT_PUSHPULL;
         gpioInit.Pull = LL_GPIO_PULL_NO;
         gpioInit.Alternate = LL_GPIO_AF_7;
         PLX_GPIO_setGpioConfig(PLX_PORTA, &gpioInit);
      }

   }
   PLX_TIM_start(TimerHandles[0], 0);
}
