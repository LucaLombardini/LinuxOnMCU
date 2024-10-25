OCD = openocd
CONFIG_XIP_PHYS_ADDR = 0x08000000 # take it from the kernel's .config: thats the same symbol!
KERNEL_BUILD_PATH = ../LinuxKernelMCU/build/stm32
BINARY_PATHNAME := $(KERNEL_BUILD_PATH)/vmlinux.bin
MCU_SPECS = arch/stm32/STM32H753ZI.cfg

# treat those names as such and not as target files
.PHONY: load_default_parameters load_kernel_parameters flash_mcu clean

load_default_parameters:
	DEFAULT_FLASH_START := $(shell grep -e FLASH_START $(MCU_SPECS) | cut -d"=" -f2)

load_kernel_parameters: load_default_parameters
	CONFIG_XIP_PHYS_ADDR := $(shell grep -e ^CONFIG_XIP_PHYS_ADDR | cut -d"=" -f2)
	FLASH_START_ADDRESS  := $(if $(CONFIG_XIP_PHYS_ADDR),$(CONFIG_XIP_PHYS_ADDR),$(DEFAULT_FLASH_START))

# Flash the MCU with your new, shiny kernel
flash_mcu: load_kernel_parameters
	$(OCD)  -f ./openocd-stlink.ocd                              \
		-c "set BINARY_PATH         $(BINARY_PATHNAME)"      \
		-c "set FLASH_START_ADDRESS $(FLASH_START_ADDRESS)" \
		-f ./flash_binary.ocd
clean:
	# tbd
