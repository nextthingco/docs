# VGA DIP

## Intro

The VGA DIP allows C.H.I.P. to connect to a monitor via a standard 15-pin VGA cable at a maximum output resolution of 1600 by 900 at 60 Hz. Unlike the 16:9 ratio of HDMI, the VGA DIP usually outputs in a 4:3 aspect ratio.

## Parts and Pieces

### What's in the Bag

There is one VGA DIP in the electrostatic bag, packaged with protective foam. VGA cables and C.H.I.P.s are sold separately [at getchip.com](https://getchip.com/pages/store)

### Pictures

![VGA DIP Callout Graphic](images/vga_callout.jpg)

 * RGB breakouts - RGB breakouts can be found at the edge of the VGA connector on the left side. These are available if you ever want to add cool effects, or to "bend" your VGA DIP
 * Trim-pot breakouts (RGB) - There are three footprints for1 0K trimpots. These can be installed with only a few solder joints, and can create a really awesome visual effects like saturating colors.
 * U14 breakouts - The U14 header breakout is directly to the left of U14. This is important if you would like to access FEL, UART, XIO, CSID, audio, etc. The name of each pin is labeled above the corresponding pad.
 * JST connector breakout - A JST connector footprint  is available to be populated on VGA DIP. Because the VGA connector is really close to the existing JST battery connector, it makes it difficult to plug/unplug with the VGA DIP installed. Note: DO NOT INSTALL TWO BATTERIES INTO C.H.I.P. THIS WILL DAMAGE YOUR C.H.I.P.
 * Prototyping area - There is "Proto board" on the PCB itself. This is convenient if you would like to add a small circuit to your VGA DIP, without having to add another board.
 * VGA connector - This is a standard female DB-15 VGA connector to carry the video signal to a VGA monitor.
 * Power switch - A Power switch has been added to the VGA DIP. It is close to impossible to access the Power On Switch on C.H.I.P with the VGA DIP installed, so we added a second Power On Switch. This is located on the right side of the PCB, and is accompanied by a "Power On" symbol.

## Requirements

 * C.H.I.P. with C.H.I.P. OS 1.1 with Debian with Linux kernel 4.4
 * VGA display
 * 15-pin VGA cable (we recommend a cable with [Ferrite beads](https://en.wikipedia.org/wiki/Ferrite_bead))
 * 2A+ power adapter and micro USB cable

If you don't have Debian with 4.4 kernel, or if you are unsure, [follow this guide](getchip.com/update)

## Use It

The VGA DIP is extremely easy to use. Once you have your C.H.I.P. OS updated, it's really as simple as attaching the DIP to your C.H.I.P, adding power to C.H.I.P., plugging in a VGA monitor, and booting up C.H.I.P. But, for posterity's sake, here's all the details.

 * Update C.H.I.P. OS
 * Connect DIP to C.H.I.P.
 * Connect cable to DIP and monitor
 * Connect C.H.I.P. to power supply
 * Power up C.H.I.P.

Once C.H.I.P has power, you'll start seeing output on your monitor. Once C.H.I.P is booted, you may want to change the resolution. You can do this with the control panel found in the Computer Things menu, going to Settings/Display

![display control panel](images/settings_select.jpg)

In the Display control panel, you can select a resolution in the Outputs menu:

![Change Resolutions](images/settings_vga_resolution.jpg)

After you select a resolution, you'll need to "Apply" it:

![apply the new resolution](images/settings_apply.jpg)

If you like using commandline in the terminal, you can change resolutions with `xrandr`, such as

```shell
xrandr -s 1024x768
```

## Know It

### Supported Resolutions

We cannot provide an exhaustive list of all resolutions, since this can depend on the attached monitor, but here are some observed resolutions:

  * 1600x900
  * 1280x1024
  * 1152x864
  * 1024x768
  * 800x600
  * 640x480
  * 720x400

## Hack It
The VGA DIP is hackable. There are breakouts for the headers and a small proto-board area so you can add some simple circuits. There's also access to the RGB signals for extra colorful fun! Here are a couple example hacks that bring joy and utility to your VGA DIP.

### RGB Trim Pots
Heat up your soldering iron, the VGA DIP is hackable. You may have noticed the pads suitably spaced for 10K trim pots, and the RGB breakouts. Here's a photo guide to soldering up some trim pots so you can manually adjust the individual red, green, and blue levels in the image. You can find [these pots](http://www.bourns.com/docs/Product-Datasheets/3386.pdf) at vendors such as [digikey](http://www.digikey.com/product-detail/en/bourns-inc/3386P-1-103TLF/3386P-103TLF-ND/1232547) and [mouser](http://www.mouser.com/ProductDetail/Bourns/3386P-1-103TLF/?qs=sGAEpiMZZMvygUB3GLcD7rufck0TIBKysL9OZJpl%2f%2fo%3d)

Trim pots are able to go in one way on TOP of the PCB for accessibility.

![able to go in one way](images/vgapot_01place.jpg)

Trim pots are sized and spaced for a precise alignment.

![sized and spaced for a precise alignment](images/vgapot_02allpots.jpg)

Here we see that there is only one way for the pots to go on the TOP side.

![only one way for the pots to go](images/vgapot_03thruhole.jpg)

Solder the leads and trim them like so.

![Solder the leads and trim them like so.](images/vgapot_04soldered.jpg)

Time to start Bending Colors!!!

![Control and Compose](images/vgapot_02allpots.jpg)

### UART Connection

Another example is adding a pin header so you can access C.H.I.P.'s UART bus. This image shows an VGA DIP with the added pin header soldered in place:

![pin headers for UART passthrough to CHIP](images/vga_uart_placement.jpg)

and the receive, transmit, and ground wires of a USB-UART cable connecting CHIP to a computer's serial bus:

![uart artfully applied](images/vga_uart_cnxn.jpg)

## Open Source

VGA DIP is open source. Design files are in our [github repo.](https://github.com/NextThingCo/DIP-VGA-PCB)
