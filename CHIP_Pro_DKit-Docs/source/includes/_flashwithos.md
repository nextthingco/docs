# Flash With An OS
Before you start building with the C.H.I.P. Pro Dev Kit the C.H.I.P. Pro needs to be flashed with an operating system. We at NTC have built examples that use two operating systems: Buildroot and Debian that are both based on Linux. It's worth mentioning here that a difference between C.H.I.P. and C.H.I.P. Pro is the former has 1GB of NAND and the latter has 512MB. This means that it's a good idea to know how much storage software will take before flashing and installing. 

**Debian** is a classic amongst embedded Linux board users for rapid prototyping. It offers a full package manager and loads of precompiled software for many different architectures. 

**Buildroot** is simple and stripped down making it efficient and good for single application use cases. 

Ready to try out some examples? Grab these items, then read on!

 * C.H.I.P. Pro Dev Kit
 * USB A to Micro-USB B cable
 * Separate computer with [Chrome](https://www.google.com/chrome/browser/desktop/index.html) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) browser 

## Examples
You can select an OS by flashing one of our examples using the web flasher [flash.getchip.com/pro](http://flash.getchip.com/pro) in Chrome or Chromium browser. Before you go to the web flasher however, there is a method to flashing the C.H.I.P. Pro to know and get in the habit of. This process is explained below and is also illustrated on the flasher page.

### Flashing Process
Once you arrive at [flash.getchip.com](http://flash.getchip.com/pro) you will be prompted to install a Chrome extension. 

Once the extension is installed, plug the micro USB cable into the USB0 port on the Dev Kit (**not on the C.H.I.P. Pro!**). Hold down the FEL button and with the other hand plug the USB cable into the computer. The C.H.I.P. Pro will power up which will be indicated by the pink power and white status LEDs illuminating. 

![pushing FELL button](images/pressPlug.jpg)

The web flasher will then search for and eventually recognize the C.H.I.P. Pro Dev Kit. 

![searching for board](images/searchPageCrop.png)

Keep holding the FEL button down until the magnifying glass goes away and the page with example images appear. Let go of the FEL button and choose an example image to flash.

![image page](images/imagePage.png)

#### Blinkenlights

Size: ~60MB

Controlling LEDs are fundamental to almost any hardware. This simple example provides easy-to-understand code with exciting results! Flash C.H.I.P. Pro with this image and watch the GPIO D0-D7 lights turn on and off in a cascading pattern and the two PWM LEDs pulse from dim to bright. Based on Buildroot.

#### VU Meter

Size: ~60MB

Want to make sure your mics are working? Use this handy VU Meter example. Scream loudly, speak softly, tap the mics, and MAKE SOME NOISE, SPORTSFANS! You'll see the LEDs light proportional to the volume of the noise captured by the two built-in mics. Based on Buildroot.

#### Debian

Size: ~180MB

We provide a standard Debian distribution. Once flashed connect to the C.H.I.P. Pro via [USB-serial](https://docs.getchip.com/chip_pro.html#usb-serial-uart1-connection) and log in with the default username `chip` and password `chip`.

If you want to configure and build the rootfs for the Debian image, take a look at our [github repo](https://github.com/NextThingCo/chip-os-pro)

### After Flashing Image

![power off button](images/poweroffB.gif)

When you are done or want to flash another example, hold down the power button on the Dev Kit until the Power and Activity LEDs shut off.

### Troubleshooting Flashing Fails

If the flashing process fails we have [troubleshooting recommendations](https://docs.getchip.com/chip.html#web-flasher-os-specific-issues) based on your OS. 