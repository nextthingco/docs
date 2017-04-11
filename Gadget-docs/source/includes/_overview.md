# Welcome!

Gadget is a suite of software tools for developing, deploying, and distributing custom Linux operating systems for projects and products.

Gadget combines a ready to use fast-booting Buildroot image, container support and a cross-platform command-line tool with reliable drivers for Gadget compatible hardware. Gadget removes the need for repetitive setup and low level optimization so you can focus on your high level code. 

We made Gadget to make it much quicker to create and collaborate on new kickass hardware projects and products. With Gadget and Gadget certified hardware, you will boot faster, cross compile easier, iterate immediately, replicate quickly, and collaborate seamlessly. It’s also open source so you can customize it to better suit your project’s needs.

## The Parts of Gadget 

Gadget is comprised of two main pieces of software:

### GadgetCLI

GadgetCLI is a simplified command-line tool for developing a custom Linux distribution. It's what you used to build and deploy applications. GadgetCLI comes with a Gadget Template containing a Gadgetfile and an example Bash script that turn on a off LEDs connected to PE4 - PE11.

     ** GadgetFile **
     This is container build instructions for your code. Whatever instructions live here, 			                       will be built and deployed. This file builds your Gadget image which is where your application lives. When you run the Gadget image it runs as a container.
     
     ** Containers**
     All containers use Alpine Linux. You can run as many containers as the processor can handle to get the features your project needs. 

### GadgetOS

GadgetOS is Next Thing Co.’s custom version of Buildroot, optimized for boot speed. For more information on Buildroot, read [here](https://buildroot.org/). Once uploaded to C.H.I.P. Pro, a GadgetOS daemon bundled with GadgetOS allows automatic communication with GadgetCLI when connected over USB. 

