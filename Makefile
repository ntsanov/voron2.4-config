.PHONY: klipper
FLASHER=$(HOME)/katapult/scripts/flashtool.py
KLIPPER_BIN=$(HOME)/klipper/out/klipper.bin
KLIPPER_CONF=$(HOME)/klipper/.config
OCTOPUS_DEV=/dev/serial/by-id/usb-katapult_stm32h723xx_21000D001851313434373135-if00
OCTOPUS_UUID=9f93d47dbc88
SB2040_UUID=6d6a43d49a1e
all: octopus sb2040
octopus: octopus-conf klipper octopus-flash
sb2040: sb2040-conf klipper sb2040-flash

octopus-conf:
	@echo "#### Copying octopus config #####"
	cp firmware/make-configs/octopus-pro.config $(KLIPPER_CONF)

octopus-flash:
	@echo "#### Flashing Octopus Pro V1.1 ####"
	$(FLASHER) -f $(KLIPPER_BIN) -d $(OCTOPUS_DEV)

sb2040-conf:
	@echo "#### Copying sb2040v1 config #####"
	cp firmware/make-configs/klipper/sb2040v1.config $(KLIPPER_CONF)

sb2040-flash:
	@echo "#### Flashing sb2040v1 ####"
	$(FLASHER) -i can0 -f $(KLIPPER_BIN) -u $(SB2040_UUID)

klipper:
	@echo "#### Making klipper ####"
	make -C $(HOME)/klipper
