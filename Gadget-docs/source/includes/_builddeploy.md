# Hello World

We've made building and deploying Linux applications fast and simple. Follow along to learn how to build and deploy Gadget's 'Hello World' Bash script. First, make sure you have gone through the setup steps of installing Docker, GadgetCLI and Flashing C.H.I.P. Pro.

## Connect 

Connect C.H.I.P. Pro or C.H.I.P. Pro Dev Kit to your host computer via USB. If using C.H.I.P. Pro Dev Kit make sure to plug into USB0 on the Dev board, not C.H.I.P. Pro. 

## Use Gadget

Open the GadgetCLI application. A terminal window will open on your desktop displaying Gadget's welcome screen with `GADGET: ~$` as the prompt. If you haven't installed Docker Gadget will detect the OS of the host computer and direct you to the url where you can download and install Docker. After you have installed Docker Gadget's welcome screen will look like this: 

![Welcome screen Mac](images/welcomeFlash.png)

From here, simply type the commands listed to deploy your first application. 

**1)** Initialize the Gadget Template and create a directory called hello_world:

```shell
gadget init hello_world
```

**2)** Enter the hello_world directory:

```shell
cd hello_world
```

**3)** Build 

**Mac and Windows**

```shell
gadget build
```

**Linux**

`sudo gadget build` - sudo will not be necessary in future builds either by being able to launch Docker as a regular user or by configuration.

**4)** Deploy

**Mac and Windows**

```shell
gadget deploy
```

**Linux**

`sudo gadget deploy` - sudo will not be necessary in future builds either by being able to launch Docker as a regular user or by configuration.

When Gadget is done deploying, the LEDs connected to PE4 - PE11 will turn on and off in sequential order. Congrats you have built and deployed your first Gadget application!

## Edit Example Template
When initialized, Gadget creates the project directory at:

**Mac OSX**

/Macintosh HD/Users/username/hello_world

**Linux**

/home/username/hello_world

**Windows**

C:/Users/username/hello_world

Here you will find the applications's directory with two files in it:

**GadgetFile**

...This file contains build instructions for your application.
 
**blink-leds**

...A sample bash script to make the LEDs connected to PE4 - PE11 on the C.H.I.P. Pro Dev Kit blink. 

### Edit Script

Edit the example script using the Nano command-line editor. 

`nano blink-leds`

image

Change the `SPEED` variable, for example, to `1`. Press Ctrl+O to save and Ctrl+X to exit Nano.

Build and deploy:

**Mac**

```shell
gadget build 
gadget deploy
```

**Linux**

```shell
sudo gadget build 
sudo gadget deploy
```

When deployment is done, the LEDs will turn on and off at the speed your specified. 

## Exit GadgetCLI

GadgetCLI simply opens a window using your host computer's terminal application. To exit, first stop the running application then exit. 

```shell
stop
exit 
```

## Gadget Help

To see what commands and options are available while using Gadget type:

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

optional arguments:
  -h, --help  show this help message and exit

get help for specific command:
  gadget <command> --help
```

When in a project's directory these commands can be used to start and stop the application plus more.
 




	