# Power In, Power Out

C.H.I.P. Pro can be powered in a few ways, all managed by the AXP209 power management IC. For simple applications on the test desk, power can be provided over the micro USB connector from a USB power supply or powered USB hub. 

PHOTO

When you are ready to embed C.H.I.P. Pro there are three power options via C.H.I.P. Pro's pins.

PHOTO

* **micro USB port** - use a 6 - 23V AC adapter (we recommend getting one that supplies 12V and 3 amps).

* **CHG-IN** - connect 4.8 to 6 volts of power to this pin (and GND) to provide power for C.H.I.P. Pro. If you have a Lithium Polymer (LiPo) battery connected to BAT, then power provided to CHG-IN will also charge the battery. 
* **BAT** - connect a 3.7 volts Lithium Polymer (LiPo) battery to this pin (and GND) to provide power to C.H.I.P. Pro and receive charge from power inputs. When a battery is connected, short the PWRON (PWR) pin to ground for 2 seconds to start current flow. 
* **VBUS** - connect 5 volts to this pin (and GND to pin 53) to provide power to C.H.I.P.. Power connected to VBUS will also charge a battery, just at a slower rate than from CHG-IN

C.H.I.P. Pro also has three options for providing power to peripherals and sensors.

PHOTO

* **VCC-3V3** - provides 3.3V for sensors.
* **IPSOUT** - the Intelligent Power Select provides up to 2.5 amps at up to 5 volts, depending on power provided at CHG-IN or VBUS. If a 3.7V LiPo battery is the only source of power, IPSOUT will provide a bit less than 3.7 volts. In general, the voltage at IPSOUT is a bit less than voltage in, with a max voltage of 5 volts.
* **PWRON** - connect to ground to turn C.H.I.P. Pro on and boot the operating system.

If you need to provide power to a USB device connected to USB1, connect **IPSOUT** to an appropriate switching regulator to the USB connector pad on your circuit board. 

## Powering Off

There are two ways to power off C.H.I.P. Pro. 

**1)** Ideally C.H.I.P. Pro should be powered off through a terminal window using the `poweroff` command.

**2)** Connect PWR pin to GND for 3+ seconds to power off. 

PHOTO