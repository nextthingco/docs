# Configuring Gadget.yml

At Gadget's heart is [Docker](https://docs.docker.com/). With GadgetCLI you will be building Docker [images and running containers](https://docs.docker.com/get-started/#a-brief-explanation-of-containers). Gadget makes orchestrating Docker images simple by wrapping up Docker functionality into one file: **gadget.yml**. 

Gadget.yml is where you define the container's resources, issue commands once a container is started and state what containers to run and in what order. For example, the ["hello world"](http://ntc-docs-unstable.surge.sh/gadget.html#hello-world) demo pulls an image from Docker Hub that is defined in the gadget.yml configuration file.  

**Note:** From here on out "host" refers to the Gadget compatible hardware running GadgetOS and "host computer" refers to the computer the Gadget compatible hardware is plugged into via USB.

## Onboot and Services

There are two sections to place and define containers in: **onboot** and **services**. Multiple containers can be put in each section and either all or one can be specified when running `gadget` commands:

Execute command on all containers:

```
gadget [options] COMMAND 
```

Execute command on one container:

```
gadget [options] COMMAND imageName
```

### Onboot

Containers that run from **onboot**, like the "hello-world" example, will run before containers placed in **services** and start in sequence from top to bottom. When their command process exits, the container will stop. 

Add a container to onboot:

```
gadget add onboot projectName
```
	
From parent directory:
	
```
gadget -C blinkdemo/ add onboot projectName
```


### Services

Containers defined under **services** run after containers listed in **onboot**. They are automatically restarted by Docker if it exits with a non-zero return code. 

Add a service:

```
gadget add service projectName
```
	
From parent directory:
	
```
gadget -C blinkdemo/ add service projectName
```

## Configurations

To learn more about what each configuration does on the Docker side click the title to be taken to the Docker documentation website.

<span style="font-size: 15px">**Name: Name of project**</span>

This entry gets generated when you add to onboot or service via the command:

```	
gadget add service|onboot projectName
``` 
	
If you choose to edit this field after generation the container will need to be built and deployed again.

__Format:__ `name: projectName`

<span style="font-size: 15px">**Uuid: Container ID**</span>

You can have several instances of the same image. These instances are identified by their uuid. For example, if you build an image then change the **command** configuration and build again you can see both instances on your host computer when you run:
	
```
docker images
```
__Format:__ `cont-ainer-uu-i-d`	

<span style="font-size: 15px">**Image: Pathname of Docker Hub image**</span>

An entry for `image:` is generated when you add to onboot or services via the command:

```
gadget add service|onboot projectName
```
	
To pull a base image from Docker Hub change `image:` to the username and repository you would like to pull from. The tag also needs to be included if a unique one was given when built, otherwise it will pull the image with the default ["latest" tag](https://docs.docker.com/get-started/part2/#tag-the-image). Learn more about [Docker Hub](https://docs.docker.com/docker-hub/) and how to use it.

__Format:__

Generated: `image: parent_directory/projectname`

Docker Image: `image: username/repoName:tag`
	
<span style="font-size: 15px">**Directory: Pathname of local image**</span>

Used when building and deploying images on your host machine rather than pulling from Docker Hub. Put the pathname of your Dockerfile and supporting files (the build's context) here in relation to the gadget.yml file. 

__Format:__ `directory: projDir`
	
<span style="font-size: 15px">**[Net:](https://docs.docker.com/engine/reference/run/#network-settings) Define which network to use or none**</span>

By default, all containers have networking enabled and can make outgoing connections. Use the following arguments to choose which network you would like the container to use:

| Network                | Description                                                                             |
|------------------------|-----------------------------------------------------------------------------------------|
| none                   | No networking in the container.                                                         |
| bridge                 | Connect the container to the bridge via veth interfaces.                                |
| host                   | Use the host's network stack inside the container.                                      |
| container: [name-UUID] | Use the network stack or another container, specified via its __name__ or __id__        |
| NETWORK                | Connects the container to a use created network (using `docker network create` command) |

Format: `net: host`  

<span style="font-size: 15px">**Readonly - Set to false by default**</span>

<span style="font-size: 15px">**Command - Run this command at start**</span>
	
Set a command to be executed automatically upon running a container with:
```
gadget start
```
If the CMD is used in the Dockerfile the 

__Format:__ `command: ['python', 'myPyScript.py']`
	
<span style="font-size: 15px">**Binds - Mount a directory**</span> 
	
Put any directories here that you would like to mount from the host into the container. 

__Format:__ `binds: ['/fromHostDir:/toContainerDir']`

<span style="font-size: 15px">**[Capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Enable [Linux capabilities](http://man7.org/linux/man-pages/man7/capabilities.7.html)**</span>
	
This is where specific Linux capabilities that bypass kernel permission checks get enabled. Some are enabled by default, all others are defined here depending on what is needed for the container at runtime.

__Format:__ `capabilities: [SYS_RAWIO]`

<span style="font-size: 15px">**[Devices](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Grant access to devices**</span>
	
Define a raw device in Linux to pass to a container. These are different from binds because Linux devices have several different modes of access.

__Format:__ `devices: [/dev/mem]`

**General Rules**

* When listing items in an array, surround each item with single quotes. For example:
	`binds: ['/sys:/sys']`
	`command: ['python', 'myScript.py']`
	
* By default, Docker containers are not allowed to access any devices and are "unprivileged". To access a device and get privileges to Linux capabilities they need to defined in `capabilities` and `devices`. Gadget does not promote nor enable operators to pass the `--privileged` flag to Docker's run command.




