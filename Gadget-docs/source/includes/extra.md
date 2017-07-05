1. **Pull Remote Images**

	In this scenario, images are pulled from a remote location and deployed to hardware. See the Pull Images LINK section to learn about this process.

2. **Build Images Locally** 

	Build images locally on your development computer. This takes some Docker knowledge but gives you the most flexibility. See the Build Images Locally section LINK to learn more. Development is done on a host computer. Once your code is ready for testing it's compiled and pushed to your hardware device connected via USB using GadgetOS' daemon GadgetOSD. 

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


---- from pull image example

### 2. Connect Hardware 

Connect your board to your host computer via a USB cable. The board must be flashed with GadgetOS. If flashing the board for the first time unplug and plug the board back in after flashing to power cycle.
	
{Pic of Dev Kit connected to host computer}

The **gadget.yml** file is where all the configurations needed for a container at runtime go. It is also where you state which containers to run and in what order. To learn more go to the [Configuring Gadget.yml](http://ntc-docs-unstable.surge.sh/gadget.html#configuring-gadget-yml) section.


---- from examples sections

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

--- general extra

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


For general feedback and questions Lara and David will be available through the Chipster Slack channel.

----- 

### 8. Logs and Status

Check the status of the container:
	
```
gadget status
```	

Look at the output logs of the container:
	
```
gadget logs

---- edit examples

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

In this field put the path of the project directory containing the Dockerfile in relation to the gadget.yml file. In this example that is the blink directory. 

* **command**

	```
	command:['python', 'blink.py']
	```

Run the command `python blink.py` automatically upon `gadget start`. Any commands specified here will also run upon reboot go here.

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
Mounts the /sys directory from the host(gadget) into the container at /sys. 

Format: whereFrom:whereTo
	
* **capabilities**

	
	```
	capabilities:[SYS_RAWIO]
	```

Grant Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations. 

* **devices**

	```
	devices:[/dev/mem]
	```

Pass the raw Linux device at /dev/mem to the container.
	
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
command: ['python', 'blink.py']
binds: ['/sys:/sys']
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

<span style="font-size: 15px">**Uuid: Container ID**</span>