# Circuit Design Tips for C.H.I.P. Pro 

C.H.I.P. Pro was created to be seamlessly embedded into products and we at NTC are here to help you do that. Are you ready to go from breadboard to PCB? Here are some points to help you along the way while you design your product.

* [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Datasheets/CHIP_PRO_Datasheet_v1.0.pdf)
* C.H.I.P. Pro Manual
* [Component datasheets](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/Component%20Datasheets)
* [Mechanical documents](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/Mechanical_Documents)
* [C.H.I.P. Pro schematics](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/v1.0/CHIP_Pro_v1_0_Schematic.pdf)
* [PCB board files](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/PCB%20Source)
* [Footprint](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr) 

## Getting Started 

You may have experience with software development or product design but not a lot of experience with hardware or PCB design and fabrication. If you have an idea that you want to make a reality but are not sure where to start, we have compiled a list of helpful articles and software to get you going. 

### EDA (Electronic Design Automation) Software

There is a wealth of EDA software to choose from. Some are better for beginners than others. It's best to start with an already designed footprint for C.H.I.P. Pro so you can get straight to designing the rest of your circuit. Two pieces of software you can start with are:

* [EasyEDA](https://easyeda.com/)

	A cloud-based software suite that is free and user friendly. Not only can you design PCBS, they offer circuit simulation and PCB fabrication orders through their website. Footprints to components can be designed and contributed by community members for use by anyone. A user contributed footprint for C.H.I.P. Pro can be found by searching CHIP_Pro in libraries. Get started with EasyEDA's online [tutorials](https://easyeda.com/Doc/Tutorial/).

* Eagle 

	

## Footprint

C.H.I.P. Pro has castellated mounting holes making it destined to be mounted to another PCB. Each mounting hole aligns with a solder pad on an appropriately designed footprint. No need to measure and create a footprint on your own, we have created one that ensures proper alignment. The footprint is available for download above.

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

PMU (Power Management Unit) Vout Current Available Before Loading Battery

| Iout         | Min    | Typical | Max     |
|--------------|--------|---------|---------|
| Min. and Max | 500 mA | 900 mA  | 2500 mA |

### Current Draw

**C.H.I.P. Pro Current Draw**

Like any feature-loaded SOM, how much current C.H.I.P. Pro draws depends on what you need it to do. Idle current gets down to 100 mA with multiple peripherals unused. Peak current can get around 750 mA during WiFi radio signaling while maxing out processor, NAND, and DRAM loads. Budgeting 250-350 mA for normal operation is a midrange target to aim for. A reliable 2A+ rated power supply will work well to power C.H.I.P. Pro.

**Setting USB VBUS Current Draw** 

The current draw limit of VBUS is set by register 30H. The options are 100mA, 500mA, 900mA and "no limit" which is what it is set to by default upon boot of C.H.I.P. Pro. If you set the current limit and the current draw exceeds the threshold, C.H.I.P. will shut down. Read more about the VBUS limit on page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 

### Button 

The PWRON pin can be connected to GND through a button as a Power Enable Key (PEK) or hibernation/wake button. The AXP209 can automatically identify long and short button presses. Read more about this on page 10 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf).  

## Additional USB Port

Whether you want to add a micro USB 5V source or a host USB-A port, here are some points on power to consider while designing your PCB.

* Standard USB peripherals operate at 5 volts and can draw a good amount of current.
* IPSOUT can provide 5 volts to your USB-A 5V pin if there's a 5 volt input to the system via VBUS or CHG-IN. If a battery is connected and power is not available through VBUS or CHG-IN, IPSOUT will provide 3.7 volts which is most likely not sufficient for a USB peripheral.
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

## Modular Certification 

* C.H.I.P. Pro is CE, IC, and FCC Part 15 Modular Transmitter certified for use with multiple commercially available [external antennas](https://docs.getchip.com/chip_pro_devkit.html#wifi-antenna) as well as the onboard ceramic SMT antenna. 

* Any product with C.H.I.P. Pro as the only active radio transmitter will not require your company to run certification testing for the unintentional radiator portion of FCC tests, specifically FCC Part 15B. This will save you testing time and cost associated with taking your product through FCC certification. You will still need to run FCC Part 15C tests (EMC testing for the intentional radiator portion). 

* You will not need to apply for a new FCC-ID for your product; when you process your application with a certified test lab, they will file a Class II Permissive Change under NTC's FCC-ID. For any questions on this, reach out to us at pro@nextthing.co. 
