# Introduction
This documentation is a resource to getting started with the C.H.I.P. Pro Developer's Kit. There are lists of contents, descriptions of parts, explanations of how to use the unique features of the board, and some examples to work through so you can get up and running developing your product around C.H.I.P. Pro.

# Overview
The C.H.I.P. Pro Developer's Kit provides a complete electronic sandbox to test, iterate, and make products with the C.H.I.P. Pro module. While many developer's kits assume a high-degree of technical experience, we make this kit approachable, compact, and easy to use. We believe that great products can come from many backgrounds, so we provide several extras in this kit that help you get making and get comfortable. Even if you do know it all, you'll find plenty of useful information in here to make sure your product is the best it can be.

# What's in the Kit
Dev Kit Board with C.H.I.P. Pro
Extra C.H.I.P Pro
Bag of goodies (Jumper wires, button, button cap)

# What you need
Dev Board
USB Micro  Cable
12V Power Supply with Barrel Jack Connector
Another Computer or a C.H.I.P!

# What's on the board 
	
## Graphic with callouts for components
* Power Switch
* Barrel Jack
* Battery switch
* JST Battery Connector
* USB A
* Micro USB
* LEDS for UART
* LEDS for digital out
* LEDS for PWM
* Mics

## Cuttable Traces and How To Cut and Un-Cut Them
(Pictures of cutting and fixing jumpers)


# Connect
	
## Power
power supply min/max

## Battery
switch battery on/off

## Serial (USB Gadget or built-in UART)
connect to computer
Difference between USB Gadget Serial and UART Serial Over USB

## WiFi
Depends on OS image, I suppose
Nmcli or connmanctl

## Bluetooth

## Audio

The C.H.I.P. Pro Development Kit has several ways to access audio and out. Stereo audio in an out is handled by a 24bit/48K DAC built-in to the GR8 processor. There are also digital options that you can use, but require configuration of the Linux kernel and additional hardware to access.

* Audio Output via 3.5mm TRRS jack
* Mono input via 3.5mm TRRS jack
* Stereo microphones
* MIC1 and MIC2 header pins
* I2S Digital Audio
* SPIDIF Digital Audio

### Input
There are two (2) analog MEM (micro electro mechanical) microphones on the Development Kit. These are enabled by default. 

If you want to use the HPL and HPR pins for audio input, you'll need to [cut a trace](#cut-audio).

The "Sleeve" on the TRRS jack can be used as a mono audio input, suitable for microphones commonly built-in to headphones. If you want to used this connector, you'll need to [cut a trace](#cut-audio).

### Output


## USB
The USB A jack can be used to connect and use popular accessories like storage, MIDI controllers, keyboards, pointing devices, audio hardware, and more. C.H.I.P. Pro does not provide power to the USB A port on its own, so the Development Kit is a good example of how this works.  

## On-board LEDs
The Kit provides ten LEDs on the board to make it easy to test your GPIO skills without having to wire anything up. 

Eight of these LEDs can be turned on and off with standard Linux sysfs commands to the GPIO pins DO to D7. 

There are also two LEDs that are connected to the PWM pins for testing and learning about pulse width modulation. 

# Use it

## Boot

## Connecting via terminal

## Suggested Buildroot Images

## Compute I/O offset

## Access I/O via sysfs	

# Build And Flash An Operating System

## Flash an Example Image from Web

## Customize a Buildroot Image

## Flash the Image

## Boot the Image

# Learn More
Link to C.H.I.P. Pro documentation for pinouts and shit

# Open Source Hardware
Links and explanation of what’s available


