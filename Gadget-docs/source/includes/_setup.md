# Set Up Gadget

To get started, download and install the following on your host computer and Gadget compatible hardware.

## Install Docker

**Note:** If Docker is already installed on your host computer make sure it's up to date.

Gadget makes use of Docker's container system. Dependent on your host computer's OS, download and install the appropriate version of Docker using the below links. For more information on Docker, read [here](https://www.docker.com/).

* MacOS - [Docker CE](https://store.docker.com/search?type=edition&offering=community)
* Windows 10 - [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
* Linux - [Docker CE](https://store.docker.com/search?type=edition&offering=community)

GadgetCLI uses the Docker daemon to pull images from Docker Hub, or build directly from local Dockerfiles. Once Docker is installed, run it before using GadgetCLI.

## Download Gadget

Download GadgetCLI and GadgetOS [here](https://github.com/NextThingCo/gadgetcli/releases). Put the gadget binary in your path or precede all the commands with `./` eg. `./gadget`.

## Flash GadgetOS 

For GadgetCLI to be able to talk to your hardware device it needs to be flashed with the latest GadgetOS image. Flash C.H.I.P. Pro Dev Kit with the latest .chp file bundled with GadgetCLI. 

Once flashed, power cycle C.H.I.P. Pro Dev Kit by either unplugging it from the USB port or pressing the on/off button.
