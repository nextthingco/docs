# Build With Gadget 

Once you get the "hello world" example up and running you are ready to dive deeper. There are two ways we recommend when building with Gadget.

1. **Pull Images**

	Images are pulled from a remote location and deployed to hardware. See the Pull Images LINK section to learn about this process.

2. **Build Images** 

	Build images locally on your development computer. This takes some Docker knowledge but give you the most flexibility. See the Build Images Locally section LINK to learn more.

To get familiar with each process follow the two Blink tutorials. Both use Python and the CHIP_IO python library with a simple script that blinks an LED on pin 36, CSID0.  

## Requirements

Before moving on make sure you have gone through the Quickstart LINK section to meet the requirements.

### Hardware

* Host computer (Mac, Windows or Linux)
* Gadget compatible hardware
	* All examples pictured here are with the Dev Kit
* USB cable
	* Micro USB to USB cable (Dev Kit) 
	or
	* UART serial cable (bare C.H.I.P. Pro)

### Software

**Host Computer**

* GadgetCLI 
* Docker  

**Gadget Compatible Hardware**

* GadgetOS  

### Circuit

There is no need to build a circuit with the C.H.I.P. Pro Dev Kit, it uses the onboard LED on pin 36, CSID0.

If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

## Pull Image: Blink

### 1. Launch GadgetCLI and Docker
	
Docker works hand in hand with GadgetCLI. Open and keep Docker running in the background as you work.

### 2. Connect Hardware

Connect your board to your host computer via a USB cable. Make sure the board is flashed with GadgetOS before moving on. LINK
	
{Pic of Dev Kit connected to host computer}

### 3. Create project directory

Fire up Terminal and create a space for your project to live in:

```
mkdir blink
```

### 4. Initialize Project

Enter and create a gadget.yml template file in your project directory.

```
cd blink
gadget init
```
	
A gadget.yml file can also be created from your project's parent directory. 
	
```
gadget -C blink init
```


### 5. Add Service

```
gadget add service blink
```
	
	
From parent directory:
	
```
gadget -C blink add service blink
```

### 6. Edit gadget.yml

In the blink directory, open gadget.yml with a command-line text editor such as Nano and make the following edits:
	
```
nano gadget.yml
```
	
* Specify an image to pull from the Docker Hub repo in this field. This example pulls "v1" of an image from the "blink" repo under the "ntcgadget" username. State images in 		
	
Format: username/repo:tag. 
	
**Note:** If the tag is not included the image with the default "latest" tag will be pulled.

	```shell
	image: ntcgadget/blink:v1
	```

* Run the command `python blink.py` automatically upon `gadget start`. Any commands specified here will also run upon reboot go here.
	
	```shell
	command:["python", "blink.py"]
	```
	
* Mounts the /sys directory from the host(gadget) into the container at /sys. 
	
	Format: whereFrom:whereTo
	
	```shell
	binds:[/sys:/sys]
	```
	
* Grant Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations and allows access /dev/mem device with privileges. CHECK WITH LANGLEY
	
	```shell
	capabilities:[SYS_RAWIO]
	```
* Pass the raw Linux device at /dev/mem to the container

	```shell
	devices:[/dev/mem]
	
The finished section will look like this:
	
```shell
services:
- name: blink
uuid: Your-Containers-Uni-Que-UUID
image: ntcgadget/blink:v1 
directory: ""
net: ""
pid: ""
readonly: false
command: ["python", "blink.py"]
binds: [/sys:/sys]
capabilities: [--cap-add SYS_RAWIO --device /dev/mem]
```

Save and close gadget.yml

### 7. Build, Deploy, and Start Image

In the project directory:

```shell
gadget build 
gadget deploy 
gadget start
```
	
From parent directory:

```shell
gadget -C blink/blink build 
gadget -C blink/blink deploy 
gadget -C blink/blink start
```
		
### 8. Logs and Status

Check the status of the container:
	
```
gadget status
```	
Look at the output logs of the container:
	
```
gadget logs
```
	
	
### 9. Stop Container

```
gadget stop
```
	

## Build Image Locally: Blink 

Take the following steps to learn how to best develop with Gadget and Docker. 

I would actually suggest what you did above. Start with a fresh gadget-os chippro, experiment/build/push to dockerhub. Then use gadgetcli for deployment and orchestration

### 1. Create Repo

	For this process you will need a repository on [Docker Hub](https://hub.docker.com/) or another online repo that you will push your custom built image to and then pull from. We will go over how to pull from Docker Hub and a url in the **Create Dockerfile** step. 

### 2. Create project directory

```
mkdir blink
cd blink
```

### 3. Create Dockerfile

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


### 4. Create supporting files

Create blink Python script:

```
nano blink.py
```

Copy and paste this or create your own.

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


### 5. Build, Tag and Push

While still in the project directory build the image and give it a name.
	
```
docker build blink .
```
	
Log into your Docker Hub: 
	
````
docker login
```
	
Or, log into a repository hosted elsewhere:

```
docker login example-reg.githost.io
```

Tag the blink image with a version number. This is not mandatory but helps. 

```
docker tag blinkdemo pushreset/blink:v1 #Docker Hub
docker tag example-reg.githost.io/blinkdemo pushreset/blink:v1 #repo elsewhere
```

Push the image to your Docker Hub repository:

```
docker push pushreset/blink:v1 #Docker Hub
docker push example-reg.githost.io/blinkdemo #repo elsewhere
```
	

## Example Images

Start a project with one of our Python example images. Examples are pulled from our official [NTC Docker Hub](https://hub.docker.com/r/ntcgadget/). All supporting materials including Dockerfiles are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

Here you will find examples to get you started with popular sensors and breakout boards as well as how to load and run custom code. Before completing any of the examples make sure to go through the Quickstart [LINK] guide to meet the requirements below.

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

## Configuring Gadget.yml

The file gadget.yml is where container options go that are executed at run time. It is also where you define in what order containers run and whether they run once or continually. 

At the top of the file you find:

spec: "0.0"
name: blink
uuid: e6aa1456-8a4c-44d3-9c0a-06c9b8d1a96c
type: docker

The file is broken up into two sections: **onboot** and **services**. 

### onboot

Containers added to the onboot section runs after boot, then exits. When multiple containers are defined they run sequentially from top to bottom. 

Add a container:

`gadget add onboot projectname`
	
From parent directory:
	
`gadget -C blink add onboot projectname`


### services

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
