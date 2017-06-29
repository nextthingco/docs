# Configuring Gadget.yml

GadgetCLI's function is built around the gadget.yml configuration file. This is where you define the container's resources, issue commands once a container is started and state what containers to run and in what order. 

The gadget.yml file conveniently wraps us Docker commands, options and parameters all in one place. To learn more about what each configuration does on the Docker side click the title to be taken to Docker documentation.

From here on out "host" refers to the Gadget compatible hardware running GadgetOS and "host computer" refers to the computer the Gadget compatible hardware is plugged into via USB.

Starting from the top of the file, here is what each section of gadget.yml does. 

```
spec: "0.0" #for future versioning
name: blink #generated from .yml file's parent directory 
type: docker 
```

## Onboot and Services

There are two sections to place and define containers in: **onboot** and **services**. 


### Onboot

Containers added to the **onboot** section run after boot, then exit. They run before containers placed in **services** and when multiple containers are defined they run sequentially from top to bottom. 

Add a container to onboot:

```
gadget add onboot projectName
```
	
From parent directory:
	
```
gadget -C blink add onboot projectName
```


### Services

Containers defined under **services** run after containers listed in **onboot**. They are automatically restarted by Docker if it exits with a non-zero return code. 

Add a service:

```
gadget add service projectName
```
	
From parent directory:
	
```
gadget -C blink add service projectName
```

## Configurations

<span style="font-size: 20px">**Name: Name of project**</span>

This entry gets generated when you add to onboot or service via the command:

```	
gadget add service|onboot projectName
``` 
	
If you choose to edit this field after generation the container will need to be built and deployed again.

Format

`name: projectName`
	
<span style="font-size: 20px">**Uuid: Container ID**</span>

You can have several instances of the same image. These instances are identified by their uuid. For example, if you build an image then change the **command** configuration and build again you can see both instances on your host computer when you run:
	
```
docker images
```
Format

`uni-versal-uniq-i-d`	

<span style="font-size: 20px">**Image: Pathname of Docker Hub image**</span>

An entry for `image:` is generated when you add to onboot or services via the command:

```
gadget add service|onboot projectName
```
	
To pull a base image from Docker Hub change `image:` to the username and repository you would like to pull from. The tag also needs to be included if a unique one was given when built, otherwise it will pull the image with the default ["latest" tag](https://docs.docker.com/get-started/part2/#tag-the-image). Learn more about [Docker Hub](https://docs.docker.com/docker-hub/) and how to use it.

Format:

Generated: `image: parent_directory/projectname`

Docker Image: `image: username/repoName:tag`
	
<span style="font-size: 20px">**Directory: Pathname of local image**</span>

Used when building and deploying images on your host machine rather than pulling from Docker Hub. Put the pathname of your Dockerfile and supporting files (the build's context) here in relation to the gadget.yml file. 

Format:

`directory: projDir`
	
<span style="font-size: 20px">**[Net:](https://docs.docker.com/engine/reference/run/#network-settings) Define which network to use or none**</span>

By default, all containers have networking enabled and can make outgoing connections. Use the following arguments to choose which network you would like the container use:

| Network                | Description                                                                             |
|------------------------|-----------------------------------------------------------------------------------------|
| none                   | No networking in the container.                                                         |
| bridge                 | Connect the container to the bridge via veth interfaces.                                |
| host                   | Use the host's network stack inside the container.                                      |
| container: <name | id> | Use the network stack or another container, specified via its __name__ or __id__        |
| NETWORK                | Connects the container to a use created network (using `docker network create` command) |

Format:

`net: host`  

<span style="font-size: 20px">**Pid -**</span>

<span style="font-size: 20px">**Readonly - Set to false by default**</span>

<span style="font-size: 20px">**Command - Run this command at start**</span>
	
Set a command to be executed automatically upon running a container with:
```
gadget start
```
If the CMD is used in the Dockerfile the 

Format
command: ['python', 'myPyScript.py']
	
<span style="font-size: 20px">**Binds - Mount a directory**</span> 
	
Put any directories here that you would like to mount from the host into the container. 

Format

`binds: ['/fromDir:/toDir']`

<span style="font-size: 20px">**[Capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Enable [Linux capabilities]([Capabilities](http://man7.org/linux/man-pages/man7/capabilities.7.html)**</span>
	
This is where specific Linux capabilities that bypass kernel permission checks get enabled. Some are enabled by default, all others are defined here depending on what is needed for the container at runtime.

Format

`capabilities: [SYS_RAWIO]`

<span style="font-size: 20px">**[Devices](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Grant access to devices**</span>
	
Define a raw device in Linux to pass to a container. These are different from binds because Linux devices have several different modes of access.

Format

`devices: [/dev/mem]`

**General Rules**

* When listing items in an array, surround each item with single quotes. For example:
	`binds: ['/sys:/sys']`
	`command: ['python', 'myScript.py']`
	
* By default, Docker containers are not allowed to access any devices and are "unprivileged". To access a device and get privileges to Linux capabilities they need to defined in `capabilities` and `devices`. Gadget does not promote nor enable operators to pass the `--privileged` flag to Docker's run command.




