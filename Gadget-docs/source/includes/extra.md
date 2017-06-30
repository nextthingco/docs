1. **Pull Remote Images**

	In this scenario, images are pulled from a remote location and deployed to hardware. See the Pull Images LINK section to learn about this process.

2. **Build Images Locally** 

	Build images locally on your development computer. This takes some Docker knowledge but gives you the most flexibility. See the Build Images Locally section LINK to learn more. Development is done on a host computer. Once your code is ready for testing it's compiled and pushed to your hardware device connected via USB using GadgetOS' daemon GadgetOSD. 

To get familiar with each process follow the two Blink tutorials. Both use Python and the CHIP_IO python library with a simple script that blinks an LED on pin 36, CSID0.  

## Requirements

Before moving forward, make sure you have gone through the Quickstart LINK section to meet the below requirements.

### Hardware

* Host computer (Mac, Windows 10 or Linux)
* Gadget compatible hardware
	* All examples pictured here are with the Dev Kit
* USB cable
	* Micro USB to USB cable (Dev Kit) 
	or
	* UART serial cable (bare C.H.I.P. Pro)

### Software

**Host Computer**

* GadgetCLI 
* Docker  

**Gadget Compatible Hardware**

* GadgetOS 


---- from pull image example

### 2. Connect Hardware 

Connect your board to your host computer via a USB cable. The board must be flashed with GadgetOS. If flashing the board for the first time unplug and plug the board back in after flashing to power cycle.
	
{Pic of Dev Kit connected to host computer}

The **gadget.yml** file is where all the configurations needed for a container at runtime go. It is also where you state which containers to run and in what order. To learn more go to the [Configuring Gadget.yml](http://ntc-docs-unstable.surge.sh/gadget.html#configuring-gadget-yml) section.