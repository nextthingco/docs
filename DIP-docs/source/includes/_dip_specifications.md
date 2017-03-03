# DIP Specifications

As you might imagine, a DIP could be almost anything that plugs into C.H.I.P. While our VGA and HDMI DIPs provide very specific capabilities, a less obvious DIP example is the PocketC.H.I.P: its touchscreen, case, keyboard, and extensive circuit board may seem to be product distinct from C.H.I.P, but it is in fact, merely a DIP that attaches to C.H.I.P. and identifies itself to the operating system. Since function isn't really limited by our specification, it's important to know that to call something that attaches to C.H.I.P. a "DIP", it needs to comply with the C.H.I.P. DIP specifications described in this document.

## Form Factor

There is no form factor for DIPs - go and surprise us! A DIP could host just a tiny button, or be a 30-foot robot that hands out nutritious snacks to small children. However, there are considerations for certain parts that will make it easier to connect a C.H.I.P. with a DIP.

## DIP Identification

C.H.I.P. needs to know which extension board is attached in order to configure Linux accordingly. To do this, C.H.I.P. checks for a 1wire EEPROM at boot time.
If a 1wire EEPROM is detected, its data is read, and if C.H.I.P. recognizes a supported DIP, it automatically sets up the software accordingly ([using a device tree overlay](#dip-maker-s-Guide)).

The 1wire EEPROM needs to be connected to the **LCD_D2** pin on [pin header U13](chip.html#pin-headers) and should be able to store a least 122 bytes (see data-format below). The DS2431 is a common EEPROM part that works well for this.
This readable EEPROM is actually the **only** requirement for an extension board to comply with the DIP specification.

## Data Format

The data is structured as follows:

|Offset | Length | Name | Description|
|---|---|---|---|
|0x00 | 4 | MAGIC | Header to identify a DIP, must be ‘C’,’H’,’I’,’P’|
|0x04 | 1 | VERSION | Version of the data format|
|0x05 | 4 | VENDOR ID | 32-bit vendor ID, must be unique|
|0x09 | 2 | PRODUCT ID | 16-bit product ID, vendor manages product ids|
|0x0B | 1 | PRODUCT VERSION | Product version, managed by vendor|
|0x0C | 32 | VENDOR NAME | Vendor name as human readable ASCII string|
|0x2C | 32 | PRODUCT STRING | Product name as human readable ASCII string|
|0x4C | 20 | RESERVED | space reserved for future updates|
|0x60 | 16 | USER DATA | Random data, e.g. a MAC address for an ethernet DIP|

## Vendor ID and Product ID

Each DIP must have a unique combination of vendor and product id for C.H.I.P. to recognize it. We have a very simple, open system for makers to register vendor IDs [self-contained in a github repository](https://github.com/NextThingCo/DIPvendor). Even if you don't want to sell it, it's worth getting an ID, to prevent the chance of your DIP confusing C.H.I.P. in the future.

### Reserved VIDs

There are some vendor IDs that are reserved.

  * Next Thing Co uses **0x009d011a** as VID.
  * VIDs **0x00000000 - 0x0000000f** reserved for prototyping.

### Existing Products

So far, these official DIPs exist:

  * PocketC.H.I.P. (VID=0x009d011a, PID=0x00000001)
  * VGA DIP (VID=0x009d011a, PID=0x00000002)
  * HDMI DIP (VID=0x0090d011a, PID=0x00000003)

## How does C.H.I.P. handle device setup and drivers?

DIP makers can provide their own drivers and device tree overlays as .deb package.
A registered vendor id does not imply the device tree overlay will be included in the official C.H.I.P. firmware. 

The DIP Maker Guide provides a git repository with sample code, a script for compiling device trees, and a script for flashing EEPROM with data. Read more and get the repo [here](#dip-maker-s-Guide).
