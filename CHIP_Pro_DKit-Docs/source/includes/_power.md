# Power

## Input
There are three ports on the Dev Kit that support three different power supplies:

* Micro-USB port for AC adapter or powered USB hub 
* JST-PH 2.0mm for Rechargable 3.7V Lithium Polymer battery 
* DC-IN barrel jack for 6 - 23V AC adapter 

For AC adapters we recommend getting one that supplies 12V and 3 amps.

Power can also be provided to three pins to power C.H.I.P. Pro.

* CHG-IN - connect 4.8 to 6 V of power to pin 4 (and GND) to provide power to C.H.I.P. Pro. If you have a 3.7V Lithium Polymer (LiPo) battery connected to BAT, then power provided to CHGIN will also charge the battery.
* BAT - connect a 3.7V Lithium Polymer (LiPo) battery to pin 8 (and GND) to provide power to C.H.I.P. Pro. You can charge the battery by providing voltage to the CHG-IN pin.
* VBUS - connect 5V to pin 50 (and GND to pin 53) to provide power to C.H.I.P. Pro.

## Output
The C.H.I.P. Pro Dev kit can provide power to sensors and peripherals.

* VCC-3V3 - pin 2 provides 3.3V for sensors and anything else. This pin can provide a maximum of 800mA.
* For your servo needs PWM0 and PWM1 breakout through-holes provide 5V volts and 2.5A.
* IPSOUT - pin 3 provides a power rail based on the available power inputs for powering peripherals.
* USB1 Host - provide power to USB peripherals.
* PWRON - connect to ground to turn C.H.I.P. Pro on and boot the operating system.

## Management 
There are several ways to power the C.H.I.P. Pro Dev Kit and your creative endeavors. The Dev Kit boasts a AXP209 Power System Management IC designed to switch to any available power source. The following table details what happens with some different power scenarios.

Power Source | Result
----|----
Battery | C.H.I.P. Pro is powered by battery
Battery + DC In | C.H.I.P. Pro is powered by DC In, battery is charged
Battery + USB In | C.H.I.P. Pro is powered by USB in, battery is charged (though more slowly than by DC In)
Battery + DC In + USB In | C.H.I.P. Pro is powered by DC In, battery is charged
Battery + low amperage DC or USB In | Battery powers C.H.I.P. Pro as needed to prevent shut down
Too much voltage! | C.H.I.P. Pro shuts down and may become permanently damaged

## Powering Off
If you are running any processes we recommend powering C.H.I.P. Pro off by holding the C.H.I.P. Pro power button on the dev board down (for about 6 seconds). Wait for the power and status LEDs to turn off. Alternatively, you can switch off C.H.I.P. Pro through software using the command `poweroff`. In both instances, once C.H.I.P. Pro has been powered down it is safe to remove the power supply from the Dev Kit without the risk of losing data. 
