# Build With Gadget

Once you get the "hello world" example up and running you are ready to dive deeper. There are two ways we recommend building with Gadget.

1. **Pull Remote Images**

	In this scenario, images are pulled from a remote location and deployed to hardware. See the Pull Images LINK section to learn about this process.

2. **Build Images Locally** 

	Build images locally on your development computer. This takes some Docker knowledge but gives you the most flexibility. See the Build Images Locally section LINK to learn more.

To get familiar with each process follow the two Blink tutorials. Both use Python and the CHIP_IO python library with a simple script that blinks an LED on pin 36, CSID0.  

## Requirements

Before moving forward, make sure you have gone through the Quickstart LINK section to meet the below requirements.

### Hardware

* Host computer (Mac, Windows 10 or Linux)
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

If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

There is no need to build a circuit with the C.H.I.P. Pro Dev Kit, it uses the onboard LED on pin 36, CSID0.

## Pull Image: Blink

### 1. Open GadgetCLI and Docker
	
Docker works hand in hand with GadgetCLI. Open and keep Docker running in the background as you work with GadgetCLI.

### 2. Connect Hardware 

Connect your board to your host computer via a USB cable. The board must be flashed with GadgetOS. If flashing the board for the first time unplug and plug the board back in after flashing to power cycle.
	
{Pic of Dev Kit connected to host computer}

### 3. Create project directory

Fire up Terminal and create a space for your project to live in:

```
mkdir blink
```

### 4. Initialize Project

Enter and use `gadget init` to create a **gadget.yml** template file in your project directory.

```
cd blink
gadget init
```
	
A gadget.yml file can also be created from your project's parent directory. 
	
```
gadget -C blink init
```

Gadget will tell you that it created a new project:

```
Creating new project:
  in /Users/username/Documents/blink
```

The **gadget.yml** file is where all the configurations needed for a container at runtime go. It is also where you state which containers to run and in what order. To learn more go to the Configuring Gadget.yml LINK section. 

### 5. Add Service

```
gadget add service blink
```
	
From parent directory:
	
```
gadget -C blink add service blink
```

Gadget notifies you of a new service added:

```
Running in directory:
  /Users/username/Documents/blink
Adding new service: "blink"
```

### 6. Edit gadget.yml

In the project directory, open gadget.yml with a command-line text editor such as Nano: 
	
```
nano gadget.yml
```

#### Make edits to the following fields:

* **image**
 
	```
	image: ntcgadget/blink
	```
	
Specify an image to pull from the Docker Hub repo in this field. This example pulls "v1" of an image from the "blink" repo under the "ntcgadget" username.		
	
Format: username/repo:tag. 
	
**Note:** If the tag is not included the image with the default "latest" tag will be pulled.

* **command**

	```
	command:[python, blink.py]
	```

Run the command `python blink.py` automatically when a container is started and upon reboot.

	
* **binds**
	
	```
	binds:["/sys:/sys"]
	```
	
Mounts the /sys directory from the host(gadget) into the container at /sys. 

Format: whereFrom:whereTo
	
* **capabilities**

	
	```
	capabilities:[SYS_RAWIO]
	```

Grant Linux capabilities to the container. The ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations. CHECK WITH LANGLEY

* **devices**

	```
	devices:[/dev/mem]
	```

Pass the raw Linux device at /dev/mem to the container to allow access with privileges.  CHECK WITH LANGLEY
	
The finished section will look like this:
	
```
services:
- name: blink
uuid: Your-Containers-Uni-Que-UUID
image: ntcgadget/blink 
directory: ""
net: ""
pid: ""
readonly: false
command: [python, blink.py]
binds: ["/sys:/sys"]
capabilities:[SYS_RAWIO]
devices:[/dev/mem]
```

Save and close gadget.yml

### 7. Build, Deploy, and Start Image

To build an image you must be in the same directory as the gadget.yml file. 

Your gadget.yml file now defines two containers: hello-world under onboot and blink in services. To work with one container specify it by name when running Gadget commands. For example to only build the blink image rather than hello-world then blink: 

