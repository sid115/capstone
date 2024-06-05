#   Copyright (c) 2020 by Plexim GmbH
#   All rights reserved.
#
#   A free license is granted to anyone to use this software for any legal
#   non safety-critical purpose, including commercial applications, provided
#   that:
#   1) IT IS NOT USED TO DIRECTLY OR INDIRECTLY COMPETE WITH PLEXIM, and
#   2) THIS COPYRIGHT NOTICE IS PRESERVED in its entirety.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.

include pwm_blinky_external_mode_sources.mk

TSP_VERSION=1.4.3
TARGET_ROOT=C:/Capstone/target_support_packages/tsp_stm32/gcc/g4
TOOLS_PATH=C:/Capstone/target_support_packages/tsp_stm32/bin/gcc-arm-none-eabi
BIN_DIR=./output_STM32G474RE
OUT_NAME=pwm_blinky_external_mode
MAKEFILE=pwm_blinky_external_mode.mk
LINKFILE=pwm_blinky_external_mode.lkf
INSTALL_DIR=./
BASE_NAME=pwm_blinky_external_mode
PROGRAMMER_CMD=C:/Capstone/target_support_packages/tsp_stm32/bin/c2p-gdb/c2p-gdb
PROGRAMMER_ARGS=load --server-cmd "\"C:/Capstone/target_support_packages/tsp_stm32/bin/openocd/bin/openocd\" -s \"C:/Capstone/target_support_packages/tsp_stm32/bin/openocd/share/openocd/scripts\" -f board/stm32g431.cfg" --server-start-delay 1000 --port 3333 --nvic 0x8000000
TASK_SCHEDULER=-DPLX_BARE_METAL_SCHEDULER
HSE_VALUE=

include pwm_blinky_external_mode_options.mk

##############################################################

C_SOURCE_FILES=\
$(BASE_NAME)_hal.c \
$(BASE_NAME)_main.c\
syscalls.c \
dispatcher_stm32g4xx.c \
gpio_stm32g4xx.c \
dio_stm32g4xx.c \
adc_stm32g4xx.c \
tim_stm32g4xx.c \
trig_stm32g4xx.c \
hrtim_stm32g4xx.c \
dac_stm32g4xx.c \
comp_stm32g4xx.c \
opamp_stm32g4xx.c \
hrtim_pcc_stm32g4xx.c \
uart_stm32g4xx.c \
canbus_stm32g4xx.c \
spi_stm32g4xx.c \
ctr_stm32g4xx.c \
power.c \
system_stm32g4xx.c \
stm32g4xx_hal_cortex.c \
stm32g4xx_hal_exti.c \
stm32g4xx_hal_gpio.c \
stm32g4xx_hal_pwr_ex.c \
stm32g4xx_hal_pwr.c \
stm32g4xx_hal_rcc.c \
stm32g4xx_hal_rcc_ex.c \
stm32g4xx_hal_tim_ex.c \
stm32g4xx_hal_tim.c \
stm32g4xx_hal_uart_ex.c \
stm32g4xx_hal_uart.c \
stm32g4xx_hal.c \
stm32g4xx_hal_fdcan.c \
stm32g4xx_ll_tim.c \
stm32g4xx_ll_dac.c \
stm32g4xx_ll_comp.c \
stm32g4xx_ll_opamp.c \
stm32g4xx_ll_adc.c \
stm32g4xx_ll_gpio.c \
stm32g4xx_ll_spi.c 

ifeq ($(TASK_SCHEDULER), )
C_FREERTOS_SOURCE_FILES=\
croutine.c \
event_groups.c \
list.c \
queue.c \
stream_buffer.c \
tasks.c \
timers.c \
heap_4.c \
port.c \
cmsis_os2.c
endif 

ifdef C_FREERTOS_SOURCE_FILES
C_SOURCE_FILES += $(C_FREERTOS_SOURCE_FILES)
endif

ASM_SOURCE_FILES=\


ifdef PART_ASM_SOURCE_FILES
ASM_SOURCE_FILES += $(PART_ASM_SOURCE_FILES)
endif

HFILES=\
$(MAKEFILE)

##############################################################
space:=
space+=
# for MacOS - NOTE: not tolerant to leading space or already escaped spaces '\ '
EscapeSpaces=$(subst $(space),\$(space),$(1))
FlipSlashesBack=$(subst /,\,$(1))

ifeq ($(OS),Windows_NT)
# Windows
SHELL := cmd.exe
FixPath=$(call FlipSlashesBack,$(1))
ClearFile=del /F /Q "$(call FlipSlashesBack,$(1))"
ClearDir=del /F /Q "$(call FlipSlashesBack,$(1))\*.*"
MoveFile=move /Y "$(call FlipSlashesBack,$(1))" "$(call FlipSlashesBack,$(2))"
CopyFile=copy /Y "$(call FlipSlashesBack,$(1))" "$(call FlipSlashesBack,$(2))"

