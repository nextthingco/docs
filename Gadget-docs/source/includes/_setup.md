# Set Up Gadget

To get started, download and install the following on your host computer and Gadget compatible hardware.

## Install Docker

**Note:** Gadget requires Docker version 17.06 or greater. If Docker is already installed check which version of Docker you have with the command `Docker -v`.

Gadget makes use of [Docker's]((https://www.docker.com/)) container system. Dependent on your host computer's OS, download and install the appropriate version of Docker. 

* MacOS - [Docker CE](https://store.docker.com/search?type=edition&offering=community)
* Windows 10 - [Docker CE](https://store.docker.com/search?type=edition&offering=community)
* Linux - [Docker CE](https://store.docker.com/search?type=edition&offering=community)

Once Docker is installed, run it before using GadgetCLI. GadgetCLI uses the Docker daemon to pull images from Docker Hub or to build directly from local Dockerfiles. 

## Download Gadget

Download the zip file containing GadgetCLI and GadgetOS [here](https://github.com/NextThingCo/gadgetcli/releases). Put the gadget binary in your system's PATH or precede all the commands with `./` eg. `./gadget` while in the same directory.

**PATH location:**

**MacOS Sierra**: /usr/local/bin

**Windows 10**

Put the gadget binary somewhere like C:\Program Files (x86)\gadget and edit the "Path" variable to point to that location.

Click the Windows icon to open the Start Menu. Search for "advanced system settings". When the System Properties window opens click on "Environment Variables". 
 
Find and select the "Path" variable under "System Variables". Click "Edit" and the "Edit environment variable" window will open. This is where you can add the path of where the gadget binary is located. Click "New" and fill in the location in the empty spot that is provided at the bottom of the list. Afterwards, click "OK" and you are done!

**Linux**

Place the gadget binary here: /usr/bin


## Flash GadgetOS 

For GadgetCLI to be able to talk to your hardware device it needs to be flashed with the latest GadgetOS image. Use the [web flasher](http://flash.getchip.com/pro) to flash C.H.I.P. Pro Dev Kit with the latest .chp file bundled with GadgetCLI. 

Once flashed, power cycle C.H.I.P. Pro Dev Kit by either unplugging it from the USB port or pressing the on/off button.
