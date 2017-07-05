# Build With Gadget

At Gadget's heart is [Docker](https://docs.docker.com/). With GadgetCLI you will be building Docker images and running containers. Gadget makes orchestrating Docker images simple by wrapping up Docker functionality into one file: **gadget.yml**. 

The "hello world" example pulls an image from Docker Hub that is defined in the gadget.yml configuration file. To get more familiar with using gadget.yml, go through the next example which also pulls an existing image from Docker Hub and enables functionality needed by the container at runtime.

## Pull Remote Image

This example blinks an LED on pin 36, CSID0.

### 1. Set Up 
	
* Make sure to install all the necessary software outlined in [Set Up](http://ntc-docs-unstable.surge.sh/gadget.html#setup). 
* Connect C.H.I.P. Pro Dev Kit to your host computer via a USB cable. 

### 2. Create project directory

Fire up Terminal and create a space for your project to live in:

```
mkdir blinkdemo
```

### 3. Initialize Project

Enter and use `gadget init` to create a **gadget.yml** template file in your project directory.

```
cd blink
gadget init
```
	
A gadget.yml file can also be created from your project's parent directory. 
	
```
gadget -C blinkdemo/ init
```

Gadget will tell you that it created a new project:

```
Creating new project:
  in /Users/username/Documents/blinkdemo
``` 

### 4. Add Service

Containers that run from **onboot** like the “hello-world” example, will start in sequence from top to bottom. When their command process exits, the container will stop. The Blink container gets added as a service which will also run until its command process exits. The difference between services and onboot containers is that if a service container exits with a non-zero code, it will be automatically restarted. To learn more about the configurations of gadget.yml head over to the [Configuring Gadget.yml](http://ntc-docs-unstable.surge.sh/gadget.html#configuring-gadget-yml) section.

```
gadget add service gpio
```
	
From parent directory:
	
```
gadget -C blinkdemo/ add service gpio
```

### 5. Edit gadget.yml

In the project directory, open gadget.yml: 
	
```
nano gadget.yml
```

#### Make edits to the following fields:

* **image**
 
	```
	image: nextthingco/blink
	```
	
Specify an image to pull from the Docker Hub repo in this field. This example pulls an image from the "blink" repo under the "nextthingco" username.	 	
	
**Note:** If the tag is not included the image with the default "latest" tag will be pulled.

* **command**

	```
	command:['python', 'blink.py']
	```

Run the command `python blink.py` automatically when a container is started and upon reboot.

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
Mount the /sys directory from the host(gadgetOS) into the container at /sys. 
	
* **capabilities**

	
	```
	capabilities:[SYS_RAWIO]
	```

Enable Linux capabilities in the container. The ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations.

* **devices**

	```
	devices:[/dev/mem]
	```

Pass the raw Linux device at /dev/mem to the container.
	
The finished file will look like this:
	
```
services:
- name: gpio
uuid: Your-Containers-Uni-Que-UUID
image: nextthingco/blink 
directory: ""
net: ""
pid: ""
readonly: false
command: ['python', 'blink.py']
binds: ['/sys:/sys']
capabilities:[SYS_RAWIO]
devices:[/dev/mem]
```

Save and close gadget.yml

### 7. Build, Deploy, and Start Image

To build an image you must be in the same directory as the gadget.yml file. 

Your gadget.yml file now defines two containers: hello-world under **onboot** and blink in **services**. To work with one container specify it by name when running Gadget commands. For example, to **only build the blink image** rather than hello-world: 

```
gadget build gpio
```
When the image is done building, deploy and start:

```
gadget deploy gpio
gadget start gpio
```

From parent directory:

```
gadget -C blinkdemo/ build gpio
gadget -C blinkdemo/ deploy gpio
gadget -C blinkdemo/ start gpio
```

If the container builds, deploys and starts successfully you will see the following output messages:

```
#build
  Building:
    'hello-world'
    'gpio'

#deploy
  Stopping/deleting older 'hello-world' if applicable
  Deploying: 'hello-world'
    Starting transfer..
    
  Stopping/deleting older 'gpio' if applicable
  Deploying: 'gpio'
    Starting transfer..

#start
  Starting:
    hello-world_58915d6b-2770-4988-8f16-b681f3fc5fc7
      - started
      Starting:
    gpio_582583nb-2770-7658-8f16-f681h6fc2bk8
      - started
```

If any of these processes fail, Gadget will output an error along with suggestions of what may be the issue. Go to the [troubleshooting section](http://ntc-docs-unstable.surge.sh/gadget.html#troubleshooting) for more information.
	
### 8. Stop and Delete Container

```
gadget stop gpio
gadget delete gpio
```

**Note:** To build, deploy, delete, etc. all containers use gadget command without specified container name.

## Build Image Locally 

Most likely building images locally will be the process you will use the most as you develop and test applications. To build an image you need a Dockerfile and supporting files AKA the build's context. These files can either be written from scratch or cloned onto a development computer. 

Built images are then deployed to hardware for testing and further iterations. To share an image they can be pushed to an online repo which makes them available to be pulled to one or multiple devices at anytime.	

Follow along and build an image that uses Robert Wolterman's [CHIP_IO](https://github.com/xtacocorex/CHIP_IO) python library to access C.H.I.P. Pro Dev Kit's LEDs.


### 1. Create project directory

```
mkdir blinkdemo
cd blinkdemo
```

### 2. Create Dockerfile

Create a Dockerfile:

```
nano Dockerfile
```
	
Copy and paste the following content into the new Dockerfile. 

```bash
# Base image is arm32v6 Alpine Linux on Docker Hub
FROM arm32v6/alpine

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

```

Dockerfiles are capable of holding many kinds of instruction. To learn more, refer to Docker's [documentation](https://docs.docker.com/engine/reference/builder/). 

### 3. Create Supporting Files

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


### 4. Build

While still in the project directory build the image and give it a name.
	
```
docker build -t blink .
```

Docker will output all the build commands and tell you that it has successfully built.

![GR8](images/localBuild.png)


### 5. Deploy 

You are now ready to use GadgetCLI to deploy the image to your hardware for further testing. 

Step up one directory and create a gadget.yml file:

```
cd ..
gadget init
```

### 6. Add Service

Add a new service:

```
gadget add service gpio
```

### 7. Edit Gadget.yml

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
	directory:"blinkdemo" 
	```

In this field, put the path of the project directory containing the Dockerfile in relation to the gadget.yml file. 

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

Enable Linux capabilities in the container. The ones used here mount a FUSE (**F**ilesystem in **Use**rspace) based system for I/O operations.

* **devices**

	```
	devices:[/dev/mem]
	```

Pass the raw Linux device at /dev/mem to the container.
	
The finished section will look like this:
	
```
services:
- name: gpio
uuid: Your-Containers-U-U-ID
image: "" 
directory: "blinkdemo"
net: ""
pid: ""
readonly: false
command: ['python', 'blink.py']
binds: ['/sys:/sys']
capabilities:[SYS_RAWIO]
devices:[/dev/mem]
```

Save and close gadget.yml

### 8. Build, Deploy, and Start Container

```
gadget build gpio
gadget deploy gpio
gadget start gpio
```

### 9. Stop and Delete

When ready, stop the container and clean up:

```
gadget stop gpio
gadget delete gpio
```

### 10. Shell into GadgetOS

With GadgetCLI you have the ability to shell into GadgetOS at any time:

```
gadget shell
```

Once inside GadgetOS, use Docker commands to see images, running containers and to check NAND availability.

```shell
docker images #existing images
docker ps #running containers
df -h #check NAND availability
```

Exit shell:

```
exit
```

## Share Image

Gadget makes use of the growing community of official and community supported Docker images. Images that are pushed to [Docker Hub](https://hub.docker.com/) can be set to private or public. If public, they can be shared, pulled and used by coworkers, friends and the general public. 

**Share Source Files**

For collaborators to deploy and run containers they will need to know the configurations that go into gadget.yml. An easy way to share these is to create a GitHub repository [GitHub](https://github.com/) and push all source files to it. 


### 1. Create Registry and Repo

For this process you will need:

* a [Docker Hub](https://hub.docker.com/) registry to push and pull your built images to. 

* a [GitHub]((https://github.com/)) repository to hold all source files. 
	
[GitLab](https://docs.gitlab.com/ee/user/project/container_registry.html#enable-the-container-registry-for-your-project) has their own container registry and ways of working with Docker. If that is what you prefer you will need to push images according to their documentation. 

### 2. Login

Log into the repository account you created. Enter your username and password when prompted.
	
````
docker login
```

### 3. Tag

Tag the blink image with a version number. If an image is not tagged it will automatically be tagged with the default of "latest".

```
docker tag blink YourUserName/blink:v1 
```

### 4. Push

Push the image to your Docker Hub registry:

```
docker push YourUserName/blink:v1 
```

### 5. Pull 

The blink image is now ready to share and pull to your device. From here, the workflow is the same as the one outlined in the [Pull Image](http://ntc-docs-unstable.surge.sh/gadget.html#pull-remote-image-blink) section. 

## Example Images

Start a project with one of our example images. You can either pull an example from our official [NTC Docker Hub](https://hub.docker.com/r/nextthingco/) or `git clone` the repository to your development computer. All Dockerfiles and supporting files are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

Here you will find examples to get you started with popular sensors and breakout boards as well as how to load and run custom code.

* [Web Server:](https://hub.docker.com/u/nextthingco/) - Use Nginx to create a simple web server. 
	`image: nextthingco/webserver`
* [Blink in C](https://hub.docker.com/u/nextthingco/) - Blink an LED on pin 36, CSID0. Cross compile C applications easily in a Dockerfile.
* [Blink in Go](https://hub.docker.com/u/nextthingco/) - Blink an LED on pin 36, CSID0. Written in the [Go](https://golang.org/) language.
* [Blink in Rust](https://hub.docker.com/u/nextthingco/) - Blink an LED on pin 36, CSID0.
* [Blink in Node](https://hub.docker.com/u/nextthingco/) - Blink an LED on pin 36, CSID0.

#### Python

More to come before Thursday

* SPI
* Blinkenlights 
* VU meter
* I2C 

## Edit Examples

Clone the examples to your computer:

```
git clone https://github.com/NextThingCo/Gadget-Docker-Examples.git
```

* Edit the example files in a chosen project directory.
* [build the image on your host computer](http://ntc-docs-unstable.surge.sh/gadget.html#build-image-locally). 

**Note:** To build the image you will need to take the .yml config file out of the project directory first. 

* deploy to your hardware to test
