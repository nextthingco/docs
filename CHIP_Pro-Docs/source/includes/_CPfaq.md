# C.H.I.P. Pro FAQ

## Hardware/Software

### How do I get Bluetooth working?

Currently, the Debian-based Pro image with built-in Bluetooth drivers is a work in progress. Since our software and hardware is [open source](https://github.com/NextThingCo) for development, our community created an image that includes a working Bluetooth utility that you can use to validate that Bluetooth is working. Follow the instructions below to manually flash C.H.I.P. Pro with a Debian image that implements the Bluetooth stack using BlueZ.

These instructions are written for a development machine that runs a Debian distro of Linux. Depending on what OS your machine runs you will either need to install packages using a different package manager than `apt-get` or your dev machine may already include them.

* Install Git

```
sudo apt-get update
sudo apt-get install git -y
```
* Install necessary packages to update C.H.I.P. firmware

```
sudo apt-get install sunxi-tools u-boot-tools -y
git clone https://github.com/NextThingCo/CHIP-mtd-utils.git
cd CHIP-mtd-utils
make
sudo make install
```
* Clone CHIP-tools

```
git clone  https://github.com/NextThingCo/CHIP-tools.git
cd CHIP-tools
```
* Download tarball image from [here](https://mega.nz/#!wHpXxJiA!lWTAw8ymVKOD0pe3WxE6OqVsV48FJuFtsdJJ1vCWj7E)
and place it in CHIP-tools directory.
* Expand tarball

```
tar xf chip-ble.tar.gz 
```
* Check to see that made a directory called `/img`.
* Set permissions to your username

```
sudo chown -R : img/
```
* Hold down the button on C.H.I.P. Pro and plug it into your development computer's USB port to put CHIP Pro in FEL mode.
* While still holding down the button, run this command in terminal:

```
sudo ./chip-update-firmware.sh -L img/
```
* After you see `fastboot...OK` you can release the button and wait for the flashing to finish. Once it does, you will get a message that `"CHIP is ready to roll!"`.
* Unplug CHIP Pro and plug back in. Connect via UART-serial and login.  
* Start the interactive `bluetoothctl` command.

```
sudo bluetoothctl
```
* scan, pair and connect to devices

```
scan on
pair [MAC ADDRESS]
connect [MAC ADDRESS]
scan off
```

Original forum [post](https://bbs.nextthing.co/t/chip-pro-bluetooth-driver-not-available/14905/26).

### What does FCC Modular Certification mean?
C.H.I.P. Pro is CE, IC, and FCC Part 15 Modular Transmitter certified for use with multiple commercially available [external antennas](https://docs.getchip.com/chip_pro_devkit.html#wifi-antenna). Read our compliance statement for more information.

###  I made a C.H.I.P. prototype, will it be hardware and software compatible with GR8?
Yes! GR8 has the same Allwinner R8 processor that is in C.H.I.P., so your C.H.I.P. software is 100% compatible with C.H.I.P. Pro. We believe you shouldn’t have to change your software to go into production.

## Ordering

### How much does C.H.I.P. Pro cost?
C.H.I.P. Pro costs $16. Contact [sales@nextthing.co](mailto:sales@nextthing.co)
(pre-flashing available for large orders).

### Are there quantity discounts?
C.H.I.P. Pro is $16 no matter how many you order. But, if you have to ask you should contact [sales@nextthing.co](mailto:sales@nextthing.co). 

### Is C.H.I.P. Pro open source?
Yes, you can see our design files in our [git repository](https://github.com/NextThingCo/CHIP_Pro-Hardware).

### Does C.H.I.P. Pro replace C.H.I.P.?
C.H.I.P. is still a huge part of what we do. We made C.H.I.P. Pro and Gadget so the enterprising members of the CHIPster community would have a great option for scalable hardware, software and infrastructure for their products.

### Where can I buy C.H.I.P. Pro?
Currently, we’re offering the C.H.I.P. Pro Dev kit for $49 in our [web store](https://nextthing.co/pages/store).

###  How many may I order?
As many or as few as you’d like. 1 to 1 million (or more). For larger orders, hit us up at [sales@nextthing.co](mailto:sales@nextthing.co)

### When will C.H.I.P. Pro ship?
C.H.I.P. Pro Dev kits are shipping in late Q4 of 2016 and C.H.I.P. Pro will be available in any quantity starting Q1 of 2017.

###  What is the lead time on a C.H.I.P. Pro order?
Once available in Q1 of 2017, small orders (1-20) will ship immediately. For large orders taking advantage of our factory flashing offering, there will be a lead time of 60 days.



