# What's a DIP?

DIPs are accessory boards that give new capabilities to C.H.I.P.  DIPs come in many flavors, like official Next Thing Co. HDMI and VGA DIPs that give C.H.I.P. higher resolution video output to community DIPs that add more USB ports, control motors, or blink LEDs.  C.H.I.P.s (with the proper software) automatically recognize when a DIP is attached and act accordingly.

Here you'll find specs and instructions for the official Next Thing Co. HDMI and VGA DIPs as well as tips and tricks to get you started making your own.

## Requirements
To properly recognize official NTC DIPs, C.H.I.P.s will need to update to at least Debian with Linux kernel 4.4.  For a quick start on how to update your C.H.I.P., head to [getchip.com/update](http://getchip.com/update).  Full documentation exists in the [Update C.H.I.P. to Linux kernel 4.4 section](#update-c-h-i-p-to-debian-4-4)

## Attaching DIPs

Here's how you connect a DIP to C.H.I.P.

Orient the USB connector opposite the video connector.

![Attach the DIP](images/vga_attach-0.jpg)

Align the pins to C.H.I.P.'s headers and gently press with even force until....

![Attach the DIP](images/vga_attach-1.jpg)

...the two pieces are joined. Tasty!

![Attach the DIP](images/vga_attach-2.jpg)

## Disconnect the DIP

With great care! It's important to pull with an even force to separate the DIP from the CHIP. It helps to gradually work the DIP away from the pin header at each side. When you can see a slight and even amount of exposed DIP pins on all sides, then you can grip the C.H.I.P. and DIP in the middle and pull them apart evenly. You do not want bent header pins on your DIP! We've found that the [IC Extractor](https://en.wikipedia.org/wiki/IC_extractor) is an excellent companion if you want to frequently remove DIPs.
