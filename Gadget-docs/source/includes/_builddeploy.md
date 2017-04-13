# Use Gadget

Follow along to learn how to build and deploy Gadget's 'hello world' Bash script. Make sure you have gone through the setup steps of installing Docker, GadgetCLI and flashing your hardware device.

## Connect 

![Connect to USB0](images/usb0.jpg)

Connect C.H.I.P. Pro Dev Kit to your host computer via USB. Make sure to plug into USB0 on the Dev board, not C.H.I.P. Pro itself. 

## Hello World

Open the GadgetCLI application. A terminal window will open on your desktop displaying Gadget's welcome screen. If you haven't installed Docker, Gadget will detect the OS of your host computer and direct you to the proper url for installing. After Docker has been installed, Gadget's welcome screen will look something like this (screenshot on a Mac): 

![Welcome screen Mac](images/welcome.png)

From here, simply type the commands listed to deploy your first application. 

```shell
gadget init hello_world	# initialize the Gadget Template and create a directory called hello_world
cd hello_world	# enter the hello_world directory
gadget build	# build hello_world project 
gadget deploy	# deploy hello_world project
```

The project is pushed to the C.H.I.P. Pro Dev Kit and the LEDs connected to PE4 - PE11 will turn on and off in sequential order. A successful deployment looks like this:

![build and deploy](images/build.png)

Congrats, you have built and deployed your first Gadget project!

## Edit Example Script
When a project, like **hello_world**, is initialized, Gadget creates a directory on the host computer for it. You can find that directory in these locations:

* **Mac OSX** - /Macintosh HD/Users/username/hello_world

* **Linux** - /home/username/hello_world

* **Windows** - C:/Users/username/hello_world

In the **hello_world** project directory there are two files:

* Gadget config - 
* blink-leds.sh - example 'hello world' script.


![ls files in project dir](images/twofiles.gif)

To edit the 'hello world' script , use the Nano command-line editor: 

```shell
nano blink-leds
```
Change the `SPEED` variable, for example, to `1`. Press Ctrl+O to save and Ctrl+X to exit Nano.

![changing SPEED var](images/speedCrop.gif)

While still in the project directory, build and deploy:

```shell
gadget build 
gadget deploy
```

The LEDs will turn on and off at the speed you specified. 

## Exit GadgetCLI

GadgetCLI simply opens a window using your host computer's terminal application. To exit, first stop the running application then exit. 

```shell
stop
exit 
```

## Gadget Help


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

optional arguments:
  -h, --help  show this help message and exit

get help for specific command:
  gadget <command> --help
```

 




	