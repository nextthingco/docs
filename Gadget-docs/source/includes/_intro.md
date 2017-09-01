# Welcome to Gadget!

Gadget is a suite of tools for developing, deploying, and distributing your applications to C.H.I.P. Pro and Gadget supported devices. 

This documentation starts by guiding you through the installation of Gadget then a quickstart "hello world" example to make sure everything is set up correctly. It then moves into more detailed instructions on how to build, share and deploy custom and community built applications. After going through the quickstart and how to build with Gadget sections, this documentation also offers helpful references and several example projects to start building with.  

# What is Gadget? 

Gadget is made up of two pieces of software that work together to simplify embedded software development.

1) <span style="color: EB008B">**GadgetCLI**</span> is a command-line tool you use on your development machine. It lets you manage your code, add and build containers, and deploy your finished projects to Gadget supported hardware. 

**Supported Systems:**

* Linux 64-bit (kernel 3.10+)
* OSX 
* Windows 10 Pro 64-bit

2) <span style="color: EB008B">**GadgetOS**</span> is a [Buildroot](https://buildroot.org/)-based Linux operating system. It boots quickly, takes up a small amount of NAND, and is designed to work with GadgetCLI. 

Buildroot is at the core of GadgetOS and features Docker support. The **GadgetCLI** communicates directly with the Docker daemon over ssh, using GadgetOS’s USB ethernet connection. 

#### C.H.I.P. Pro

* **Boot time** is ~5 seconds to shell on the UART. Depending on user optimization, containers can load in ~5 - 15 seconds.
* **NAND availability** for containers, files, assets, etc. is 350MB. 






	




