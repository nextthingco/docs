# Build and Deploy Your First Application

We've made building and deploying Linux applications fast and simple. Follow along to learn how to build and deploy Gadget's 'Hello World' Bash script. First, make sure you have gone through the setup steps of installing Docker, GadgetCLI and Flashing C.H.I.P. Pro.

## Connect 

Connect C.H.I.P. Pro or C.H.I.P. Pro Dev Kit to your host computer via USB. If using C.H.I.P. Pro Dev Kit make sure to plug into USB0 on the Dev board, not C.H.I.P. Pro. 

## Say "Hello World" with Gadget

Open the GadgetCLI application. A terminal window will open on your desktop displaying Gadget's welcome screen with `GADGET: ~$` as the prompt. If you haven't installed Docker Gadget will detect the OS of the host computer and direct you to the url where you can download and install Docker. After you have installed Docker Gadget's welcome screen will look like this: 

![Welcome screen Mac](images/welcomeFlash.png)

From here, simply type the commands listed to deploy your first application.

1) Initialize the Gadget Template and create a directory called hello_world:

`gadget init hello_world`

![init Mac](images/initMac.png)

2) Enter the hello_world directory:

`cd hello_world`

3) Build 

**Mac**

`gadget build`

**Linux**

`sudo gadget build`

4) Deploy

**Mac**

`gadget deploy`

**Linux**

`sudo gadget deploy`

Gadget will tell you when it's done deploying. The hello world template comes with a Bash script called "blink-leds" which will turn the LEDs connected to PE4 - PE11 on and off in sequential order. 

## Gadget Commands

To see what commands and options are available when using Gadget type:

`gadget` or `gadget --help`

These will display the help menu:

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

While in the project's directory these commands can be used to start and stop the application plus more.

## Gadget Project Template
When initialized, Gadget creates the project directory at:

**Mac OSX**

/Macintosh HD/Users/"username"/

**Linux**

/home/"username"/

Here you will find the project's directory with two files in it:

* **GadgetFile** - This file contains build instructions for your application. 
* **blink-leds** - A sample bash script to make the LEDs on the C.H.I.P. Pro Dev Kit blink. Our ‘hello world’.

### Edit Example Script

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

GadgetCLI simply opens a window using your host computer's terminal application. To exit first stop the running application:
`stop`

Then, type `exit` and close window.
 




	