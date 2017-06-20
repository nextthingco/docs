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

Follow these two tutorials to get familiar with the two ways you can work with Gadget.  They each outline a different process. The both use Python and the CHIP_IO python library with a simple script that blinks an LED on pin 36, CSID0. 

1. **Pull images**, including our demos, from Docker Hub and deploy to hardware. See the Pull Images LINK section to learn about this process.

2. **Build images** locally on a development computer. Use GadgetCLI to deploy and run containers on C.H.I.P. Pro and other Gadget supported hardware. See the Build Images Locally section LINK to learn more.

**Circuit**

PIC of LED circuit with Dev Kit

**Note:** If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

### Pull Image: Blink Example

Start a project with one of our Python example images. Examples are pulled from the official [NTC Docker Hub](https://hub.docker.com/r/ntcgadget/). All supporting materials including Dockerfiles are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

**1. Launch GadgetCLI**

**2. Connect Hardware**

	Using a USB cable connect your board to your host computer. Make sure the board is flashed with GadgetOS. LINK
	{Pic of Dev Kit connected to host computer}

**3. Create project directory**

	`mkdir blink`

**4. Initialize Project**

	Enter and create the gadget.yml configuration file in your project directory.

	`cd blink`
	
	`gadget init`
	
	A gadget.yml file can also be created from in project directory from parent. 
	
	`gadget -C blink init`


**5. Add Service** 

	`gadget add service blink`
	
	From parent directory:
	
	`gadget -C blink add service blinkdemo`
	

**6. Edit gadget.yml**

	`nano gadget.yml`
	 
	Fill in gadget.yml as described below. You container will have a different uuid. To find out what all of the fields in this file are for go to the Configuring Gadget.yml LINK section.
	
	```bash
	services:
	- name: blinkdemo
 	 uuid: 2f54774d-2904-4dc3-b157-3db5800e256b
 	 image: ntcgadget/blink:v1 
 	 directory: ""
 	 net: ""
 	 pid: ""
 	 readonly: false
 	 command: ["python", "blink.py"]
 	 binds: [/sys:/sys]
 	 capabilities: [--cap-add SYS_RAWIO --device /dev/mem]
	```
	
	
	What each edit does:
	
		**image** - Pulls from the Docker Hub repo specified in this format -  username/repo:tag. Don't forget the version tag if it's not the default "latest". 
	
		**command** - Runs a Python script called blink.py that is included in the image.
	
		**binds** - Mounts the /sys volume from the host device TKTK into the container at /sys.
	
		**capabilities** - Grants Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations and allows access /dev/mem device with privileges. CHECK WITH LANGLEY

**7. Build, Deploy, and Start Image**

	In the project directory:
	
	```bash
	gadget build 
	gadget deploy blinkdemo
	gadget start
	```
	
	From parent directory:

	```bash
	gadget -C blink/blinkdemo build 
	gadget -C blink/blinkdemo deploy 
	gadget -C blink/blinkdemostart

	```
		
**8. Logs and Status**

	Check the status of the container:
	
	`gadget status`
	
	Look at the output logs of the container:
	
	`gadget logs`
	
	
**9. Stop Container**

	`gadget stop`
	

## Build Image Locally: Blink Example

Take the following steps to learn how to best develop with Gadget and Docker. 

**1. Create project directory**

	```
	mkdir blink
	cd blink
	```

**2. Create Dockerfile**

	```
	nano Dockerfile
	```
	
	CHANGE Create and save a Dockerfile with this in it:

	
	```
	# Base off arm32v7 Alpine Linux image on Docker Hub
	FROM armhf/alpine

	WORKDIR /app

	ADD . /app

	# Install tools needed to download and build the CHIP_IO library from source.
	RUN apk update && apk add make && apk add gcc && apk add g++ && \
		apk add flex && apk add bison && apk add git && \
       	 	# Download python and tools for installing libraries
        	apk add python-dev && apk add py-setuptools && \
        	# Download source code for device tree compiler needed for CHIP_IO
        	git clone https://github.com/atenart/dtc.git && \
        	# Build and install the device tree compiler
        	cd dtc && make && make install PREFIX=/usr && \
        	# Remove the device tree compiler source code now that we've built it
        	cd .. && rm dtc -rf && \
        	# Download the latest CHIP_IO source code
        	git clone https://github.com/xtacocorex/CHIP_IO.git && \
        	# Install the CHIP_IO library from the proper directory
        	cd CHIP_IO && python setup.py install && \
        	# Remove CHIP_IO source code directory after it has been installed
        	cd ../ && rm -rf CHIP_IO && \
        	# Remove build tools, which are no longer needed after installation
        	apk del git && apk del make && apk del gcc && apk del g++ && apk del flex && 	apk del bison

	CMD ["python", "blink.py"]
	```


**3. Create supporting files**

	```
	nano pythonScript.py
	```


**4. Build, Tag and Push**

	
	```
	docker build -t friendlyname . #build and tag it 
	docker login #log into your personal Docker Hub
	docker tag blinkdemo pushreset/blink:v1
	docker push pushreset/blink:v1

	```

### Example Images

#### I2C

**ADS1015**

To read resistor based sensors add a high resolution multiple channel ADC to your circuit.

#### SPI

**ADXL345 Accelerometer**

This is a popular 3-axis MEMs accelerometer that's great for applications sensing different kinds of motion and lack there of.

**Note:** Most breakout boards for the ADXL345 are also accessible through I2C.

#### LEDs and Microphones
This VU-meter example uses C.H.I.P. Pro Dev Kit's onboard mics and LEDs. The LED's brightness is mapped to the amplitude of the Mic inputs. Speak into or tap the mics to turn the LEDs on. 

If using a bare C.H.I.P. Pro additional hardware is needed. Connect LEDs to pins PE0 - PE7 and MEMs microphones to pins 26-29 labeled: AGND, MICIN1, MICIN2, and VMIC respectively.

#### Python CHIP_IO

####  Google Assistant
Google's Assistant API can be asked questions and be used to control hardware such as voice activated robots. 

#### Multiple Containers?

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
