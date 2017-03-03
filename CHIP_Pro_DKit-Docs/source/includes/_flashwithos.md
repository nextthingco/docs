# Flash With An OS
Before you start building with the C.H.I.P. Pro Dev Kit the C.H.I.P. Pro needs to be flashed with an operating system. Grab these items, then read on:

 * C.H.I.P. Pro Dev Kit
 * USB A to Micro-USB B cable
 * Separate computer with [Chrome](https://www.google.com/chrome/browser/desktop/index.html) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) browser 

## Flash an Example
You can select an OS and example from [flash.getchip.com](http://flash.getchip.com/pro) in Chrome or Chromium browser.

Plug the micro USB cable into the USB0 port on the Dev Kit (**not in the C.H.I.P. Pro!**). Hold down the FEL button and with the other hand plug the USB cable into the computer. The C.H.I.P. Pro will power up which will be indicated by the pink power and white status LEDs illuminating. 

![pushing FELL button](images/pressPlug.jpg)

The web flasher will search for and eventually recognize your board. Keep holding the FEL button down until the magnifying glass goes away and you have an option to choose an image to flash.

Choose one of our three delightful examples:

* Blinkenlights
* VU Meter
* Debian OS

Except for the Debian example, when you connect to C.H.I.P. Pro [via serial](http://docs.getchip.com/chip_pro_devkit.html#usb-serial-uart1-connection), you will be logged in as root.

If you want to learn more about C.H.I.P. Pro software, such as connecting to WiFi and accessing GPIO, head over to the official [C.H.I.P. Pro Docs page](http://docs.getchip.com/chip_pro.html#get-working-with-c-h-i-p-pro).

### Blinkenlights

Controlling LEDs is fundamental to almost any hardware. This simple example provides easy-to-understand code with exciting results! Flash C.H.I.P. Pro with this image and watch the GPIO D0-D7 lights turn on and off in a cascading pattern and the two PWM LEDs pulse from dim to bright.   

There are two scripts running in the background. If you want to modify the code for this example, connect via [USB-serial](http://docs.getchip.com/chip_pro_devkit.html#connect-and-control) and then you can use the `vi` editor to play around with the code: 

```
vi /usr/bin/blink-leds
vi /usr/bin/fade-pwms
```

This image is a very rudimentary Linux distribution, based on buildroot. It demonstrates a fast-booting system that boots into a software system that immediately controls hardware.

### VU Meter

Want to make sure your Mics are working? Use this handy VU Meter example. Scream loudly, speak softly, tap the mics, and MAKE SOME NOISE, SPORTSFANS! You'll see the LEDs light proportional to the volume of the noise captured by the two built-in mics.

If you want to modify the code for this example, connect via [USB-serial](http://docs.getchip.com/chip_pro_devkit.html#connect-and-control) and then you can use `vi` to edit it: 

```
vi /usr/bin/vu-meter
```

This image is a very rudimentary Linux distribution, based on buildroot. It demonstrates a fast-booting system that boots into a software system that reacts to the environment and controls hardware.

### Debian

We provide a standard Debian distribution, complete with all the package managers and conveniences you know and love. This package is ideal for development, since it is more flexible than the buildroot-based Gadget OS. However, you will want to keep track of your dependencies to more easily transition to the more nimble Gadget OS.

When you connect to C.H.I.P. Pro, you can log in with username `chip` and password `chip`.

If you want to configure and build the kernel and rootfs for the Debian image, take a look at our [github repo](https://github.com/NextThingCo/chip-os-pro)
