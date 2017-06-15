# Build With Gadget [Lara]

Once you get our Blink Python script up and running you are ready to dive deeper. Here you will find information on how to load and run custom code and examples to get you started with popular sensors and breakout boards. Before completing any of the examples make sure to go through the Quickstart [LINK] guide to meet the requirements below. 

#### Requirements

**Hardware**

* Host computer (Mac, Windows or Linux)
* Gadget compatible hardware
	* All examples pictured here are with the Dev Kit
* USB cable
	* Micro USB to USB cable (Dev Kit) 
	or
	* UART serial cable if using C.H.I.P. Pro bare

**Software**

Host Computer

* GadgetCLI 
* Docker

Gadget Compatible Hardware

* GadgetOS 

## Examples

Start your project with one of our Python examples. All examples are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples) and are open source. 

### I2C

#### ADS1015
To read resistor based sensors add a high resolution, multiple channel ADC to your circuit.

### SPI

#### ADXL345 Accelerometer
This is a popular 3-axis MEMs accelerometer that's great for applications sensing different kinds of motion and lack there of.

**Note:** Most breakout boards for the ADXL345 are also accessible through I2C.

### LEDs and Microphones
This VU-meter example uses C.H.I.P. Pro Dev Kit's onboard mics and LEDs. The LED's brightness is mapped to the amplitude of the Mic inputs. Speak into or tap the mics to turn the LEDs on. 

If using a bare C.H.I.P. Pro additional hardware is needed. Connect LEDs to pins PE0 - PE7 and MEMs microphones to pins 26-29 labeled: AGND, MICIN1, MICIN2, and VMIC respectively.

### Python CHIP_IO

###  Google Assistant
Google's Assistant API can be asked questions and be used to control hardware such as voice activated robots. 

### Multiple Containers?

## Two Ways to Deploy Images

### build image on local machine
### git clone from repo

## Common Command Sequence

* init
* build 
* deploy
* start
* logs
* status
* shell w/ illustration showing where you are in relation to container

## Containerize Application

## Configuring Gadget.yml

## Where and how to pass args to docker run commmand?

* add network 
* mapping ports
* sharing volumes
* kernel module
* device sharing between host and container