else
# Linux style
FixPath = $(1)
ClearFile=rm -Rf $(call EscapeSpaces,$(1))
ClearDir=rm -Rf $(call EscapeSpaces,$(1))/*
MoveFile=mv $(call EscapeSpaces,$(1)) $(call EscapeSpaces,$(2))
CopyFile=cp $(call EscapeSpaces,$(1)) $(call EscapeSpaces,$(2))

endif 

CGT_EXE_PATH=$(TOOLS_PATH)/bin
CGT_LIB_PATH=$(TOOLS_PATH)/lib
CGT_INC_PATH=$(TOOLS_PATH)/include

BIN_DIR_OS=$(call FixPath,$(BIN_DIR))

# common settings
COMMON_OPTIONS=\
-mcpu=cortex-m4 \
-mthumb \
-mfloat-abi=softfp \
-mfpu=fpv4-sp-d16 \
-Ofast \
-ffunction-sections \
-g \
--specs=nano.specs

COMMON_DEFINES=\
-DUSE_HAL_DRIVER \
-DUSE_FULL_LL_DRIVER


# compiler
C_OPTIONS=\
$(COMMON_OPTIONS)\
$(COMMON_DEFINES)\
$(HSE_VALUE)\
$(TASK_SCHEDULER)\
-DBASE_NAME=$(BASE_NAME)\
-DEXTERNAL_MODE \
-DNO_PREP_TOOL \
-I"$(TARGET_ROOT)/app" \
-I"$(TARGET_ROOT)/../pil" \
-I"$(TARGET_ROOT)/../inc" \
-I"$(TARGET_ROOT)/inc_impl" \
-I"$(TARGET_ROOT)/system" \
-I"$(TARGET_ROOT)/system/cmsis/include" \
-I"$(TARGET_ROOT)/system/driver/inc" \
-I"$(TARGET_ROOT)/system/freertos/include" \
-I"$(TARGET_ROOT)/system/freertos/portable/GCC/ARM_CM4F" \
-I"$(TARGET_ROOT)/system/freertos/CMSIS_RTOS_V2" \
-I"$(TARGET_ROOT)/cg" \
-I"." \
-std=gnu11 \
-MMD \
-MP \


#-Wa,-adhlns="$@.lst"

ifdef PART_C_OPTIONS
C_OPTIONS += $(PART_C_OPTIONS)
endif

# assembler
A_OPTIONS=\
$(COMMON_OPTIONS)\
$(COMMON_DEFINES)\
$(HSE_VALUE)\
-x assembler-with-cpp \
-MMD \
-MP 

ifdef PART_A_OPTIONS
A_OPTIONS += $(PART_A_OPTIONS)
endif

# linker
L_OPTIONS=\
$(COMMON_OPTIONS)\
-Xlinker \
--gc-sections \
-L"$(TARGET_ROOT)/../pil" \
-lpil \
-Wl,--print-memory-usage \



ifdef PART_L_OPTIONS
L_OPTIONS += $(PART_L_OPTIONS)
endif

C_OBJFILES=$(patsubst %.c, $(BIN_DIR)/%.o, $(C_SOURCE_FILES)) $(patsubst %.c, $(BIN_DIR)/%.o, $(SOURCE_FILES))
ASM_OBJFILES=$(patsubst %.S, $(BIN_DIR)/%.o, $(ASM_SOURCE_FILES))
DEPENDFILES=$(patsubst %.c, $(BIN_DIR)/%.d, $(C_SOURCE_FILES)) $(patsubst %.c, $(BIN_DIR)/%.d, $(SOURCE_FILES))

OBJFILES=$(C_OBJFILES) $(ASM_OBJFILES)

# make all variables available to sub-makes
export

# Top level 
##########################################################################
all:
ifneq ($(wildcard $(BIN_DIR_OS)),  $(BIN_DIR_OS))
	"$(MAKE)" -f $(MAKEFILE) clean
endif
	"$(MAKE)" -f $(MAKEFILE) $(INSTALL_DIR)/$(OUT_NAME).elf
	
# Download
##########################################################################
ifneq ($(and $(PROGRAMMER_CMD),$(PROGRAMMER_CMD)),)
download: $(BIN_DIR)/$(OUT_NAME).elf
	"$(PROGRAMMER_CMD)" $(PROGRAMMER_ARGS) $(BIN_DIR)/$(OUT_NAME).elf
else
download:
	@echo "Download not configured."
endif 

# Print size information
##########################################################################
printsize: $(BIN_DIR)/$(OUT_NAME).elf
	"$(CGT_EXE_PATH)"/arm-none-eabi-gcc-nm --print-size --size-sort --defined-only --radix=d $(BIN_DIR)/$(OUT_NAME).elf | tail -30

# Linker
##########################################################################
$(INSTALL_DIR)/$(OUT_NAME).elf:  $(BIN_DIR)/$(OUT_NAME).elf
					$(call CopyFile,$(BIN_DIR)/$(OUT_NAME).elf,$(INSTALL_DIR)/$(OUT_NAME).elf)


$(BIN_DIR)/$(OUT_NAME).elf: 	$(OBJFILES)
					"$(CGT_EXE_PATH)"/arm-none-eabi-gcc -o $(BIN_DIR)/$(OUT_NAME).elf $(OBJFILES) $(L_OPTIONS) -Wl,-Map,$(BIN_DIR)/$(OUT_NAME).map

# Include dependency files
##########################################################################

-include ($(DEPENDFILES))
$(DEPENDFILES): $(MAKEFILE)
	$(call ClearFile,$(BIN_DIR)/*.d)

# Implicit Rules for generated files
##########################################################################
$(BIN_DIR)/%.o:		%.c	$(HFILES)
					"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$(BIN_DIR)/$*.d -MT$(BIN_DIR)/$*.o -c -o $(BIN_DIR)/$*.o $<

# Explicit rules (we must use explicit rules to allow spaces in $(TARGET_ROOT))
##########################################################################
$(BIN_DIR)/startup_stm32g431rbtx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/cmsis/gcc/src/startup_stm32g431rbtx.S $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(A_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"
						
$(BIN_DIR)/startup_stm32g474retx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/cmsis/gcc/src/startup_stm32g474retx.S $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(A_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/main.o:	$(call EscapeSpaces,$(TARGET_ROOT))/app/main.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/syscalls.o:	$(call EscapeSpaces,$(TARGET_ROOT))/app/syscalls.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/dispatcher_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/dispatcher_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/gpio_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/gpio_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/dio_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/dio_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/adc_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/adc_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/tim_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/tim_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/trig_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/trig_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/hrtim_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/hrtim_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/dac_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/dac_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/comp_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/comp_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/opamp_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/opamp_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/hrtim_pcc_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/hrtim_pcc_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/uart_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/uart_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/canbus_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/canbus_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/spi_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/spi_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/ctr_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/ctr_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"
	
$(BIN_DIR)/power.o:	$(call EscapeSpaces,$(TARGET_ROOT))/src/power.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/system_stm32g4xx.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/cmsis/system_stm32g4xx.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_cortex.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_cortex.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_exti.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_exti.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_gpio.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_gpio.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_pwr_ex.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_pwr_ex.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"	

$(BIN_DIR)/stm32g4xx_hal_pwr.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_pwr.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_rcc.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_rcc.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_rcc_ex.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_rcc_ex.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"	

$(BIN_DIR)/stm32g4xx_hal_tim_ex.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_tim_ex.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_tim.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_tim.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_uart_ex.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_uart_ex.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_uart.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_uart.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_hal_fdcan.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_hal_fdcan.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_tim.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_tim.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_dac.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_dac.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_comp.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_comp.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_opamp.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_opamp.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_adc.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_adc.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stm32g4xx_ll_gpio.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_gpio.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"	

$(BIN_DIR)/stm32g4xx_ll_spi.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/driver/src/stm32g4xx_ll_spi.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

ifeq ($(TASK_SCHEDULER), )				

$(BIN_DIR)/croutine.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/croutine.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/event_groups.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/event_groups.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/list.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/list.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/queue.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/queue.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/stream_buffer.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/stream_buffer.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/tasks.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/tasks.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/timers.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/timers.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/cmsis_os2.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/CMSIS_RTOS_V2/cmsis_os2.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/heap_4.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/portable/MemMang/heap_4.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

$(BIN_DIR)/port.o:	$(call EscapeSpaces,$(TARGET_ROOT))/system/freertos/portable/GCC/ARM_CM4F/port.c $(HFILES)
						"$(CGT_EXE_PATH)"/arm-none-eabi-gcc $(C_OPTIONS) -MF$*.d -MT$*.o -c -o $*.o "$<"

endif

##########################################################################
clean:
ifeq ($(wildcard $(BIN_DIR_OS)),  $(BIN_DIR_OS))
		$(call ClearDir,$(BIN_DIR_OS))
else
		mkdir $(BIN_DIR_OS)
endif
