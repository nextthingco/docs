
# HDMI DIP

## Intro

The HDMI DIP allows C.H.I.P. to connect to a monitor or television via an HDMI cable at a maximum resolution of 1920 by 1080 at 30Hz (a.k.a, 1080p). This DIP only provides a video signal over the HDMI cable: there is no audio encoded with it.

The HDMI DIP makes C.H.I.P. even better for traditional uses like presentations, classrooms, and games, and makes amazing things like [large-scale installations](http://blog.nextthing.co/this-is-how-we-made-the-75-tall-mega-pocketc-h-i-p/), magic mirrors, and [urban projection](http://c-uir.org/mup/).

## Parts and Pieces

### What's in the Bag?

There is one HDMI DIP in the electrostatic bag, packaged with protective foam. HDMI cables and C.H.I.P.s are sold separately [at getchip.com](https://getchip.com/pages/store)

### Pictures

![HDMI DIP Callout Graphic](images/hdmi_callout.jpg)

  * Power switch: We added this is located on the top edge of the PCB, as it is close to impossible to access it.
  * Prototyping area - There is "Proto board" on the PCB itself. This is convenient if you would like to add a small circuit to your DIP, without having to add another board.
  * U14 partial breakout - This makes it easy to access the GPIO, UART, audio, and ground pins.
  * Volts - 5V & 3V voltages are available below the NTC proto area.
  * HDMI connector - A standard HDMI connector is used to send your video to a monitor, and is located at the bottom of the PCB.
  * The Video Processor is the brains of the HDMI DIP. It takes the video from the LCD_Dx pins.

## Requirements

 * C.H.I.P. with C.H.I.P. OS 1.1 with Debian and Linux 4.4 kernel
 * HDMI display
 * HDMI cable
 * 2A+ power adapter and micro USB cable

If you don't have Debian with Linux kernel 4.4, or if you are unsure, [follow this guide](#update_to_debian44).

## Use It

![Plug it!](images/hdmi_plugged_in_half.jpg)

The HDMI DIP is extremely easy to use. Once you have your C.H.I.P. OS updated, it's really as simple as attaching the DIP to your C.H.I.P, plugging in an HDMI monitor, plugging into your power supply and booting up C.H.I.P. But, for posterity's sake, here's all the details.

 * Connect DIP to C.H.I.P.
 * Connect cable to DIP and monitor
 * Connect C.H.I.P. to power supply
 * Power up C.H.I.P.

Once C.H.I.P has power, you'll start seeing output on your monitor. Don't try to power C.H.I.P. with the HDMI DIP from your computer's USB power supply. There simply isn't enough power!
Once C.H.I.P is booted, you may want to change the resolution. You can do this with the control panel found in the Computer Things menu, going to Settings/Display

![display control panel](images/settings_select.jpg)

In the Display control panel, you can select a resolution in the Outputs menu:

![Change Resolutions](images/settings_hdmi_resolution.jpg)

After you select a resolution, you'll need to "Apply" it:

![apply the new resolution](images/settings_apply.jpg)

If you like using commandline in the terminal, you can change resolutions with `xrandr`, such as

```shell
xrandr -s 1280x720
```
## Know it

### Supported Resolutions

We cannot provide an exhaustive list of all resolutions, since this can depend on the attached monitor, but here are some observed resolutions:

  * 1360x768
  * 1920x1080
  * 1680x1050
  * 1280x1024
  * 1280x960
  * 1280x800
  * 1280x720
  * 1024x768
  * 800x600
  * 720x480
  * 640x480
  * 720x400

### Video Only

HDMI DIP only does video - it does not carry an audio signal. However, the audio connectors on the 3.5mm TRRS jack and header pins still output stereo audio normally.

### How to Disconnect the DIP

With great care! It's important to pull with an even force to separate the DIP from the CHIP. You do not want bent header pins on your DIP! We've found that the [IC Extractor](https://en.wikipedia.org/wiki/IC_extractor) is an excellent companion if you want to frequently remove DIPs.

## Hack It

The HDMI DIP is hackable. There are breakouts for the headers and a small proto-board area so you can add some simple circuits. One example is adding a pin header so you can access C.H.I.P.'s UART bus. This image shows an HDMI DIP with the added pin header soldered in place:

![pin headers for UART passthrough to CHIP](images/hdmi_uart_placement.jpg)

and the receive, transmit, and ground wires of a USB-UART cable connecting CHIP to a computer's serial bus:

![uart artfully applied](images/hdmi_uart_cnxn.jpg)

## Open Source

The HDMI DIP is open source. Design files are in our [github repo.](https://github.com/NextThingCo/DIP-HDMI-PCB)