```
gadget build blink
```
When the image is done building, deploy and start:

```
gadget deploy blink
gadget start blink
```

From parent directory:

```
gadget -C blink build blink
gadget -C blink deploy blink
gadget -C blink start blink
```

If the container builds, deploys and starts successfully you will see the following output messages:

```
#build
  Building:
    'hello-world'
    'blink'

#deploy
  Stopping/deleting older 'hello-world' if applicable
  Deploying: 'hello-world'
    Starting transfer..
    
  Stopping/deleting older 'blink' if applicable
  Deploying: 'blink'
    Starting transfer..

#start
  Starting:
    hello-world_58915d6b-2770-4988-8f16-b681f3fc5fc7
      - started
```

If any of these processes fail Gadget will output an error along with suggestions of what may be the issue. Go to the troubleshooting section LINK for more information.
		
### 8. Logs and Status

Check the status of the container:
	
```
gadget status
```	

Look at the output logs of the container:
	
```
gadget logs
```

From parent directory:

```
gadget -C blink status blink
gadget -C blink logs blink
```	
	
### 9. Stop and Delete Container


```
gadget stop
gadget delete
```

From parent directory:

```
gadget -C blink stop blink
gadget -C blink delete blink
```
	

## Build Image Locally: Blink 

Images built on a local machine are pushed to an online repo and are then available to be pulled to one or multiple devices at anytime.

I would actually suggest what you did above. Start with a fresh gadget-os chippro, experiment/build/push to dockerhub. Then use gadgetcli for deployment and orchestration

### 1. Create Repo

