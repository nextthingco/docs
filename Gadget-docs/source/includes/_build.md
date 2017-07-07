# Build With Gadget

To get more familiar with using gadget.yml, go through the next example which also pulls an existing image from Docker Hub and enables functionality needed by the container at runtime.

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
cd blinkdemo
gadget init
```

Gadget will tell you that it created a new project:

```
Creating new project:
  in /Users/$USER/Documents/blinkdemo
``` 

### 4. Add Service

To build and run a project a container needs to be defined and configured either under **services** or **onboot** in the gadget.yml.  

By default, gadget.yml is created with the example "hello-world" project along with a set of configurations. Another set of configurations needs to be generated for the new **gpio** project. To do this use the `add` command, set it as a service and give it the name **gpio**:

```
gadget add service gpio
```

### 5. Edit gadget.yml

In the project directory, open gadget.yml: 
	
```
nano gadget.yml
```

The gadget.yml file now defines two containers: "hello-world" under **onboot** and "gpio" in **services**. 

#### Make edits to the following fields under services:

* **image**
 
	```
	image: nextthingco/gadget-blink-c
	```
	
Specify an image to pull from the Docker Hub repo in this field. This example pulls an image from the "gadget-blink-c" repo under the "nextthingco" username.	 	
	
**Note:** If the [tag](https://docs.docker.com/engine/reference/commandline/tag/) is not included the image with the default "latest" tag will be pulled.

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
The finished file will look like this:
	
```
services:
- name: gpio
uuid: Your-Containers-U-U-ID
image: nextthingco/gadget-blink-python 
directory: ""
net: ""
pid: ""
readonly: false
command: []
binds: ['/sys:/sys']
capabilities:[]
devices:[]
```

Save and close gadget.yml

### 7. Build, Deploy, and Start Image

To build an image you must be in the same directory as the gadget.yml file. 

To work with one container specify it by name when running Gadget commands. For example, to **only build the gpio image** rather than hello-world: 

```
gadget build gpio
```
When the image is done building, deploy and start:

```
gadget deploy gpio
gadget start gpio
```

If the container builds, deploys and starts successfully you will see the following output messages:

```
#### build output
  Building:
    'hello-world'
    'gpio'

#### deploy output
  Stopping/deleting older 'hello-world' if applicable
  Deploying: 'hello-world'
    Starting transfer..
    
  Stopping/deleting older 'gpio' if applicable
  Deploying: 'gpio'
    Starting transfer..

#### start output
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

<aside class="notice">
To build, deploy, delete, etc. all containers use gadget command without specified container name.
</aside>

## Build Image Locally 

Most likely building images locally will be the process you will use the most as you develop and test applications. To build an image you need a Dockerfile and supporting files AKA the build's context. These files can either be written from scratch or cloned onto a development computer. 

Built images are then deployed to hardware for testing and further iterations. To share an image they can be pushed to an online registry which makes them available to be pulled to one or multiple devices at anytime.	

Follow along and build an example written in C that makes use of an GPIO pin on the C.H.I.P. Pro Dev Kit.

### 1. Create project directory

```
mkdir blinkLocal
cd blinkLocal
```

### 2. Create Dockerfile

Create a Dockerfile:

```
nano Dockerfile
```
	
Copy and paste the following content into the new Dockerfile. 

