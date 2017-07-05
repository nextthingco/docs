# Welcome to Gadget!

<span style="font-size: 36px">&#128226;</span> Welcome to the **developer preview** of Gadget, a suite of tools for developing, deploying, and distributing your applications to C.H.I.P. Pro and Gadget supported hardware. 

<aside class="notice">
Gadget is open source and being actively developed so, we want to know what you think about it. </aside>

The best way to leave us feedback is to submit changes to the [GadgetCLI alpha release](https://github.com/NextThingCo/gadgetcli/releases) GitHub repo. 

# What is Gadget? 
Gadget is made up of two pieces of software that work together to simplify embedded software development.

1) <span style="color: EB008B">**GadgetCLI**</span> is a command-line tool you use on your development machine. It lets you manage your code, add and build containers, and deploy your finished projects to Gadget supported hardware. 

**Supported Systems:**

* Linux 64-bit (kernel 3.10+)
* OSX 
* Windows 10 Pro 64-bit

2) <span style="color: EB008B">**GadgetOS**</span> is a buildroot-based Linux operating system. It boots quickly, takes up a small amount of NAND, and is designed to work with GadgetCLI.

Buildroot is at the core of GadgetOS and features Docker support. The **GadgetCLI** communicates directly with the Docker daemon over ssh, using GadgetOS’s usb ethernet connection. For more information on Buildroot, read [here](https://buildroot.org/).

**Tech Notes and Specs**

* **Boot time** is ~5 seconds to shell on the UART. Depending on user optimization, containers can load in ~5 - 15 seconds.
* **NAND availability** for containers, files, assets, etc. is 350MB. 






	




