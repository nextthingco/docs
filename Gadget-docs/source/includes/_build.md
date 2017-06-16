# Build With Gadget 

Once you get our Blink Python script up and running you are ready to dive deeper. Here you will find examples to get you started with popular sensors and breakout boards as well as how to load and run custom code. Before completing any of the examples make sure to go through the Quickstart [LINK] guide to meet the requirements below. 

### Requirements

#### Hardware

* Host computer (Mac, Windows or Linux)
* Gadget compatible hardware
	* All examples pictured here are with the Dev Kit
* USB cable
	* Micro USB to USB cable (Dev Kit) 
	or
	* UART serial cable if using C.H.I.P. Pro bare

#### Software

**Host Computer**

* GadgetCLI 
* Docker

**Gadget Compatible Hardware**

* GadgetOS 

## Two Ways to Build With Gadget

See demos with pullable images, start developing by cloning/editing/building our Dockerfiles from Github.

1. **Pull Example Images** from Dockerhub and deploy to hardware. See the Examples LINK section to learn about this process.

2. **Build Images** locally on a development computer. Use GadgetCLI to deploy and run containers on C.H.I.P. Pro and other Gadget supported hardware. See the Build Images Locally LINK to learn more about that.

## Example Images

Start your project with one of our Python example images. Examples are pulled from the official [NTC DockerHub](https://hub.docker.com/r/ntcgadget/). Dockerfiles and supporting files are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

### Blink

A 'hello world' to make sure everything is working.

1. Launch GadgetCLI

2. Connect Hardware to Host

Make sure the hardware is flashed with GadgetOS.  
{Pic of Dev Kit connected to host computer}

3. Create project directory

`blink`

4. Initialize Project

Create the gadget.yml configuration file. 

`gadget init`

5. Add Service to Gadget.yml

This file is where the options go that are needed for a container at run time. This is also where you add services and onboot actions. 

Check out the Configuring Gadget.yml LINK to learn more about the available options. 

```
gadget add service blink #add a service to file

```

## Configuring Gadget.yml

Definition of all the things in gadget.yml file

### I2C

**ADS1015**

To read resistor based sensors add a high resolution multiple channel ADC to your circuit.

### SPI

**ADXL345 Accelerometer**

This is a popular 3-axis MEMs accelerometer that's great for applications sensing different kinds of motion and lack there of.

**Note:** Most breakout boards for the ADXL345 are also accessible through I2C.

### LEDs and Microphones
This VU-meter example uses C.H.I.P. Pro Dev Kit's onboard mics and LEDs. The LED's brightness is mapped to the amplitude of the Mic inputs. Speak into or tap the mics to turn the LEDs on. 

If using a bare C.H.I.P. Pro additional hardware is needed. Connect LEDs to pins PE0 - PE7 and MEMs microphones to pins 26-29 labeled: AGND, MICIN1, MICIN2, and VMIC respectively.

### Python CHIP_IO

###  Google Assistant
Google's Assistant API can be asked questions and be used to control hardware such as voice activated robots. 

### Multiple Containers?

## Build Image Locally

Take the following steps to learn how to best develop with Gadget and Docker. 

## Common Command Sequence

* init
* build 
* deploy
* start
* logs
* status
* shell w/ illustration showing where you are in relation to container

## Containerize Application


## Where and how to pass args to docker run commmand?

* add network 
* mapping ports
* sharing volumes
* kernel module
* device sharing between host and container
