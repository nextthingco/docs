# Quick Start [David]

To get the most from Gadget's lighting fast deployment process, development is done on a host computer. Once your code is ready for testing it's compiled and pushed to the hardware device connected via USB using GadgetOS' daemon GadgetOSD. To get started, install the following on your host computer and Gadget compatible hardware. 

## Install Gadget

On your host computer download and install NTC's command-line tool, GadgetCLI [here]. 

## Install Docker

	* If already installed make sure it's up to date

Gadget makes use of Docker's container system. Dependent on your host computer's OS, download and install the appropriate version of Docker using the below links. For more information on Docker, read [here](https://www.docker.com/).

* MacOS - [Docker CE](https://store.docker.com/editions/community/docker-ce-desktop-mac?tab=description)
* Windows 10 - [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
* Ubuntu - [Docker CE](https://store.docker.com/editions/community/docker-ce-server-ubuntu?tab=description)

## Flash GadgetOS 

For GadgetCLI to be able to talk to your hardware device it needs to be flashed with the latest GadgetOS image. Find the latest image on our [web flasher](flash.getchip.com/pro). 

## Hello World Example

Get up and running in minutes with this straight forward "Hello World" example.

1. **Create Project Directory**

	`mkdir hello-world'
	`cd hello-world`
	
2. **Initialize Project**

	`gadget init`
	
	This command creates a file called gadget.yml and generates a project called "hello-world". Open gadget.yml using Nano or another command-line editor. It should look like this:
	
	```bash
	spec: "0.0"
	name: directoryName
	uuid: 1789cc27-e1a8-40ef-aa1f-324092e6eff7
	type: docker
	onboot:
	- name: hello-world
  	  uuid: 1ef762fe-a500-41d1-8cf9-bbd621dd09b8
  	  image: arm32v7/hello-world
  	  directory: ""
  	  net: ""
  	  pid: ""
  	  readonly: false
  	  command: []
      binds: []
      capabilities: []
	services: []
	```
	
3. **Build, Deploy, and Start Image**

	Build image:
	
	`gadget build`
	
	```
	INFO[0000] Running in directory:                        
	INFO[0000]   /Users/xxxx/project/pathname/
	INFO[0000] Building:                                    
	INFO[0000]   'hello-world'
	```
	
	Deploy image to hardware:
	
	`gadget deploy`
	
	```
	INFO[0000] Running in directory:                        
	INFO[0000]   /Users/xxxx/project/pathname/ 
	INFO[0000]   Deploying: 'hello-world'                   
	INFO[0000]     Starting transfer..                      
	INFO[0000]     Done!  
	```
	
	Run container: 
	
	`gadget start`
	
	```
	INFO[0000] Running in directory:                        
	INFO[0000]   /Users/xxxx/project/pathname/ 
	INFO[0000] Starting:                                    
	INFO[0000]   hello-world_1ef762fe-a500-41d1-8cf9-bbd621dd09b8 
	INFO[0001]     - started 
	```
	
	
## Blink

Circuit: 
LED connected to pin 36, CSID0

A 'hello world' example that blinks an LED on pin 36. If using a bare C.H.I.P. Pro, connect a 5mm LED with a 220 Ohm resistor in series to pin 36 and ground. 

1. **Launch GadgetCLI**

2. **Connect Hardware**

	Using a USB cable connect your board to your host computer. Make sure the board is flashed with GadgetOS. LINK
	{Pic of Dev Kit connected to host computer}

3. **Create project directory**

	`mkdir blink`

4. **Initialize Project**

	Enter and create the gadget.yml configuration file in your project directory.

	`cd blink`
	
	`gadget init`
	
	A gadget.yml file can also be created from in project directory from parent. 
	
	`gadget -C blink init`


5. **Add Service** 

	`gadget add service blink`
	
	From parent directory:
	
	`gadget -C blink add service blinkdemo`
	

6. **Edit gadget.yml**

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
	
	**binds** - 
	
	**capabilities** - Grants Linux capabilities to the container. Specifically the ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations and allows access /dev/mem device with privileges. CHECK WITH LANGLEY

7. **Build, Deploy, and Start Image**

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
	
8. **Logs and Status**

	Check the status of the container:
	
	`gadget status`
	
	Look at the output logs of the container:
	
	`gadget logs`

### Exit GadgetCLI 

GadgetCLI simply opens a window using your host computer's terminal application. To exit, first stop the running application then exit. 

```shell
stop
exit 
```

### Gadget Commands 


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
