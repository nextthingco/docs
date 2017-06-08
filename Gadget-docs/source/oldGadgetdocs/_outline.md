# Introduction
Gadget is a suite of software tools for developing, deploying, and distributing custom Linux operating systems for projects and products.

Gadget combines a ready to use fast-booting Buildroot image, container support and a cross-platform command line tool with reliable drivers for Gadget compatible hardware. Gadget removes the need for setup and low level optimization so you can focus on your high level code.

We made Gadget to make it much easier to create new and kickass hardware projects and products. With Gadget and Gadget certified hardware, you will boot faster, cross compile easier, iterate immediately, replicate quickly, and collaborate seamlessly. It’s also open source so you can customize it to better suit your project’s needs.

# Audience
Docker enthusiasts
CHIP Pro Dev Kit owners

IMPORTANT - This is not for…
general public
chip users
pocketchip users
folks who stumble onto our website

# What is Gadget?
 
	GadgetCLI
GadgetOS
		Buildroot
		Docker
		GadgetOSd
		
Gadget CLI
a cross platform simplified command line tool for developing a custom Linux distribution. GadgetCLI comes with a Gadget Template containing...

GadgetFile
This is container build instructions for your code. Whatever instructions live here, will be built and deployed.

Blinkenlights.sh 
A sample bash script to make the LEDs on the C.H.I.P. Pro Dev Kit blink. Our ‘hello world’.

GadgetOS
a fastbooting buildroot image with built-in container support designed to be flashed to Gadget certified hardware.

Buildroot
GadgetOS is Next Thing Co.’s custom buildroot, optimized for boot speed. For more information on buildroot, read here.

GadgetOSd
a GadgetOS daemon allows automatic communication with the GadgetCLI when connected over USB.

Docker
This version of Gadget makes use of the Docker container system. For more information on Docker, read here.

ASSUMED KNOWLEDGE

# Set Up
	Install Docker
	Set up Docker
	Install CLI
	Flash CHIP Pro 

# Build and Deploy Your First Application

Plug in CHIP Pro
Open Gadget

```
gadget init hello_world
cd hello_world
gadget build
gadget deploy
```

Where Gadget looks for the container and Dockerfile on Macs, Windows, Linux
	use tree command? (doesn’t come with Mac)
	Mac 
	/Users/userName/containerName
	/Users/userName/containerName/Gadgetfile
	

# Gadget Certified Hardware

Gadget has been designed in conjunction with C.H.I.P. Pro to take advantage of C.H.I.P. Pro’s feature set. Learn more about C.H.I.P. Pro here [link to chip pro page].
Hardware pics

# Going Further 
	

# OTHER CONTAINERS?

# MOVING FORWARD

# ADDITIONAL RESOURCES
	Docker!
	Buildroot!
	NTC Gadget Forum?!

# TROUBLESHOOTING
	Is the right image flashed?
	Permissions






