# Connect and Control

## Flash an Operating System

Like its older sibling C.H.I.P., C.H.I.P. Pro's GR8 SiP can run mainline Linux. This provides security, flexibility, robust tools, and open-source options for getting your product working. In the interest of power consumption and storage space, we have two OS options to best fit your needs. 

**Debian** is a classic amongst embedded Linux board users for rapid prototyping. It offers a full package manager and loads of precompiled software for many different architectures. 

**Buildroot** is simple and stripped down making it efficient and good for single application use cases. 

Unlike its sibling, C.H.I.P. Pro has 512MB of storage which is about half of what C.H.I.P. offers. This means that it's a good idea to know how much storage software will take before flashing and installing.  

Grab these items to flash an example:

 * C.H.I.P. Pro 
 * USB A to Micro-USB B cable
 * Separate computer with [Chrome](https://www.google.com/chrome/browser/desktop/index.html) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) browser 

### Flashing Process
If it's your first time flashing, when you arrive at [flash.getchip.com/pro](http://flash.getchip.com/pro) you will be asked to install an Chrome extension.

Once the extension is installed, plug the micro USB cable into the micro USB port on C.H.I.P. Pro.   

Hold down the FEL button (a pencil eraser works nicely) and with the other hand plug the USB cable into the computer. The C.H.I.P. Pro will power up which will be indicated by the pink power and white status LEDs illuminating. 

![pushing FELL button](images/hold_plugPro800.gif)

The web flasher will then search for and eventually recognize the C.H.I.P. Pro. 

![searching for board](images/searchPageCrop.png)

Keep holding the FEL button down until the magnifying glass goes away and the page with example images appear. Let go of the FEL button and choose an example image to flash.

![image page](images/imagePage.png)


## Examples
Select an OS by flashing one of our examples using the web flasher [flash.getchip.com/pro](http://flash.getchip.com) in Chrome or Chromium browser. Before you go to the web flasher however, there is a method to flashing the C.H.I.P. Pro to know and get in the habit of. This process is explained below and is also illustrated on the flasher page.

We have built examples based on Buildroot specific to the hardware on the [Developer's Kit](https://docs.getchip.com/chip_pro_devkit.html). If you are building a circuit that incorporates mics and LEDs you can start with these examples and a bare C.H.I.P. Pro. 

#### Blinkenlights (Buildroot)
Size: ~60MB

This simple example provides easy-to-understand code with exciting results! Flash C.H.I.P. Pro with this image and LEDs connected to **GPIO D0-D7** turn on and off in a cascading pattern. LEDs connected to the **PWM0 and PWM1 pins** will pulse from dim to bright. 

#### VU Meter (Buildroot)
Size: ~60MB

Want to make sure your mics are working? Use this handy VU Meter example. LEDs connected to GPIO D0 - D7 will light proportional to the volume of the noise captured by two mics connected to the **MICIN1 and MICIN2 pins**.

### Debian
Size: ~180MB

We provide a standard Debian distribution, complete with all the package managers and conveniences you know and love. This package is ideal for development, since it is more flexible than the buildroot-based Gadget OS. However, you will want to keep track of your dependencies to more easily transition to the more nimble Gadget OS.

## Make a Serial Connection

C.H.I.P. Pro is a headless computer, so you will need a separate computer in order to interact with it. This section will go over how to connect through USB-serial, connect to a WiFi network and where to find example scripts.

### USB-serial to UART Pins

A UART to USB-serial connection between C.H.I.P. Pro and your computer offers the most comprehensive look at what's happening in C.H.I.P. Pro as it boots, since you can get all message output from the moment it starts booting. 

#### Things you will need

* USB-UART cable ([for example](https://www.amazon.com/JBtek-WINDOWS-Supported-Raspberry-Programming/dp/B00QT7LQ88/ref=sr_1_6?srs=9123049011&ie=UTF8&qid=1488833574&sr=8-6))
* Drivers
* Soldering Iron
* Solder
* Pin headers
* Computer with monitor (for example, a [C.H.I.P.](http://www.getchip.com/)!)
* terminal emulation software for Windows such as [PuTTY](http://www.chipkin.com/using-putty-for-serial-com-connections-hyperterminal-replacement/) (OS X and Linux have one built-in)

#### Install USB-UART Cable Drivers

Not only will you need a USB-UART cable but you will need the appropriate drivers that go with the cable installed. Download and install the appropriate driver based on your computer's operating system.

For example, [this](https://www.amazon.com/JBtek-WINDOWS-Supported-Raspberry-Programming/dp/B00QT7LQ88/ref=sr_1_6?srs=9123049011&ie=UTF8&qid=1488833574&sr=8-6) cable uses the Prolific hardware. The drivers are [available on their site](http://www.prolific.com.tw/US/ShowProduct.aspx?pcid=41&showlevel=0041-0041). If you are on Windows the driver can be installed after connecting C.H.I.P. Pro to your computer and navigating to Device Manager, finding **Ports (COM & LPT)** and double-clicking on the unrecognized USB-serial port. From the window that pops up you will be able to tell the computer to go find the device's driver online and install it.

#### Solder Headers to C.H.I.P. Pro

To connect the USB-UART cable to C.H.I.P. Pro you will need to solder headers onto the board for a reliable connection. 

PHOTOS OF SOLDERED

Usually, the below connections are made between the cable wires and the C.H.I.P. Pro, but make sure to check the manufacturer's product description for the correct mapping.
 
* black -  GND
* green - RX
* white - TX
* red - CHG-IN 

PHOTO OF CONNECTION

### OS X & Linux

Mac systems and most flavors of Linux come with the terminal emulator software Screen. If your Linux distro does not come with Screen and uses Apt install using apt-get:

```
sudo apt-get install screen
```

With C.H.I.P. Pro connected to your computer check to see if the usbserial port has appeared: 

**Mac**

```
ls /dev/tty.*
```

The port name will be `/dev/tty.usbserial`.

**Linux** 

```
ls /dev/ttyUSB*
```

The port name will be `ttyUSB0`.

#### Connect 

Use Screen to create a serial terminal connection at 115200 bps:

**Mac**

```
screen /dev/tty.usbserial 115200
```
**Linux**

```
screen /dev/ttyUSB0 115200
```

Once a terminal window pops up, hit the Enter key. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.

#### Exit Screen

When done with Screen, press Ctrl+A then Ctrl+\ to kill all windows and terminate Screen. 

If you get the error **"Cannot open line... Resource busy"** when trying to connect via Screen it's because the last session was not properly exited. Here is how to back and exit properly.

Search for the open file and active process using usbserial:

```
lsof | grep usbserial
```

You will get an output that looks something like this:

```
screen	27127 Sefi	5u 	CHR           	18,0    	0t0   	605 /dev/tty.usbserial
```

Note the process ID. In this case, it's 27127. Then run:

```
screen -x 27127 
```

This will return you to the previous screen session. Then use Ctrl+A Ctrl+\ to close it (will ask you to confirm).


### Windows

Download the [PuTTY terminal emulator](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

In Windows open the **Device Manager**. Find and expand **Ports (COM & LPT)**. Find the port labeled **USB-to-Serial Port (COMx)** and take note of the COMx port number. This is the port that the C.H.I.P. Pro Dev Kit is connected to.

In PuTTY choose **Serial** as the **Connection type**. Then, plug these items in and click **Open**. 

* COMx number as the **Serial Line**  
* 115200 as the **Speed** (baud rate)

[![Com Port](images/ComPort.PNG)] (images/ComPort.PNG) | [![puTTY](images/puTTYsetM.jpg)] (images/puTTYsetM.jpg) | 
|:---:|:---:|
| In Device Manager find COM port # | Plug port # and baud rate into puTTY | 

Once a terminal window pops up, press Enter. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.


### USB Gadget Serial

#### Things you will need

* USB A to micro-USB cable ([for example](http://www.cablewholesale.com/products/usb-firewire/usb-2.0-cables/product-10u2-03101bk.php))
* Computer with monitor (for example, a [C.H.I.P.](http://www.getchip.com/)!)
* Terminal program for Windows such as [PuTTY](http://www.chipkin.com/using-putty-for-serial-com-connections-hyperterminal-replacement/) (OS X and Linux have terminals built-in)

If your OS is configured for Gadget serial, this is usually the easiest way to get inside C.H.I.P. Pro's software. While you won't be able to get boot messages, since the serial emulation won't be ready, all you need is a USB A to micro-USB cable to connect C.H.I.P. Pro to your computer. 

PHOTO USB PORT CONNECTION

### OS X & Linux

```
screen /dev/tty.usbmodem1440 115200 #OS X
screen /dev/ttyACM0 115200          #Linux
```

Note that for OS X you either need to list out all the tty devices with `ls /dev/tty.usbm*` to find the actual ID or use the tab key to autocomplete, like `screen /dev/tty.usbm <tab>`.

### Windows

For Windows read [our guide](http://docs.getchip.com/chip.html#using-putty) on connecting with PuTTY or Cygwin.

## Connect to WiFi Network

Once you have connected to C.H.I.P. Pro with a serial connection, you can set it up for network access. How this happens depends on the OS you have loaded onto C.H.I.P. Pro. Most likely you'll be able to make basic connections to a WiFi network using either `connman` or `nmcli` in the command line.

### Connman

The basic commands to connect are done in a connman terminal. You can learn more about connman [here](https://wiki.archlinux.org/index.php/Connman)

```
sudo connmanctl # enter the connman terminal

>enable wifi # turn on wifi
>scan wifi # find networks
>agent on # let connman prompt for a password when needed
>services # list all the visible networks so you can get the wifi_ id string
>connect wifi_7cc70905cd77_4e5443_managed_psk #connect to wifi_ id, connman will then prompt for password
>quit # get back to linux terminal
```

If your network does not have a password (ends with `managed_none`), you can connect using the `wifi_` id that does not have the word "hidden" in it.

Confirm your connection with `ping -c 4 8.8.8.8` and get your IP address from the wlan0 line from `ip a`.

#### ssh on buildroot

Once you have your C.H.I.P. Pro on the network, chances are that you'll want to use `ssh` to connect to it. You can `ssh chip@<ip address>`. However, you'll probably want to switch to `root` once you are in. You can do that with the command `su` and use `root` as the password.

### nmcli

You may find `nmcli` is the gateway to your network if you are using a Debian linux image on C.H.I.P. Pro. There's a lot of information about nmcli on the [archlinux site](https://wiki.archlinux.org/index.php/NetworkManager). If nmcli is what you need, here are the commands you can use to connect to a network using your serial connection in the terminal:

```
sudo nmcli d wifi # list visible wifi networks
sudo nmcli d wifi connect "YOUR_NETWORK" password "NETWORK_PASSWORD" ifname wlan0 # if network is hidden add this to end: hidden yes
```

#### ssh on debian

If you want to connect to C.H.I.P. Pro with `ssh` you will probably find it convenient to setup a unique name for your C.H.I.P. Pro. [This gist](https://gist.github.com/nyboer/1fc232e0d006b656d2b724698c7ff90f) has a simple script to make this easy.

### ping!

It's always reassuring to check that you have a connection with ping:

```
ping 8.8.8.8 #google dns server
```

## Access I/O via sysfs	

### GPIO Input

These lines of code will let us read values on pin CSIDO, which corresponds to pin 132 in the linux sysfs (CSID0-CSID7 have numbers 132-139) First, we tell the system we want to listen to this pin:

```shell
  sudo sh -c 'echo 132 > /sys/class/gpio/export'
```

View the mode of the pin. This should return “in”:

```shell
  cat /sys/class/gpio/gpio132/direction
```

Connect a jumper wire or switch between Pin CSID0 and GND. Now use this line of code to read the value:

```shell
  cat /sys/class/gpio/gpio132/value
```

### GPIO Output

You could also change the mode of a pin from “in” to “out”

```shell
  sudo sh -c 'echo out > /sys/class/gpio/gpio132/direction'
```

Now that it's in output mode, you can write a value to the pin:

```shell
  sudo sh -c 'echo 1 > /sys/class/gpio/gpio132/value'
```

If you attach an LED to the pin and ground, the LED will illuminate according to your control messages.


### GPIO Done

When you are done experimenting tell the system to stop listening to the gpio pin:

```shell
  sudo sh -c 'echo 132 > /sys/class/gpio/unexport'
```

### Finding GPIO Pin Names
You can calculate the sysfs pin number using the [Allwinner R8 Datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/Allwinner%20R8%20Datasheet%20V1.2.pdf), starting on page 18. 

The letter index is a multiple of 32 (where A=0), and the number is an offset. For example PE4 is `CSID_D0` so

```
E=4
(32*4)+4 = 132
```

Therefore, listening to CSID0 in sysfs would begin with

```
sudo sh -c 'echo 132 > /sys/class/gpio/export'
```
