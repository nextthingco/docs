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
* IPS dynamic power pass-through
* 27 GPIO

## Audio

Stereo audio in and out is handled by an on-die 24-bit audio codec in GR8. 

* 24-bit ADC/DAC for stereo audio in and out
* One-wire Audio (S/PDIF Compatible) digital out
* Supports 44.1 kHz, 48 kHz, 96 kHz, and 192 kHz sample rates
* Bi-directional I2S digital audio for interfacing with industry standard audio codecs
* Full-Duplex synchronous serial digital audio interfaces
* I2S Audio data sample rate from 8-192kHz
* Transmit and Receive FIFO buffers with programmable thresholds

## Power and Battery Management

* **AXP209 power management IC** connected to a dedicated I2C bus
* **Operating Voltage** - 3.8V - 6.3V
* **Operating Temp** - 40C - 130C 

* **1.8A max** battery charging current with programmable limits
* **2.5A max** power distribution to system

C.H.I.P. Pro can be powered by battery, USB or AC/DC adapter. On-board Power management with the AXP209 provides plenty of power options to better match your applications: mobile, commercial, and low-power are all possible with C.H.I.P. Pro. 

For more details, the AXP209 datasheet can be found [here](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/v0.9/Component%20Datasheets/AXP209_Datasheet_v1.0en.pdf). 

## WiFi

* Realtek 8723DS Combination Module
* Bluetooth 4.2 LE
* 2.4GHz Wifi 802.11 b/g/n
* Wifi and BT Unictron antenna model no. AA055
* IPEX (U.FL) antenna connector
* FCC/CE/IC certified

A software controlled antenna path selects between the onboard chip antenna or a IPEX (U.FL) antenna connector where several pre-certified antennas can be added. 

FCC Modular certification (47 CFR 15.212) limits the need for final device 	                      “intentional radiator” certification under 47 CFR 15.247, so long as pre-certified      antennas are used with C.H.I.P. Pro. 

To learn more, find the FN-Link Module antenna datasheet [here](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/Component%20Datasheets)



