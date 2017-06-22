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

1. **Pull images**, including our demos, from Docker Hub and deploy to hardware. See the Pull Images LINK section to learn about this process.

2. **Build images** locally on a development computer. Use GadgetCLI to deploy and run containers on C.H.I.P. Pro and other Gadget supported hardware. See the Build Images Locally section LINK to learn more.

Follow the two Blink Example tutorials and get familiar with the ways you can work with Gadget. They each outline a different process. They both use Python and the CHIP_IO python library with a simple script that blinks an LED on pin 36, CSID0. 

**Circuit**

PIC of LED circuit with Dev Kit

**Note:** If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

## Pull Image: Blink Example

Start a project with one of our Python example images. Examples are pulled from the official [NTC Docker Hub](https://hub.docker.com/r/ntcgadget/). All supporting materials including Dockerfiles are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

**1. Launch GadgetCLI**

**2. Connect Hardware**

	Connect your board to your host computer via a USB cable. Make sure the board is flashed with GadgetOS before moving on. LINK
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
	
	<!-- -->
	
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
	
	`image: ntcgadget/blink:v1` - Pulls from the Docker Hub repo specified in this format -  username/repo:tag. Don't forget the version tag if it's not the default "latest". 
	
	`command:["python", "blink.py"]` - Runs a Python script called blink.py that is included in the image.
	
	`binds:[/sys:/sys]` - Mounts the /sys volume from the host device TKTK into the container at /sys.
	
	`capabilities:[--cap-add SYS_RAWIO --device /dev/mem]` - Grants Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations and allows access /dev/mem device with privileges. CHECK WITH LANGLEY

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

I would actually suggest what you did above. Start with a fresh gadget-os chippro, experiment/build/push to dockerhub. Then use gadgetcli for deployment and orchestration

**1. Create Repo**

	For this process you will need a repository on [Docker Hub](https://hub.docker.com/) or another online repo that you will push your custom built image to and then pull from. We will go over how to pull from Docker Hub and a url in the **Create Dockerfile** step. 

**2. Create project directory**

	```
	mkdir blink
	cd blink
	```

**3. Create Dockerfile**

	```
	nano Dockerfile
	```
	
	We will breifly go over what the Dockerfile for the blink example does but this by no means covers all instructions a Dockerfile can hold. To learn of all the capabilities refer to Docker's [documentation](https://docs.docker.com/engine/reference/builder/). 

	
	```
	
	# Base image is arm32v7 Alpine Linux on Docker Hub
	FROM armhf/alpine

	# Set and create a working directory called app
	WORKDIR /app

	# Copy the contents of the current directory into the working directory
	ADD . /app

	# Install tools needed to download and build the CHIP_IO library from source.
	RUN apk update && apk add make \
	 						  gcc \ 
	 						  g++ \
							  flex \
							  bison \ 
							  git \
							  
       	 	# Download python and tools for installing libraries
        					  python-dev \
        					  py-setuptools \
        					  
        	# Download source code for device tree compiler needed for CHIP_IO
        	git clone https://github.com/atenart/dtc.git \
        	
        	# Build and install the device tree compiler
        &&	cd dtc && make && make install PREFIX=/usr  \
        	
        	# Remove the device tree compiler source code now that we've built it
        &&	cd .. \
        && rm dtc -rf \
        	
        	# Download the latest CHIP_IO source code
        &&	git clone https://github.com/xtacocorex/CHIP_IO.git \
        	
        	# Install the CHIP_IO library from the proper directory
        &&	cd CHIP_IO && python setup.py install \
        	
        	# Remove CHIP_IO source code directory after it has been installed
        &&	cd ../ && rm -rf CHIP_IO \
        	
        	# Remove build tools, which are no longer needed after installation
        &&	apk del git \
         		    make \ 
         		    gcc \
         		    g++ \
         		    flex \
         		    bison

	CMD ["python", "blink.py"]
	
	```


**4. Create supporting files**

	Create blink Python script that imports CHIP_IO and turns an LED on and off that is connected to pin 36, CSID0.

	```
	nano blink.py
	```
	
	```
	import CHIP_IO.GPIO as GPIO
	from time import sleep


	ledPin = "CSID0"

	GPIO.setup(ledPin, GPIO.OUT)

	try:
		while True:
			GPIO.output(ledPin, True)
			sleep(1)
			GPIO.output(ledPin, False)
			sleep(1)
	
	#exit with CTRL+C			
	except KeyboardInterrupt:
		print("exiting")
	
	#unexport GPIOs upon exiting      
	finally:
		GPIO.cleanup() 
	```


**5. Build, Tag and Push**

	While still the project directory build image and give it a name.
	
	
	`docker build blink .`
	
 
	

	`docker login`
	
	

	`docker tag blinkdemo pushreset/blink:v1`
	
	`docker push pushreset/blink:v1`

	

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

## Gadget Commands  //test with june gadget version


On top of creating and building and deploying, Gadget offers options that apply to a specific project while in the project's directory. For example, commands like `stop` and `start` can be applied to stop a running project and to start it back it up again. To see all the commands and options available for use in GadgetCLI type:

```shell
gadget #or 
gadget --help
```

This menu will display:

```shell
usage: gadget <command> [<args>]

common gadget commands: 
  init        Create an empty gadget project 
  build       Build the project in the current directory
  deploy      Deploys the project in the current directory
  start       Starts the application on a device
  stop        Stops the application running on a device
  delete      Deletes the application instance from a device
  purge       Purges the application from a device
  status      Shows status information
  shell       Start debugging shell to investigate container
  log         Show container log

optional arguments:
  -h, --help  show this help message and exit

get help for specific command:
  gadget <command> --help
```


## Where and how to pass args to docker run commmand?

* add network 
* mapping ports
* sharing volumes
* kernel module
* device sharing between host and container
