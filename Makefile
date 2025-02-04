# Flash the MCU with your new, shiny kernel
flash_mcu:
	openocd -f ./flashing/openocd-stlink.ocd -f ./flashing/flash_program.ocd
