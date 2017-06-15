# Welcome to Gadget!

<span style="font-size: 36px">&#128226;</span>Welcome to the **developer preview** of Gadget, a suite of tools for developing, deploying, and distributing your applications to C.H.I.P. Pro. 

<aside class="notice">
Gadget is open source and being actively developed, and we want to know what you think about it. The best way to leave us feedback is to use the **developer preview category** in the forum and to submit pull requests to the repos: GadgetOS repo & GadgetCLI repo. 
</aside>


	* we want your feedback!

# What is Gadget? 
Gadget is made up of two pieces of software that work together to simplify embedded software development:

1. **GadgetCLI** is a command-line tool you use on your development machine. It lets you manage your code, add and build containers, and deploy your finished projects to C.H.I.P. Pro. See the [GadgetCLI section](TKTK) for specifics.

2. **GadgetOS** is a buildroot-based Linux operating system that runs on C.H.I.P. Pro. It boots quickly, takes up a small amount of NAND, and is designed to work with GadgetCLI. See the [GadgetOS section](TKTK) for more details.


## GadgetCLI 

GadgetCLI is a command-line tool for developing your projects.
 
**Supported Systems:**

* Ubuntu Linux TKTK
* OSX TKTK
* Windows TKTK

     
## GadgetOS 

Buildroot is at the core of GadgetOS and features Docker support and GadgetOSD. **GadgetOSD** is a daemon that allows automatic communication with GadgetCLI over a USB connection. For more information on Buildroot, read [here](https://buildroot.org/).


**TODO**

* What's the boot time?
* How much NAND is taken up? 
* .conf file for kernel (from crunch)
* supports TKTK by default (high-level stuff like spi, i2c, webcam... what's supported?)

## Workflow [Diagram, Lara]

Use GadgetDev to debug and quickly test code directly on Gadget certified hardware.


	




