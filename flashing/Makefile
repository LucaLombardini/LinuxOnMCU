# Fall-back variable contents for command invocation and default values
.DEFAULT_GOAL        := install
OCD                  ?= openocd
OCD_CONNECT_SCRIPT   ?= openocd-stlink.ocd
OCD_FLASH_SCRIPT     ?= flash_binary.ocd
CONFIG_XIP_PHYS_ADDR ?= 0x08000000
KERNEL_BUILD_PATH    ?= ../LinuxKernelMCU/build/stm32
BINARY_PATHNAME      := $(KERNEL_BUILD_PATH)/vmlinux.bin
MCU_SPECS            ?= arch/stm32/STM32H753ZI.cfg

################################################################################
# treat those names as such and not as target files
.PHONY: load_default_parameters load_kernel_parameters install clean

################################################################################
# Load the default symbol values used for the flashing procedure
load_default_parameters:
	DEFAULT_FLASH_START := $(shell grep -e FLASH_START $(MCU_SPECS) | cut -d"=" -f2)

################################################################################
# Load the kernel-defined symbol values if any, otherwise use default values
load_kernel_parameters: load_default_parameters
	CONFIG_XIP_PHYS_ADDR := $(shell grep -e ^CONFIG_XIP_PHYS_ADDR | cut -d"=" -f2)
	FLASH_START_ADDRESS  := $(if $(CONFIG_XIP_PHYS_ADDR),$(CONFIG_XIP_PHYS_ADDR),$(DEFAULT_FLASH_START))

################################################################################
# Flash the MCU with your new, shiny kernel
# -f $(OCD_CONNECT_SCRIPT) : use the given interface and target to connect with
# -f $(OCD_FLASH_SCRIPT)   : use the given flash procedure description
install: load_kernel_parameters
	$(OCD)  -f $(OCD_CONNECT_SCRIPT)                            \
		-c "set BINARY_PATH         $(BINARY_PATHNAME)"     \
		-c "set FLASH_START_ADDRESS $(FLASH_START_ADDRESS)" \
		-f $(OCD_FLASH_SCRIPT)

clean:
	# tbd
