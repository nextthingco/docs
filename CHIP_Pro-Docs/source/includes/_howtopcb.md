# Custom Circuit Design Tips for C.H.I.P. Pro 

C.H.I.P. Pro was created to be seamlessly embedded into products and we at NTC are here to help you do that. Are you ready to go from breadboard to PCB? Here are some points to keep in mind and help you along the way to your next great idea.

* [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Datasheets/CHIP_PRO_Datasheet_v1.0.pdf)
* C.H.I.P. Pro Manual
* [Component datasheets](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/Component%20Datasheets)
* [Mechanical documents](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/Mechanical_Documents)
* [C.H.I.P. Pro schematics](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/v1.0/CHIP_Pro_v1_0_Schematic.pdf)
* [PCB board files](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/PCB%20Source)
* [Footprint](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr) 


## Footprint

C.H.I.P. Pro has castellated mounting holes making it destined to be mounted to another PCB. Each mounting hole aligns with a solder pad on an appropriately designed footprint. Soldering C.H.I.P. Pro to the footprint can be done during production or initial tests of your custom PCB design. 

No need to measure and create a footprint on your own! We have created one for you that ensures proper alignment. Download the footprint above.

![C.H.I.P. Pro footprint](images/footprint.png)

The footprint includes an open space allowing for the 1.4mm height extending from the bottom of C.H.I.P. Pro.

![C.H.I.P. Pro footprint](images/clearance.jpg)


## Power Considerations

### Supplying Power to C.H.I.P. Pro

Powering C.H.I.P. Pro via the CHG-IN pin at 5-5.5V is the suggested route for all embedded applications. 

C.H.I.P. Pro can also be powered through BAT if a battery is connected, and VBUS if a USB charger/supply is connected. 

Operating Voltage

| Pin    | Min | Typical | Max        | Unit |
|--------|-----|---------|------------|------|
| CHG-IN | 3.8 | 5-5.5   | 6.3        | V    |
| BAT    | 3.0 | 3.8     | 4.2+/-0.5% | V    |
| VBUS   | 3.8 | 5-5.5   | 6.3        | V    |

Default Current Output Before Loading BAT

| Iout         | Min    | Typical | Max     |
|--------------|--------|---------|---------|
| Min. and Max | 500 mA | 900 mA  | 2500 mA |

### Current Draw

Like any feature-loaded SOM, how much current C.H.I.P. Pro draws depends on what you need it to do. Idle current gets down to 100 mA with multiple peripherals unused. Peak current can get around 750 mA during WiFi radio signaling while maxing out processor, NAND, and DRAM loads. 

Budgeting 250-350 mA for normal operation is a midrange target to aim for. A reliable 2A+ rated power supply will work well to power C.H.I.P. Pro.

The current draw limit of VBUS is set by register 30H. The options are 100mA, 500mA, 900mA and "no limit". If the current draw exceeds the set threshold, C.H.I.P. shuts down. Read more from page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 

### Button 

The PWRON pin can be connected to GND through a button as a Power Enable Key (PEK) or hibernation/wake button. The AXP209 can automatically identify long and short button presses. Read more about this on page 10 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 

### IPSOUT Pin

Assuming that a battery and a USB and CHG-IN power supply is present, power is drawn from VBUS, BAT and CHG-IN which is combined by the AXP209 and accessible through the IPSOUT (Intelligent Power Source OUT) pin.

BTS Pin

The AXP209 

## Additional USB Port

Whether you want to add a micro USB 5V source or a host USB-A port, here are some points on power to consider while designing your PCB.

* Standard USB peripherals operate at 5 volts and can draw a good amount of current.
* IPSOUT can provide 5 volts to your USB-A 5V pin if there's a 5 volt input to the system via VBUS or CHG-IN. If a battery is connected and power is not available through VBUS or CHG-IN IPSOUT will provide 3.7 volts which is most likely not sufficient for a USB peripheral.
	* Consider using a 5V DC/DC buck/boost converter on IPSOUT to maintain a 5 volt rail to your additional USB port. In this case, if the device goes into battery mode it will still be getting 5 volts. If you go this route, set the VBUS current limit appropriately for your system's current draw. See page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf) to learn more.

## WiFi Signal

The onboard ceramic WiFi antenna is for debugging purposes only. For products applications use the antenna that comes with the C.H.I.P. Pro Dev Kit or obtain any of these officially supported ones:

| Antenna Model | Manufacturer | Gain | Antenna Type | Connection Type | Freq. Range (GHz) | Cable Length (mm) |
|------------|-----|-----|-----|-----|-----|-----|
| AA107       | Unictron | 3.3 dBi | PCB | IPEX | 2.4 - 2.5 | 100 | 
| HCX-P321   | Wacosun | 2 dBi | PCB | IPEX | 2.4 - 2.5 | 150 |
| FXP73.07.0100A | Taoglas | 2.5 dBi | PCB | IPEX | 2.4 - 2.483 | 100 |
| AA055   | Unictron | 2.5 dBi | Ceramic | SMT | 2.4 - 2.5 | n/a |

## Analog Input

C.H.I.P. Pro has many GPIO to choose from including two PWM pins. If your product needs analog input we recommend adding a I2C controlled ADC to your circuit. 

## Digital Inputs

Use external pull-ups or pull-downs 

## Modular Certification 



