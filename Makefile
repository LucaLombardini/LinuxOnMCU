.DEFAULT_GOAL        := all
TARGET_CODENAME      ?= stm32
ARCH                 ?= arm
CROSS_COMPILE        ?= arm-linux-gnueabihf-
PATH_TO_KSOURCE_TREE ?= LinuxKernelMCU
PATH_TO_BUILT_KERNEL ?= $(PATH_TO_KSOURCE_TREE)/build/$(TARGET_CODENAME)

.PHONY: all flash_mcu clean

# $(MAKE) -f <path-to-sub-makefile> <[VAR=$(VAR) ...]> <target-of-sub-makefile>

################################################################################
# Build the kernel
all:
	$(make) -f $(PATH_TO_KSOURCE_TREE)/Makefile ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(PATH_TO_BUILT_KERNEL) -j$(shell nproc)

# Flash the MCU with your new, shiny kernel
flash_mcu:
	$(MAKE) -f flashing/Makefile install

clean:
	# tbd
