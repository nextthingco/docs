# Configuring Gadget.yml

At the heart of GadgetOS is a container system called [Docker](https://docs.docker.com/). While GadgetOS runs containers,  GadgetCLI helps you build, run, and manage them.
 If you're new to containers, check out [this primer](https://docs.docker.com/get-started/#a-brief-explanation-of-containers). Together, GadgetOS and GadgetCLI make orchestrating container images easy by using one configuration file: **gadget.yml**.

Gadget.yml is where you define resources available to the container, issue commands to the running container, specify which containers to run and in what order, and much, much more. For example, the ["hello world"](https://docs.getchip.com/gadget.html#hello-world) demo uses a gadget.yml file that uses a container available on Docker Hub.

There are two sections to define and configure containers in: **onboot** and **services**. You can put multiple container configurations in each section and you can use GadgetCLI to specify which container to control: all of them or just one.

To execute commands on all containers on your development machine run the gadget command without any container image name specified.

```
gadget [options] COMMAND
```

To execute a command on a particular container, specify the containner name. 

```
gadget [options] COMMAND imageName
```

## Onboot

Containers in the **onboot** section, like the "hello-world" example, are executed before containers in the **services** section. All containers in the gadget.yml file execute sequentially from top to bottom of the configuration file. When their command process exits, the container will stop.

To add a container to onboot, run the following command.

```
gadget add onboot projectName
```

## Services

Containers defined under **services** run after containers listed in **onboot**. They are automatically restarted by Docker if it exits with a non-zero return code.

To add a service follow the format below.

```
gadget add service projectName
```


## Configurations

When you add a service from the command-line, a template configuration is inserted into your gadget.yml file. You'll need to fill in some details depending on how your project needs to be built and what your container needs at runtime.

<span style="font-size: 17px">**Name: Name of project**</span>

The text above gets generated and instered into your gadget.yml file when you add to onboot or service via the command:

```     
gadget add service|onboot projectName
``` 

If you choose to edit this field after generation, the container will need to be built and deployed again.

__Format:__ `name: projectName`

<span style="font-size: 17px">**Uuid: Container ID**</span>

You can have several instances of the same image. These instances are identified by their UUID. For example, if you build an image then change the **command** configuration and build again you can see both instances on your development machine when you run:

```
docker images
```
__Format:__ `cont-ainer-uu-i-d`

<span style="font-size: 17px">**Image: Path of Docker Hub image**</span>

An entry for `image:` is generated when you add to onboot or services via the command:

```
gadget add service|onboot projectName
```

To pull a base image from Docker Hub change `image:` to the username and repository you would like to pull. By default, the ["latest" tag](https://docs.docker.com/get-started/part2/#tag-the-image) of the image is used. Learn more about [Docker Hub](https://docs.docker.com/docker-hub/) and how to use it.

__Format:__

Generated: `image: parent_directory/projectname`

Docker Image: `image: username/repoName:tag`

<span style="font-size: 17px">**Directory: Path to directory with Dockerfile**</span>

Images can be built locally, rather than pulling from an online registry. This is done by removing the value entered in `image:` and entering a path in the `directory:` entry. See the file structure below:

```
my_project/
├── container_a
│   ├── asset_01
│   ├── asset_02
│   └── Dockerfile
└── gadget.yml
```
In this particular case, the appropriate `directory:` value would be `"container_a"` or `"./container_a"`. The path must be relational. The Dockerfile can also exist in the same directory as the gadget.yml file as illustrated below:

```
my_project/
├── asset_01
├── Dockerfile
└── gadget.yml
```
Here, the `directory:` value would be `"."` or `"./"` (the Unix value for "here").

__Format:__ `directory: projDir/`

<span style="font-size: 17px">**[Net:](https://docs.docker.com/engine/reference/run/#network-settings) Define which network to use or none**</span>

By default, all containers have networking enabled and can make outgoing connections. Use the following arguments to choose which network you would like the container to use:

| Network                | Description                                                                             |
|------------------------|-----------------------------------------------------------------------------------------|
| none                   | No networking in the container.                                                         |
| bridge                 | Connect the container to the bridge via veth interfaces.                                |
| host                   | Use the host's network stack inside the container.                                      |
| container: [name-UUID] | Use the network stack or another container, specified via its __name__ or __id__        |
| NETWORK                | Connects the container to a use created network (using `docker network create` command) |

Format: `net: host`


<span style="font-size: 17px">**[Readonly](https://docs.docker.com/engine/reference/commandline/run/#usage) - Mount the container’s root filesystem as read only**</span>

Set to false by default.

<span style="font-size: 17px">**[Command](https://docs.docker.com/engine/reference/builder/#cmd) - Run this command at start**</span>
	
Set a command to be executed automatically upon the start of a container. This also overwrites any `CMD` specified in a project's Dockerfile.

__Format:__ `command: ['python', 'myPyScript.py']`
	
<span style="font-size: 17px">**[Binds](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v-read-only) - Mount a directory**</span> 
	
Put any directories here that you would like to mount from the device into the container. 

__Format:__ `binds: ['/fromHostDir:/toContainerDir']`

<span style="font-size: 17px">**[Capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Enable [Linux capabilities](http://man7.org/linux/man-pages/man7/capabilities.7.html)**</span>
	
This is where specific Linux capabilities that bypass kernel permission checks get enabled. Some are enabled by default; all others are defined here depending on what is needed for the container at runtime.

__Format:__ `capabilities: [SYS_RAWIO]`

<span style="font-size: 17px">**[Devices](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) - Grant access to devices**</span>
	
Define a raw device in Linux to pass to a container. These are different from binds because Linux devices have several different modes of access.

__Format:__ `devices: [/dev/mem]`

**General Rules**

* When listing items in an array, surround each item with single quotes. For example:
	`binds: ['/sys:/sys']`
	`command: ['python', 'myScript.py']`
	
* By default, Docker containers are not allowed to access any devices and are "unprivileged." To access a device and get privileges to Linux capabilities they need to defined in `capabilities` and `devices`. GadgetOS does not promote nor enable operators to pass the `--privileged` flag to Docker's run command.




