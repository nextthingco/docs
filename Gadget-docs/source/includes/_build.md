# Build With Gadget

To get more familiar with using gadget.yml, go through the following examples which pulls from an image on Docker Hub and builds and deploys an image from your host computer. Each example blinks an LED on C.H.I.P. Pro Dev Kit.

## Pull Remote Image

### 1. Set Up 
	
* Make sure to install all the necessary software outlined in [Set Up](http://ntc-docs-unstable.surge.sh/gadget.html#set-up-gadget). 
* Connect C.H.I.P. Pro Dev Kit to your host computer via a USB cable. 

### 2. Create project directory

Fire up Terminal and create a space for your project to live in:

```
mkdir blinkdemo
```

### 3. Initialize Project

Enter your project directory and use `gadget init` to create a **gadget.yml** template file.

```
cd blinkdemo
gadget init
```

GadgetCLI will tell you that it created a new project:

```
Creating new project:
  in /Users/$USER/Documents/blinkdemo
``` 

### 4. Add Service

To build and run a project a container needs to be defined and configured either under **services** or **onboot** in the gadget.yml.  

By default, gadget.yml is created with the example "hello-world" project along with a set of configurations. In this example, you'll add another a service called gpio to the configuration file. To do this use the `add` command, set it as a **service**, and give it a **name**, such as "gpio":

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
	
**Note:** If an image does not receive a [tag](https://docs.docker.com/engine/reference/commandline/tag/) when built and pushed to Docker Hub you do not include it, like for this example. However, if an image is tagged when built and you want to pull it from Docker Hub the [tag](https://docs.docker.com/docker-hub/repos/#viewing-repository-tags) needs to be [included](http://ntc-docs-unstable.surge.sh/gadget.html#configurations). You can see available tags by clicking on the Tags tab in a Docker Hub repo. Sometimes tags are included in the images description on Docker Hub, but not always.

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
The finished file will look like this:
	
```
services:
- name: gpio
uuid: Your-Containers-U-U-ID
image: nextthingco/gadget-blink-c 
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

### 7. Build, Deploy, and Start an Image

To build an image you must be in the same directory as the gadget.yml file. By default the GadgetCLI commands will effect all the containers specified in your gadget.yml file. 

To work with one container, as you'll do in this example,  specify it by name when running GadgetCLI commands. For example, to **only build the gpio image** run the following command: 

```
gadget build gpio
```
When the image is done building, deploy, and start your container. Here's how:

```
gadget deploy gpio
gadget start gpio
```

If the container builds, deploys, and starts successfully you will see the following output messages and **Pin 34, CSID3 will start blinking**:

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

If any of these processes fail, GadgetCLI will output an error along with suggestions of what may be the issue. Go to the [troubleshooting section](http://ntc-docs-unstable.surge.sh/gadget.html#troubleshooting) for more information.
	
### 8. Stop and Delete Containers

```
gadget stop gpio
gadget delete gpio
```

## Build Image Locally 

You will most likely build container images locally as you develop and test your applications. To build an image you need a Dockerfile and supporting files AKA the build's context. These files can either be written from scratch or cloned from an existing repo to your computer. 

Built images are then deployed to hardware for testing and further iterations. You can share an image by pushing it to an online registry making it available to be pulled to other devices.	

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
For an explanation of what each line of this Dockerfile does, refer to the README file in the [example's GitHub repo](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-c).

Dockerfiles are capable of holding many kinds of instruction. To learn more about what makes a Dockerfile and it's full capabilities refer to Docker's [documentation](https://docs.docker.com/engine/reference/builder/). 

### 3. Create Supporting Files

Create a .c file named "gpio":

```
nano gpio.c
```
Copy and paste [this program](https://github.com/NextThingCo/Gadget-Docker-Examples/blob/master/gadget-blink-c/gpio.c) into the newly created file.

### 4. Build

While still in the project directory build the image. Use the [-t flag](https://docs.docker.com/engine/reference/commandline/build/#options) to give the image a name, such as "blink". 
	
```
docker build -t blink .
```

Docker will output all the build commands and tell you that it has successfully built.

![GR8](images/success.png)


### 5. Deploy 

You are now ready to use GadgetCLI to deploy the image to your hardware. 

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
This field is reserved for pulling images from Docker Hub, so for this workflow, it stays empty.

* **directory**

	```
	directory:"blinkLocal" 
	```

In this field, put the path of the project directory containing the Dockerfile in relation to the gadget.yml file. 

	
* **binds**
	
	```
	binds:['/sys:/sys']
	```
	
The binds: command mounts the /sys directory from the host into the container at /sys. 
	
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

Pin 34, CSID3 will start blinking!

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

Once inside GadgetOS, use Docker commands to see images, running containers and to check NAND storage availability.

```shell
docker images #existing images
docker ps #running containers
df -h #check NAND availability
```
To remove forgotten docker images from the host device:

```shell
docker rmi -f [image ID] #remove images
```
Exit shell:

```
exit
```

## Share Image

Gadget makes use of the growing community of official and community supported Docker images. Images that are pushed to [Docker Hub](https://hub.docker.com/) can be set to private or public. If public, they can be shared, pulled and used by coworkers, friends and the general public. 

**Share Source Files**

For collaborators to deploy and run your containers, they will need to know the [configurations that go into gadget.yml](http://ntc-docs-unstable.surge.sh/gadget.html#configuring-gadget-yml). We recommend sharing these in a [GitHub](https://github.com/) repository.


### 1. Create Registry and Repo

For this process you will need:

* a [Docker Hub](https://hub.docker.com/) registry to push and pull your built images to. 

* a [GitHub]((https://github.com/)) repository to hold all source files. 
	
[GitLab](https://docs.gitlab.com/ee/user/project/container_registry.html#enable-the-container-registry-for-your-project) has their own container registry and ways of working with Docker.

### 2. Login

Log into the Docker account you created. Enter your username and password when prompted.
	
````
docker login
```

### 3. Tag

[Tag](https://docs.docker.com/engine/reference/commandline/tag/) the image with a version number (optional) and create a repo for it. If an image is not tagged, it will automatically be tagged with the default of "latest."

```
docker tag blink YourUserName/blink:v1 
```
This command tags the image you created called [blink](http://ntc-docs-unstable.surge.sh/gadget.html#4-build) with "v1", specified it's location within YourUserName, and in the repository "blink". 
 
### 4. Push

Push the image to your Docker Hub registry:

```
docker push YourUserName/blink:v1 
```

### 5. Pull 

After posting to your registry, the blink image is ready to share and pull to your device. From here, the workflow is the same as the one outlined in the [Pull Image](http://ntc-docs-unstable.surge.sh/gadget.html#pull-remote-image) section. Visit the newly created Docker repo and fill in the description and add a link to your GitHub source files.

## Example Images

Start a project with one of our example images. You can either pull an example from our official [NTC Docker Hub](https://hub.docker.com/r/nextthingco/) or `git clone` the [GitHub repository](https://github.com/NextThingCo/Gadget-Docker-Examples) that includes all the example source files to your development computer. All Dockerfiles and supporting files are found [here](https://github.com/NextThingCo/Gadget-Docker-Examples). 

**Docker Hub Images**

* [Web Server](https://hub.docker.com/r/nextthingco/gadget-webserver/) - Use Nginx to host web content from your device. Currently supported on MacOS and Windows.
* [Blink in C](https://hub.docker.com/r/nextthingco/gadget-blink-c/) - A gnu89 compatible C example of GPIO usage, easily translatable to C++. Cross compile C applications easily in a Dockerfile. 
* [Blink in Go](https://hub.docker.com/r/nextthingco/gadget-blink-go/) - Written in Golang. 
* [Blink in Rust](https://hub.docker.com/r/nextthingco/gadget-blink-rust/) - Written in Rustlang.
* [Blink in Node](https://hub.docker.com/r/nextthingco/gadget-blink-node/) - Javascript example running on top of Node.
* [Blink in Python](https://hub.docker.com/r/nextthingco/gadget-blink-python/) - Python GPIO example using the community-run library [CHIP_IO](https://github.com/xtacocorex/CHIP_IO). Currently supported on MacOS and Windows.

**Run an Example**

* Follow the steps under [Pull Remote Image](http://ntc-docs-unstable.surge.sh/gadget.html#pull-remote-image). 
* Download and use the project's gadget.yml configuration file from our GitHub repo to build and run the container with instead of the configurations listed in the steps.

**Source files:**

* [Web Server](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-webserver)
* [Blink in C](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-c)
* [Blink in Go](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-go)
* [Blink in Rust](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-rust)
* [Blink in Node](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-node)
* [Blink in Python](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-python)
* [Blink with Multiple Containers](https://github.com/NextThingCo/Gadget-Docker-Examples/tree/master/gadget-blink-multi)

**Edit Examples**

* Clone all the examples to your computer:

```
git clone https://github.com/NextThingCo/Gadget-Docker-Examples.git
```

* Edit the source files in a chosen project directory.
* [Build and deploy the project from your host computer](http://ntc-docs-unstable.surge.sh/gadget.html#build-image-locally). Each project directory has a gadget.yml file that contains the needed configurations for that specific container. 

<aside class="notice">To successfully build an image in the project directory the gadget.yml config file needs to be removed from it first.</aside>


