# How to Design a PCB for C.H.I.P. Pro

C.H.I.P. Pro was created to be seamlessly embedded into products and we at NTC are here to help you do that. Are you ready to go from breadboard to PCB? Here are some points to keep in mind and help you along the way to your next great idea.


## Footprint

C.H.I.P. Pro has castellated mounting holes making it destined to be mounted to another PCB. Each mounting hole aligns with a solder pad on an appropriately designed footprint. This can be done during production or initial tests of your custom PCB design. 

No need to measure and create a footprint on your own! We have created one for you that ensures proper alignment. 

![C.H.I.P. Pro footprint](images/footprint.png)

Download the Eagle footprint [here](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr). The footprint includes a cut out in the middle to allow for the height of 1.4 mm extending from the bottom of the board.

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

The VBUS has a current limit set by register 30H. The values to write can be find on page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 

## Current Draw

Like any feature-loaded SOM, how much current C.H.I.P. Pro draws depends on what you need it to do for your product. Idle current gets down to 100 mA with multiple peripherals unused. Peak current can get around 750 mA during WiFi radio signaling while maxing out processor, NAND, and DRAM loads. 

Budgeting 250-350 mA for normal operation is a midrange target to aim for. A reliable 2A+ rated power supply will work well. 

### Button 

The PWRON pin can be connected to GND through a button as a Power Enable Key (PEK) or hibernation/wake button. The AXP209 can automatically identify long and short button presses. Read more about this on page 10 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 

## Additional USB Port

Whether you want to add a micro USB 5V source or a host USB-A port here are some points on power to consider while designing your circuit.

* Standard USB peripherals operate at 5 volts and can draw a good amount of current.
* IPSOUT can provide 5 volts to your USB-A 5V pin if there's a 5 volt input to the system via VBUS or CHG-IN. If a battery is connected and power is not available through VBUS or CHG-IN IPSOUT will provide 3.7 volts which is most likely not sufficient for a USB peripheral.
* Use a 5V DC/DC buck/boost converter on IPSOUT to maintain a 5 volt bus to your additional USB port. In this case, if the device goes into battery mode it will still be getting 5 volts. If you go this route, set the VBUS current limit appropriately for your system's current draw. See page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf) to learn more.






