# Connect and Control

C.H.I.P Pro is a headless computer, so you will need a separate computer in order to interact with it. The Dev Kit makes this easy and powerful, with a built-in USB to Serial converter for a direct connection to UART1. Connect the board to your computer with a common USB A to Micro-USB B cable. You can instantiate a UART connection with C.H.I.P Pro powered on or off. If you set it up before you power C.H.I.P Pro, you'll be able to see all messages starting from boot.

The topics in this section cover features that are unique to the Dev Kit. Other topics, such as connecting to a network, USB Gadget serial connections, and using GPIO are covered in the [C.H.I.P. Pro documentation](http://docs.getchip.com/chippro.html#use_it)

## USB-Serial (UART1) Connection.

There are several applications you can use to make a USB-serial terminal connection to the Dev Kit. Below are some of the most common.

### OS X & Linux

Connect the Dev Kit to your computer and open a terminal window. Find out the tty.usbserial dev path the Dev Kit is attached to by using the command below or use the tab key to autocomplete, like `screen /dev/tty. <tab>`

```
ls /dev/tty.*
```
On Linux, this is usually `ttyUSB0`, and on OS X, something similar to `usbserial-DN022CZ9`. On Debian systems, you may need to install screen: 

```
sudo apt-get install screen
```

Use Screen to create a serial terminal at 115200 bps:

```
screen /dev/tty.usbserialxxxxxxxx 115200
```

Log in to C.H.I.P. Pro using the default user and password `chip`. 

#### Exit Screen

When done, press Ctrl+A then Ctrl+\ to kill all windows and terminate Screen. If you get the error "Cannot open line... Resource busy" it's because the last session was not properly exited. Search for the open file and active process using usbserial:

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

It will return to your previous screen session. Then use Ctrl+A Ctrl+\ to close it properly (will ask you to confirm).

**Windows**

Download the [PuTTY terminal emulator](http://www.putty.org/) or [Cygwin](https://www.cygwin.com/).

Open your Device Manager and find the port labeled USB Serial to find the COM port number. The items to plug into either Cygwin or PuTTY are:

* COMxx number as the *Serial Line* or *COM Port* 
* 115200 as the *Speed* or *Baud Rate* 
* In PuTTY choose Serial as the *Connection Type*

## Audio

The C.H.I.P. Pro Development Kit has several ways to access audio in and out. Stereo audio in and out is handled by a 24bit/48K DAC built-in to the GR8 processor. There are also digital options that you can use, but require configuration of the Linux kernel and additional hardware to access.

* Audio output via 3.5mm TRRS jack
* Mono input via 3.5mm TRRS jack
* Stereo microphones
* MIC1 and MIC2 header pins
* I2S digital audio
* SPIDIF digital audio

### Input
There are two (2) analog MEM (micro electro mechanical) microphones on the Dev board. These are enabled by default. 

If you want to use the MIC1 and MIC2 pins for audio input, you'll need to [cut a trace](#back-traces).

The "Sleeve" (bottom-most ring) on the TRRS jack can be used as a mono audio input, suitable for microphones commonly built-in to headphones. If you want to used this connector, you'll need to [cut a trace](#back-traces).

### Output

The 3.5mm TRRS jack provides stereo output suitable for headphones or amplification to stereo speakers.

## USB
The USB A jack can be used to connect and use popular accessories like storage, MIDI controllers, keyboards, pointing devices, audio hardware, and more. C.H.I.P. Pro does not provide power to the USB A port on its own, so the Development Kit is a good example of how this works.  

## On-board LEDs
The Dev board provides ten LEDs to make it easy to test your GPIO skills without having to wire anything up. 

### GPIO LEDs
Eight of these LEDs can be turned on and off with standard Linux sysfs commands to the GPIO pins DO to D7. 

### PWM LEDs
There are also two LEDs that are connected to the PWM pins for testing and learning about pulse width modulation. 

## Make it with C.H.I.P. Pro! 
The Dev Kit board contains hardware to make rapid prototyping with C.H.I.P. Pro a unique experience. When it comes to software however, the C.H.I.P. Pro and Dev Board are the same. To learn more about C.H.I.P. Pro, such as connecting to WiFi and accessing GPIO, head over to the official [C.H.I.P. Pro Docs page](http://docs.getchip.com/chip_pro.html#get-working-with-c-h-i-p-pro).

# Open Source
The C.H.I.P. Pro is open source hardware. Get all the details in our [github repo](https://github.com/NextThingCo/CHIP_Pro-Hardware).
