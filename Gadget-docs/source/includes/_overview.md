# Welcome!

&#128226; We at Next Thing Co. would like to introduce the developer preview of Gadget, our open source suite of software tools. Gadget is built for developing, deploying, and distributing custom Linux operating systems for projects and products. Since it's open source we want to hear from all you Docker enthusiasts and CHIP Pro Dev Kit owners about how you are using it. To leave feedback, Gadget can be found on NTC's [github account]. 

# What is Gadget?

We made Gadget to make it much quicker to create and collaborate on new kickass hardware projects and products. With Gadget and Gadget certified hardware, you will boot faster, cross compile easier and iterate immediately.

**Develop** - Create your code in a container with the command-line interface.
**Cross Compile** - Build your work on your computer rather than the device.
**Deploy** - Push the build to your hardware device.
**Iterate** - Make changes using the command-line interface. When you deploy changes, it only pushes the lines of code that have changed which makes it super speedy.
**Replicate** - Because your container is developed and built on a host computer deploying to a new device is a piece of cake.
**Collaborate** - Share your containers and collaborate remotely. Containers have all the code needed to ensure whoever you share with can build and use your project.

Gadget is comprised of three main pieces of software: **GadgetCLI**, **GadgetOS** and **Gadgetdev**. 

## GadgetCLI

GadgetCLI is a simplified command-line tool for developing a custom Linux distribution. It's what you use to build and deploy applications using the power of Docker and containers. For more information on Docker, read here.
     
## GadgetOS

GadgetOS is Next Thing Co.’s custom version of Buildroot, optimized for boot speed. For more information on Buildroot, read [here](https://buildroot.org/). 

* Gadget OS comes with GadgetOSd, a daemon that allows automatic communication with GadgetCLI over a USB connection.

## GadgetDev

Use GadgetDev to debug and quickly test code directly on Gadget certified hardware.


	