```bash
FROM debian:stretch-slim

WORKDIR .
RUN apt-get -yqq update 
RUN apt-get install -y crossbuild-essential-armhf
COPY gpio.c .
RUN arm-linux-gnueabihf-gcc gpio.c -o gpio -static

FROM scratch
COPY --from=0 gpio .
CMD ["./gpio"]
```
For an explanation of what each line of the Dockerfile does reference the Readme file in the [example's GitHub repo](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-c).

Dockerfiles are capable of holding many kinds of instruction. To learn more about makes one up refer to Docker's [documentation](https://docs.docker.com/engine/reference/builder/). 

### 3. Create Supporting Files

Create a C file named gpio:

```
nano gpio.c
```
Copy and paste [this program](https://github.com/NextThingCo/Gadget-Docker-Examples/blob/master/gadget-blink-c/gpio.c) in the newly created file.

### 4. Build

While still in the project directory build the image. Use the [-t flag](https://docs.docker.com/engine/reference/commandline/build/#options) to give the image a name. A tag can also optionally be added. Here the image is given the name "blink". 
	
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
gadget add service gpio-c
```

### 7. Edit Gadget.yml

```
nano gadget.yml
```

#### Make edits to the following fields under **services:**

* **image**
 
	```
	image: "" #leave empty
	```
This field is reserved for pulling images from Docker Hub, so for this workflow it stays empty.

* **directory**

	```
	directory:"blinkLocal" 
	```

In this field, put the path of the project directory containing the Dockerfile in relation to the gadget.yml file. 

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
Mounts the /sys directory from the host(gadget) into the container at /sys. 
	
```
services:
- name: gpio-c
uuid: Your-Containers-U-U-ID
image: "" 
directory: "blinkLocal"
net: ""
pid: ""
readonly: false
command: []
binds: ['/sys:/sys']
capabilities:[]
devices:[]
```

Save and close gadget.yml

### 8. Build, Deploy, and Start Container

```
gadget build gpio-c
gadget deploy gpio-c
gadget start gpio-c
```

### 9. Stop and Delete

When ready, stop the container and clean up:

```
gadget stop gpio-c
gadget delete gpio-c
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

For collaborators to deploy and run containers they will need to know the [configurations that go into gadget.yml](http://ntc-docs-unstable.surge.sh/gadget.html#configuring-gadget-yml). An easy way to share these is to create a [GitHub](https://github.com/) repository to push all of the source files to.


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

[Tag](https://docs.docker.com/engine/reference/commandline/tag/) the blink image with a version number. If an image is not tagged it will automatically be tagged with the default of "latest".

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

**Docker Hub Images**

* [Web Server](https://hub.docker.com/r/nextthingco/gadget-webserver/) - Use Nginx to host web content from your device.
* [Blink in C](https://hub.docker.com/r/nextthingco/gadget-blink-c/) - Cross compile C applications easily in a Dockerfile. A gnu89 compatible C example of GPIO usage, easily translatable to C++.
* [Blink in Go](https://hub.docker.com/r/nextthingco/gadget-blink-go/) - Written in Golang. 
* [Blink in Rust](https://hub.docker.com/r/nextthingco/gadget-blink-rust/) - Written in Rustlang.
* [Blink in Node](https://hub.docker.com/r/nextthingco/gadget-blink-node/) - Javascript example running on top of Node.
* [Blink in Python](https://hub.docker.com/r/nextthingco/gadget-blink-python/) - Python GPIO example using the community-run library [CHIP_IO](https://github.com/xtacocorex/CHIP_IO).
* Blink with Multiple Containers - A demonstration of a multiple-container project running all of the Blink examples at once.

**Run an Example**

* Follow the steps under [Pull Remote Image](http://ntc-docs-unstable.surge.sh/gadget.html#pull-remote-image) up to **Step 5**. 
* Download and use the project's gadget.yml configuration file from the source file GitHub repo to build and run the container with.

**Source files:**

* [Web Server](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-webserver)
* [Blink in C](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-c)
* [Blink in Go](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-go)
* [Blink in Rust](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-rust)
* [Blink in Node](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-node)
* [Blink in Python](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-python)
* [Blink with Multiple Containers](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-multi)

**Edit Examples**

* Clone the examples to your computer:

```
git clone https://github.com/NextThingCo/Gadget-Docker-Examples.git
```

* Edit the source files in a chosen project directory.
* [build and deploy the image on your host computer](http://ntc-docs-unstable.surge.sh/gadget.html#build-image-locally). Each project directory has a gadget.yml file that contains the needed configurations for that specific container. 

**Note:** To build the image you will need to take the .yml config file out of the project directory first. 


