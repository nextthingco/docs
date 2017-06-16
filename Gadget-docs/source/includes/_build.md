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

1. **Pull Example Images** from Docker Hub and deploy to hardware. See the Examples LINK section to learn about this process.

2. **Build Images** locally on a development computer. Use GadgetCLI to deploy and run containers on C.H.I.P. Pro and other Gadget supported hardware. See the Build Images Locally section LINK to learn more about that.

## Example Images

Start your project with one of our Python example images. Examples are pulled from the official [NTC Docker Hub](https://hub.docker.com/r/ntcgadget/). All supporting materials including Dockerfiles are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

### Blink

A 'hello world' example that blinks an LED on pin 36, CSDID0. If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

1. Launch GadgetCLI

2. Connect hardware to host computer.

	Make sure the hardware is flashed with GadgetOS.  
	{Pic of Dev Kit connected to host computer}

3. Create project directory

	`blink`

4. Initialize Project

	Create the gadget.yml configuration file in your project directory.

	`gadget -C blink init`


5. Add Service to Gadget.yml

	Go into project directory:

	`cd blink` 

**TKTK When I  create project directory, i can create a .yml file but then can't add service with the gadget mac release i have.**

This file holds the options that are needed for a container at run time. This is also where you add services and onboot actions. 

Check out the Configuring gadget.yml LINK to learn more about the available options. 


`gadget add service blink #add a service to file`


**should friendly and project directory name be different?**
**How do I delete services?**

6. Edit gadget.yml

	`nano gadget.yml`
	
	Edit the field after "image:" to reflect the username/repo:tag. 

	```
	services:
	- name: blinkdemo
 	 uuid: 2f54774d-2904-4dc3-b157-3db5800e256b
 	 image: ntcgadget/blink:v1 
 	 directory: ""
 	 net: ""
 	 pid: ""
 	 readonly: false
 	 command: []
 	 binds: []
 	 capabilities: []
	```


	change “image:” section to docker repo, make sure you specify the right tag if you 						gave one! Otherwise you will get this error:
	ERRO[0001] Error response from daemon: manifest for pushreset/pythonio:latest not 	found 
	ERRO[0001] Failed to build 'pythonio'                   
	WARN[0001] Is the docker daemon installed and running?

7. Build Image

	```
	gadget build blinkdemo
	```


## Configuring Gadget.yml

Definition of all the things in gadget.yml file.

**onboot**

**services**

**name** - Name of project
**uuid** - Unique container ID
**image** - Pathname of Docker Hub 
**directory** - Pathname of local image
**net** - 
**pid** -
**readonly** - Set to false by default
**command**
**binds** - Bind mount a volume
**capabilities** - 

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

1. Create project directory

```
mkdir projectname
cd projectname
```

1. Create Dockerfile

```
nano Dockerfile
```

2. Create supporting files

```
nano pythonScript.py
```

3. Build, Tag and Push

```
docker build -t friendlyname . #build and tag it 
docker login #log into your personal Docker Hub
docker tag blinkdemo pushreset/blink:v1
docker push pushreset/blink:v1

```

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
