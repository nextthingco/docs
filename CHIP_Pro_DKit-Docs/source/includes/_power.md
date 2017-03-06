# Power

## Powering Off

If you are running any processes we recommend powering C.H.I.P. Pro off by holding the C.H.I.P. Pro power button on the dev board down (for about 5 seconds). Wait for the power and status LEDs to turn off. 

![power off button](images/poweroffB.gif)

Alternatively, you can switch off C.H.I.P. Pro via command line:

**Buildroot**

```
poweroff
```

**Debian**

```
sudo poweroff
```

In either instances, once C.H.I.P. Pro has been powered down it is safe to remove the power supply from the Dev Kit without the risk of losing data. 

## Input

![image page](images/powerIn.jpg)

There are three ports on the Dev Kit that support three different power supplies:

* **Micro USB port** - AC adapter or powered USB hub 
* **JST-PH 2.0mm** - Rechargable 3.7V Lithium Polymer battery 
* **DC-IN barrel jack** - 6 - 23V AC adapter (we recommend getting one that supplies 12V and 3 amps)

Power can also be provided to **three pins** to power C.H.I.P. Pro:

* **CHG-IN** - connect 4.8 to 6 V of power to pin 4 (and GND) to provide power to C.H.I.P. Pro. If you have a 3.7V Lithium Polymer (LiPo) battery connected to BAT, then power provided to CHGIN will also charge the battery.
* **BAT** - connect a 3.7V Lithium Polymer (LiPo) battery to pin 8 (and GND) to provide power to C.H.I.P. Pro. You can charge the battery by providing voltage to the CHG-IN pin.
* **VBUS** - connect 5V to pin 50 (and GND to pin 53) to provide power to C.H.I.P. Pro.

## Battery Charging Management

The Dev Kit uses the **AXP209 IC** to manage charging. Pin 7 marked BAT TEMP or BTS supports a thermistor to monitor the battery temperature when the battery is charging or discharging.  If you do not incorporate a thermistor into your setup the pin may float from ground interferring with how much charge current is throttled to the BAT pin and the JST connector. To ensure maximum charge current without a thermistor disable the battery temperature monitoring system.

There are two ways to do this:

* Connect pin BTS to ground
* Disable the temperature functionality in software:

```shell
sudo i2cset -y -f 0 0x34 0x82 0x82
````

You can find more information on this setup in the [AXP209 Datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). Search "ts pin" to quickly find information.

## Output
The C.H.I.P. Pro Dev kit can provide power to sensors and peripherals.

* **VCC-3V3** - pin 2 provides 3.3V for sensors and anything else. This pin can provide a maximum of 800mA. The 800mA supply takes into account system load and can vary depending on what the Wifi module and GR8 SOC are requiring from the AXP209 power management IC.
* For your servo needs PWM0 and PWM1 breakout through-holes provide 5V volts and 2.5A.
* **IPSOUT** - pin 3, this is AXP209’s **I**ntelligent **P**ower **S**elect pin. It automatically supplies current from available sources based on logic set in the registers.
* **USB1 Host** - provide power to USB peripherals.
* **PWRON** - connect to ground to turn C.H.I.P. Pro on and boot the operating system.

## Management 
There are several ways to power the C.H.I.P. Pro Dev Kit and your creative endeavors. The Dev Kit boasts a AXP209 Power System Management IC designed to switch to any available power source. The following table details what happens with some different power scenarios.

Power Source | Result
----|----
Battery | C.H.I.P. Pro is powered by battery, USB1 does not receive 5V
Battery + DC In | C.H.I.P. Pro is powered by DC In, battery can be charged up to 1.8A
Battery + USB In | C.H.I.P. Pro is powered by USB in, battery can be charged up to 900mA by default, more if the no-limit setting is used
Battery + DC In + USB In | C.H.I.P. Pro is powered by DC In, battery is charged
Battery + low amperage DC or USB In | Battery powers C.H.I.P. Pro as needed to prevent shut down

Overvoltage can cause permanent damage. Find more details for each port's specifications in the [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/v0.9/Datasheets/CHIP_PRO_Datasheet_v1.0.pdf) and [AXP209 Datasheet.](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf)
