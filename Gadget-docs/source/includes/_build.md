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
	* UART serial cable (bare C.H.I.P. Pro)

#### Software

**Host Computer**

* GadgetCLI 
* Docker

**Gadget Compatible Hardware**

* GadgetOS 

## Two Ways to Build With Gadget

1. **Pull images**, including our demos, from Docker Hub and deploy to hardware. See the Examples LINK section to learn about this process.

2. **Build images** locally on a development computer. Use GadgetCLI to deploy and run containers on C.H.I.P. Pro and other Gadget supported hardware. See the Build Images Locally section LINK to learn more.

## Example Images

Start your project with one of our Python example images. Examples are pulled from the official [NTC Docker Hub](https://hub.docker.com/r/ntcgadget/). All supporting materials including Dockerfiles are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

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
## Configuring Gadget.yml

The file gadget.yml is where container options go that are executed at run time. It is also where you define in what order containers run and whether they run once or continually. 

At the top of the file you find:

spec: "0.0"
name: blink
uuid: e6aa1456-8a4c-44d3-9c0a-06c9b8d1a96c
type: docker

The file is broken up into two sections: **onboot** and **services**. 

#### onboot

Containers added to the onboot section runs after boot, then exits. When multiple containers are defined they run sequentially from top to bottom. 

Add a container:

`gadget add onboot projectname`
	
From parent directory:
	
`gadget -C blink add onboot projectname`


#### services

Containers defined as a service runs on boot after all of the onboot containers. A service is automatically restarted by Docker if it exits with a non-zero return code.

**name** - Name 
**uuid** - Unique container ID
**image** - Pathname of Docker Hub 
**directory** - Pathname of local image
**net** - 
**pid** -
**readonly** - Set to false by default
**command**
**binds** - Bind mount a volume
**capabilities** - 

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