For this process you will need a [Docker Hub](https://hub.docker.com/) repository to push and pull your built images to. 
	
Popular git repositories such as GitLab and GitHub have their own container repos and ways of working with Docker. If that is what you prefer you will need to push images according to their documentation.


### 2. Create project directory

```
mkdir blink
cd blink
```

### 3. Create Dockerfile

Create a Dockerfile using a command-line editor such as Nano. 

```
nano Dockerfile
```
	
Copy and paste the following content into the new Dockerfile. 

```bash
# Base image is arm32v7 Alpine Linux on Docker Hub
FROM armhf/alpine

# Set and create a working directory called app
WORKDIR /app

# Copy the contents of the current directory into the working directory
ADD . /app

# Install tools needed to download and build the CHIP_IO library from source.
RUN apk update && apk add bison \
						  flex \
						  g++ \
						  gcc \ 
						  git \
						  make \
						  
		# Download python and tools for installing libraries
						  python-dev \
						  py-setuptools \
						  
		# Download source code for device tree compiler needed for CHIP_IO
	&&	git clone https://github.com/NextThingCo/dtc.git \
		
		# Build and install the device tree compiler
	&&	cd dtc && make && make install PREFIX=/usr  \
		
		# Remove the device tree compiler source code now that we've built it
	&&	cd .. \
	&&  rm dtc -rf \
		
		# Download the latest CHIP_IO source code
	&&	git clone https://github.com/xtacocorex/CHIP_IO.git \
		
		# Install the CHIP_IO library from the proper directory
	&&	cd CHIP_IO && python setup.py install \
		
		# Remove CHIP_IO source code directory after it has been installed
	&&	cd ../ && rm -rf CHIP_IO \
		
		# Remove build tools, which are no longer needed after installation
	&&	apk del bison \
				flex \
				g++ \
				gcc \
				git \
				make 

CMD ["python", "blink.py"]
```

Dockerfiles are capable of holding many kinds of instruction. To learn more, refer to Docker's [documentation](https://docs.docker.com/engine/reference/builder/). 

### 4. Create Supporting Files

Create a Python script named blink:

```
nano blink.py
```

Copy and paste this simple blink python script or, feel free to create your own.

```python
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


### 5. Build

While still in the project directory build the image and give it a name.
	
```
docker build -t blink .
```

Docker will output all the build commands and tell you that it has successfully built.

![GR8](images/localBuild.png)

### 6. Login

Log into the repository account you created. Enter your username and password when prompted.
	
````
docker login
```

### 7. Tag

Tag the blink image with a version number. If an image is not tagged it will automatically be tagged with the default of "latest".

```
docker tag blink YourUserName/blink:v1 
```

### 8. Push

Push the image to your Docker Hub repository:

```
docker push YourUserName/blink:v1 
```

### 9. Pull 

The blink image is now ready to share and pull to your device. From here, the workflow is the same as the one outlined in Pull Image. Here is a condensed version of the steps. 

* Open and run Docker (if not already) and GadgetCLI
* Connect hardware flashed with GadgetOS to host machine via USB
* Create a new project directory, separate from the one that contains the Dockerfile, and enter it.
* Initialize project

```
gadget init
```
* Add service to gadget.yml

```
gadget add service blink
```
* Edit gadget.yml

```
services:
- name: blink
uuid: Your-Containers-Uni-Que-UUID
image: ntcgadget/blink:v1 
directory: ""
net: ""
pid: ""
readonly: false
command: [python, blink.py]
binds: ["/sys:/sys"]
capabilities:[SYS_RAWIO]
devices:[/dev/mem]
```
* Build

```
gadget build
```
* Deploy

```
gadget deploy
```
* Start

```
gadget start
```
* Stop

```
gadget stop
```
* Delete

```
gadget delete
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

## Edit Examples

Experiment and develop with this process. 

### 1. Obtain Source Code

The source code can be a previously written program on your local computer or you can start with one of our example scripts. For this tutorial we will use a simple blink example. 

Clone the examples to your computer:
```
git clone https://github.com/NextThingCo/Gadget-Docker-Examples.git
```
### 2. Initialize Project

Enter the Gadget-Docker-Examples directory and create a gadget.yml template there. This is where you will orchestrate your image builds while testing scripts and Dockerfiles in the project directories. 

```
cd Gadget-Docker-Examples
gadget init
```

### 3. Add Service

Add a service to gadget.yml.

```
gadget add service blink
```


### 3. Edit Gadget.yml

Edit gadget.yml using a command-line editor such as Nano.

```
nano gadget.yml
```

#### Make edits to the following fields:

* **image**
 
	```
	image: "" #leave empty
	```
This field is reserved for pulling images from Docker Hub, so for this workflow it stays empty.

* **directory**

	```
	directory:"blink" 
	```

In this field put the pathname of the project directory containing the Dockerfile in relation to the gadget.yml file. In this example that is the blink directory. 

* **command**

	```
	command:[python, blink.py]
	```

Run the command `python blink.py` automatically upon `gadget start`. Any commands specified here will also run upon reboot go here.

	
* **binds**
	
	```
	binds:["/sys:/sys"]
	```
	
Mounts the /sys directory from the host(gadget) into the container at /sys. 

Format: whereFrom:whereTo
	
* **capabilities**

	
	```
	capabilities:[SYS_RAWIO]
	```

Grant Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations. CHECK WITH LANGLEY

* **devices**

	```
	devices:[/dev/mem]
	```

Pass the raw Linux device at /dev/mem to the container to allow access with privileges.  CHECK WITH LANGLEY
	
The finished section will look like this:
	
```
services:
- name: blink
uuid: Your-Containers-Uni-Que-UUID
image: "" 
directory: "blink"
net: ""
pid: ""
readonly: false
command: [python, blink.py]
binds: ["/sys:/sys"]
capabilities:[SYS_RAWIO]
devices:[/dev/mem]
```

Save and close gadget.yml

### 4. Build, Deploy, and Start Container

```
gadget build 
gadget deploy
gadget start
```

### 5. Stop and Delete

When ready, stop the container and clean up:

```
gadget stop
gadget delete
```

### 6. Shell into GadgetOS

With GadgetCLI you have the ability to shell into GadgetOS at any time:

```
gadget shell
```

See what containers are currently running:

```
docker ps
```

Exit shell:

```
exit
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
