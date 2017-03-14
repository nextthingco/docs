# Power

## Power C.H.I.P. Pro

C.H.I.P. Pro can be powered in a few ways, all managed by the AXP209 power management IC. 

![power LED USB](images/powerLED_800.jpg)

When you are ready to embed C.H.I.P. Pro there are options for how to power C.H.I.P. Pro. Below is a list of the ports and pins to provide power to and pins that are necessary to initiate power in some instances. 


* **Micro USB port** - use a 6 - 23V AC adapter (we recommend getting one that supplies 12V and 3 amps).

**Pins**

* **CHG-IN** - connect 4.8 to 6 volts of power to this pin (and GND) to provide power for C.H.I.P. Pro. If you have a Lithium Polymer (LiPo) battery connected to BAT, then power provided to CHG-IN will also charge the battery. 
* **BAT** - connect a 3.7 volts Lithium Polymer (LiPo) battery to this pin (and GND) to provide power to C.H.I.P. Pro and receive charge from power inputs. When a battery is connected, short the **PWR (PWRON)** pin to ground for 2 seconds to start current flow.
* **PWR (PWRON)** - Connect to ground for 1 second to turn C.H.I.P. Pro on when a battery is attached to the **BAT** pin. 

![PWR on](images/PWRon_800.jpg)

* **VBUS** - connect 5 volts to this pin (and GND to pin 53) to provide power to C.H.I.P.. Power connected to VBUS will also charge a battery, just at a slower rate than from CHG-IN

## Power Out 

C.H.I.P. Pro also has options for providing power to peripherals and sensors.

* **VCC-3V3** - provides 3.3V for sensors.
* **IPSOUT** - the Intelligent Power Select provides up to 2.5 amps at up to 5 volts, depending on power provided at CHG-IN or VBUS. If a 3.7V LiPo battery is the only source of power, IPSOUT will provide a bit less than 3.7 volts. In general, the voltage at IPSOUT is a bit less than voltage in, with a max voltage of 5 volts.

If you need to provide power to a USB device connected to USB1, connect **IPSOUT** to an appropriate switching regulator to the USB connector pad on your circuit board. 

## Powering Off

There are two ways to power off C.H.I.P. Pro. 

**1)** Ideally C.H.I.P. Pro should be powered off through a terminal window using the `poweroff` command. This will end all processes safely	 protecting your data. 

**2)** Connect **PWR** pin to **GND** for 3+ seconds to power off. 


![PWR off](images/PWRoff_800.gif)