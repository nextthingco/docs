# Use Gadget

Follow along to learn how to build and deploy Gadget's 'Hello World' Bash script. First, make sure you have gone through the setup steps of installing Docker, GadgetCLI and Flashing your hardware device.

## Connect 

Connect C.H.I.P. Pro Dev Kit to your host computer via USB. Make sure to plug into USB0 on the Dev board, not C.H.I.P. Pro itself. 

## Hello World

Open the GadgetCLI application. A terminal window will open on your desktop displaying Gadget's welcome screen with `GADGET: ~$` as the prompt. If you haven't installed Docker, Gadget will detect the OS of the host computer and direct you to the proper url for installing. After you have installed Docker, Gadget's welcome screen will look someting like this (screenshot on a Mac): 

<figure>
![Welcome screen Mac](images/welcomeFlash.png)
<figcaption>Caption goes here</figcaption>

From here, simply type the commands listed to deploy your first application. 

```shell
gadget init hello_world	# initialize the Gadget Template and create a directory called hello_world
cd hello_world	# enter the hello_world directory
gadget build	# build hello_world project 
gadget deploy	# deploy hello_world project
```
**{PHOTO}**

The project will be pushed to the C.H.I.P. Pro Dev Kit and the LEDs connected to PE4 - PE11 will turn on and off in sequential order. Congrats you have built and deployed your first Gadget project!

## Edit Example Script
When initialized, Gadget creates the project directory at:

* **Mac OSX** - /Macintosh HD/Users/username/hello_world

* **Linux** - /home/username/hello_world

* **Windows** - C:/Users/username/hello_world

In that directory are two files:

* Gadget config - 
* blink-leds.sh - example 'Hello World' script.

To edit the example script use the Nano command-line editor: 

```shell
nano blink-leds
```

Change the `SPEED` variable, for example, to `1`. Press Ctrl+O to save and Ctrl+X to exit Nano.

{clip of me changing speed variable}

Save the file, build and deploy:

```shell
gadget build 
gadget deploy
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
 




	