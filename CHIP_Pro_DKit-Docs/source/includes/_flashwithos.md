# Flash With An OS

Before you start building with the C.H.I.P. Pro Dev Kit the C.H.I.P. Pro needs to be flashed with an operating system. We at NTC have built examples that use two operating systems: Buildroot and Debian that are both based on Linux. 

**Debian** is a classic amongst embedded Linux board users for rapid prototyping. It offers a full package manager and loads of precompiled software for many different architectures. 

**Buildroot** is simple and stripped down making it efficient and good for single application use cases. 

C.H.I.P. Pro has 512MB of high-reliability SLC NAND storage onboard for holding the core operating system and a limited amount of user and program data. While the storage is faster and more reliable it has less capacity. Because of this, it's a good idea to know how much storage software will take before flashing and installing. Where needed, additional high-speed storage can be added through C.H.I.P. Pro’s SDIO bus.

Ready to try out some examples? Grab these items, then read on!

 * C.H.I.P. Pro Dev Kit
 * USB A to Micro-USB B cable
 * Separate computer with [Chrome](https://www.google.com/chrome/browser/desktop/index.html) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) browser 


## Flashing Process
Head over to the web flasher at [flash.getchip.com/pro](http://flash.getchip.com/pro). If it's your first time flashing, when you arrive you will be asked to install the NTC Flasher Chrome Extension.

After installing the extension the main page will give you the option to either download an image or follow the wizard to flash C.H.I.P. Pro. For a smooth automated process, click **FLASH** to flash C.H.I.P. Pro.

![flasher home page](images/main.png)

You will be sent to the **"Flasher First Time Setup"** page which will have instructions dependent on the operating system of your computer. Follow along in the browser or below.

* Linux-specific

	* A Debian-based Linux computer requires creating a set of udev rules to communicate with your C.H.I.P. Pro. Paste the following into a terminal window. 
	
	```shell
	sudo usermod -a -G dialout ${USER}
	sudo usermod -a -G plugdev ${USER}

	# Create udev rules
	echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1f3a", ATTRS{idProduct}=="efe8", 		GROUP="plugdev", MODE="0660" SYMLINK+="usb-chip"
	SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="1010", GROUP="plugdev", 	MODE="0660" SYMLINK+="usb-chip-fastboot"
	SUBSYSTEM=="usb", ATTRS{idVendor}=="1f3a", ATTRS{idProduct}=="1010", GROUP="plugdev", 	MODE="0660" SYMLINK+="usb-chip-fastboot"
	SUBSYSTEM=="usb", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="2303", GROUP="plugdev", 	MODE="0660" SYMLINK+="usb-serial-adapter"
	' | sudo tee /etc/udev/rules.d/99-allwinner.rules

	sudo udevadm control --reload-rules
	```
	
	Then logout and log back in.

	For the curious:

   	- ${USER}: outputs your username
   	
    - dialout: gives non-root access to serial connections
    
    - plugdev: allows non-root mounting with pmount

	The udev rules then map the usb device to the groups. For more information, check [the systems group page on 	debian.org](https://wiki.debian.org/SystemGroups).

* Windows-specific
   
	* To communicate to C.H.I.P. Pro from a Windows computer you must install [drivers](https://s3-us-west-2.amazonaws.com/getchip.com/extension/drivers/windows/InstallDriver2.exe).
   	* Reboot after installing drivers on previous versions (<10) of Windows. 
	* During the fastboot process **Windows may issue the warning "device not recognized"**. Getting this warning during fastboot is **normal** and **flashing should proceed**.
	
* MacOS specific
   	
   	* Using USB3 ports can cause the flashing to fail. If you can, try using a USB2 port, not a USB3. If you find yourself with a modern Mac that only has USB3 ports, try using a USB2 hub in your USB3 port and plug C.H.I.P. Pro into that.
	* OS X El Capitan has been known to have issue with the flashing process. If a new cable or USB2 hub does not work and you are able to, upgrade to macOS Sierra.


When done with setup, press **START!**.

![first time setup](images/firstsetup.png)

Once the extension is installed, plug the micro USB cable into the USB0 port on the Dev Kit (**not on the C.H.I.P. Pro!**). 

Hold down the FEL button (a pencil eraser works nicely) and with the other hand plug the USB cable into the computer. When the pink power and white status LEDs on C.H.I.P. Pro light up, you can release the FEL button.

![pushing FELL button](images/pressPlug.jpg)

The web flasher will search for and recognize C.H.I.P. Pro.

![searching page](images/searchFlash.png) 

You will then be directed to the page with the example images. Hover over each image to see a description and click to see more details such as file size and kernel version. When you have chosen your adventure, click **FLASH TO C.H.I.P. PRO**.

[![image page](images/imagesPage.png)] (images/imagesPage.jpg) | [![flash to board](images/imageDetail.png)] (images/imageDetail.png) | 
|:---:|:---:|
| Choose image | Click FLASH TO CHIP PRO |

Watch the flashing process progress and leave the browser tab open in order for it to complete. You will be notified when C.H.I.P. Pro has been flashed successfully. You are then free to unplug the C.H.I.P. Pro or connect to it via [serial](https://docs.getchip.com/chip_pro.html#usb-serial-uart1-connection). 

![succeeded page](images/flashFinish.png)

If you are having problems with the flashing process follow the troubleshooting instructions given by the web flasher or check out the [Web Flasher OS-Specific Issues](https://docs.getchip.com/chip.html#web-flasher-os-specific-issues) troubleshooting section. 


## Examples

You can select an OS by flashing one of our examples using the web flasher [flash.getchip.com/pro](http://flash.getchip.com/pro) in Chrome or Chromium browser. Before you go to the web flasher however, there is a method to flashing the C.H.I.P. Pro to know and get in the habit of. This process is explained below and is also illustrated on the flasher page.

#### Blinkenlights

Controlling LEDs are fundamental to almost any hardware. This simple example provides easy-to-understand code with exciting results! Flash C.H.I.P. Pro with this image and watch the GPIO D0-D7 lights turn on and off in a cascading pattern and the two PWM LEDs pulse from dim to bright. Based on Buildroot.

#### VU Meter

This example comes with the [CHIP_IO](https://github.com/xtacocorex/CHIP_IO) library and Python, all in a very small package! 

Want to make sure your mics are working? Use this handy VU Meter example. Scream loudly, speak softly, tap the mics, and MAKE SOME NOISE, SPORTSFANS! You'll see the LEDs light proportional to the volume of the noise captured by the two built-in mics. Based on Buildroot.

#### Pro

We provide a standard Debian distribution. Once flashed connect to the C.H.I.P. Pro via [USB-serial](https://docs.getchip.com/chip_pro_devkit.html#usb-serial-uart1-connection) and log in with the default username `chip` and password `chip`.

If you want to configure and build the rootfs for the Debian image, take a look at our [github repo](https://github.com/NextThingCo/chip-os-pro)

### After Flashing Image

![power off button](images/poweroffB.gif)

When you are done or want to flash another example, hold down the power button on the Dev Kit until the Power and Activity LEDs shut off.

### Troubleshooting Flashing Fails

If the flashing process fails we have [troubleshooting recommendations](https://docs.getchip.com/chip.html#web-flasher-os-specific-issues) based on your OS. 