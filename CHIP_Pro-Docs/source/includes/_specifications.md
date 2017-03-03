# Specifications

## C.H.I.P. Pro Exposed Interfaces

* 1x Two Wire Interface
* 2x UART (1x 2-wire and 1x 4-wire)
* SPI enabling SD card interface 
* SPI Bus
* 2x PWM
* 6-bit ADC
* I2S Digital Audio
* S/PDIF IEC-60958 Digital Audio Input and Output 
* 2x USB HS/FS/LS
	* USB 2.0 Host
	* USB 2.0 OTG
* Parallel Camera Interface 
* 3.3V DC supply
* 27 GPIO

## Audio

* Stereo analog input 44.1K or 48K sampling rate
* Stereo analog output 44.1K or 48K sampling rate
* Programmable phantom power for mic in
* Bi-directional I2S bus for external DAC codecs

## Power and Battery Management

* AXP209 power management unit, connected to a dedicated I2C bus
* 2.9V to 6V
* 0 to 70 degrees Celsius 

## Wireless Connectivity

* Realtek 8723DS Combination Module
* Bluetooth 4.2 LE
* WiFi 802.11 b/g/n
* uFL antenna connector
* FCC/CE/IC certified

## Operating System

* GadgetOS, a Linux optimized for GR8 and C.H.I.P. Pro
* Debian for C.H.I.P. Pro, for a familiar Linux experience
* Next Thing Co. rootfs on GitHub so developers can create their own Linux distro for C.H.I.P. Pro

## Mechanical Drawing

You can download a high resolution version of this image [here](images/CHIP-Pro-PCB.png)
![Mechanical Drawing](images/CHIP-Pro-PCB_sm.png)

### Dimensions

Refer to the following diagram for the complete dimensions of C.H.I.P. Pro:

![C.H.I.P. Pro Dimensions](images/CHIPPro-dims.jpg)

## PCB Footprint

C.H.I.P. Pro is designed for scale so it's ready to drop into any SMT manufacturing line. The exterior dimensions for the PCB pads for C.H.I.P. Pro are 32 mm x 47.60 mm (1.26 in x 1.87 in). More detailed dimensions for your board layout are in the following diagram:

![C.H.I.P. Pro PCB Footprint](images/CHIP-Pro-Footprint.png)

## Data Sheet

While this documentation contains much of the needed technical info for C.H.I.P. Pro, the complete data sheet for C.H.I.P. Pro is available [on our C.H.I.P. Pro Hardware github repo](https://github.com/NextThingCo/CHIP_Pro-Hardware/raw/master/Datasheets/CHIP_PRO_Datasheet_v1.0.pdf)
