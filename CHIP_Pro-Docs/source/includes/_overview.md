# C.H.I.P. Pro Overview

![C.H.I.P. Pro](images/CHIP-Pro-Side-ISO.png)

The C.H.I.P. Pro System-on-a-Module is designed to get you making great products instead of re-inventing computers. It's a low-cost, high-capability module that lets you focus on fast iterations of brilliant ideas that will be ready to manufacture.

This document provides technical details on the module and basic guides for getting started with working with C.H.I.P. Pro. To get the most out of developing and designing for C.H.I.P. Pro, we recommend the [C.H.I.P. Pro Development Kit](http://docs.getchip.com/chip_pro_devkit.html).

## Overview

C.H.I.P. Pro is a breadboard-friendly and surface-mount-ready computer designed from the ground up to power the next generation of smart devices.

C.H.I.P. Pro is powered by GR8, a system-in-package (SiP) that was designed by us at Next Thing Co. GR8 features a 1GHz Allwinner R8 ARM Cortex-A8 processor, Mali400 GPU, and 256MB of Nanya DDR3 DRAM. in a 14mm x 14mm FBGA package. C.H.I.P. Pro adds to the GR8 with 512MB of high-speed NAND storage, WiFi and Bluetooth connectivity, power and battery management, pins for popular I/O busses, USB gadget, the verstatility of mainline Linux, all on a compact footprint.

The module offers all the popular interfaces you'd expect. With two UARTs, a Two Wire Interface, a parallel camera interface, SPI, two PWM channels, a USB 2.0 OTG, and a USB 2.0 Host, C.H.I.P. Pro is packed full of opportunity. Comprehensive audio handling includes a built-in 24-bit ADC/DAC for stereo audio in and out, One Wire Audio digital out, and I2S digital audio for interfacing with professional audio DACs.

C.H.I.P Pro is CE, IC, and FCC part 15 modularly certified, making integration into end products easy. The on-board Realtek 8723DS combination module provides compliant Wi-Fi B/G/N and Bluetooth 4.2 Low-Energy connectivity. A software controlled antenna path selects between the on-board chip antenna or a uFL antenna connector where several pre-certified antennas can be added to boost wireless transmit and receive range. 

Charge or power from an AC/DC adapter or power it from USB or a rechargable battery. On-board Power management with the AXP209 provides plenty of power options to better match your applications: mobile, industrial, and low-power are all possible with C.H.I.P. Pro. 

![C.H.I.P. Pro](images/CHIP-Pro-Side-Crop.jpg)

C.H.I.P. Pro is rated to operate between 2.9V-6V in temperatures ranging between 0 and 70 degrees Celsius and measures 45mm x 30mm.

We can't wait to see how you'll integrate C.H.I.P Pro into your next product.

## Block Diagram

![C.H.I.P. Pro Block Diagram](images/CHIP-Pro-Block-Diagram.png)

## GR8 SiP

![GR8](images/CHIP-Pro-Exploded-View.png)

C.H.I.P. Pro is built around the GR8 System-in-Package that combines an Allwinner R8 with DDR3 memory on the same piece of silicon. Basic specifications are as follows:
 
* 1GHz Next Thing Co. GR8 ARM Cortex-A8 with ARMv7 instruction set and NEON coprocessor
* Mali-400 GPU supporting OpenGL ES1.1/ 2.0 and OpenVG 1.1
* 256MB DDR3 RAM

More information about the GR8 SiP can be found in the [GR8 data sheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/raw/master/Datasheets/GR8_Datasheet_v1.0.pdf)
