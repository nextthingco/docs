# Support

This support section is where you will find frequently asked questions and topics of the technical variety. For general inquiries, check out our [C.H.I.P. Pro FAQ](http://ntc-docs-unstable.surge.sh/chip_pro.html#c-h-i-p-pro-faq) section.

## Power

### Why is my battery charging at a slow rate or not at all?
First, make sure the correct power source is connected to the correct pins as stated in the [documentation](https://docs.getchip.com/chip_pro.html#power-c-h-i-p-pro). 

Assuming the power source is connected correctly, the issue may be with C.H.I.P. Pro's BTS pin which is directly connected to the TS pin on the AXP209 power management unit. This pin expects a 10K thermistor as a way to monitor the battery by providing the pin with a specific voltage range. Hitting this range tells the PMU that it is safe to charge the battery. Without an added thermistor, it's recommended to disable this function by either connecting the BTS pin to ground or disabling through software. Read more about the BTS pin and how to disable it in the [Power](https://docs.getchip.com/chip_pro.html#battery-charging-and-bts-pin) section of the C.H.I.P. Pro docs. 

### I think my C.H.I.P. Pro is overheating!

There are a few reasons why your C.H.I.P. Pro may experience sudden power loss or a freeze, but heat is almost never the issue. Rest assured knowing that C.H.I.P. Pro has been tested and verified in various extreme temperatures.

The more likely issue is a lack of a proper power source or a software issue. Check the most recent [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware) for minimum and maximum power and temperature ratings. 

### My C.H.I.P. Pro shuts down during boot or when under heavy processing loads.

Make sure you are using an adequate power source that can provide a recommended **1 Amp of current**. You can also attach a single cell LiPo battery to the BAT pin to provide extra power when the processor needs it. 

Another common cause for sudden power loss is due to the AXP209’s power management shutting down if the current draw reaches a set threshold (900mA, for example). If your project has higher power needs, you may want to disable the current-limit feature and set the AXP209 to a "no limit" mode. This will allow the system to tolerate higher current. You find out more on page 33 of the [AXP209 datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/Component%20Datasheets).

The common way to set this register is using a systemd service that issues the proper command with i2c-tools:

```
i2cset -f -y 0 0x34 0x30 0x03
```

If this register needs to be set earlier in the boot process, you can also accomplish this from U-boot:

```
i2c dev 0
i2c mw 0x34 0x30 0x03 2
```

### My C.H.I.P. Pro is freezing when downloading or copying files.

If you are experiencing a freeze but C.H.I.P. Pro does not lose power, your system is most likely running out of NAND flash storage space. Try rebooting and freeing disk space in your file system.

If C.H.I.P. Pro loses power during these operations, it is most likely a problem with your power source.

### How can I prevent data from being corrupted in the event of a sudden power loss or immediate shutdown?

The best practice is to try and ensure that your device never turns off without completing a proper shutdown procedure. For example, when adding a battery to your device, it is best to write code that will monitor battery usage and power down your system gracefully when the voltage drops below a specified threshold.

If this is not an option for your application, you can also try calling the `sync` command periodically when you are writing data. This ensures that the NAND blocks are synchronized and may eliminate data corruption in the case of a sudden power loss.

### Is there an interrupt or some kind of event for the AXP209 power management?


The AXP209 has its own interrupts, which are connected to pin M2 (NMI) on the GR8. Currently, we do not provide documentation on how to use the NMI to respond to such events.

A simple way to monitor power usage is to write a script or service that queries the AXP209 on I2C bus 0 at periodic intervals.

## Hardware and Software

### How do I set the default state of the I/O pins in GadgetOS?

Sometimes you may have a project where you need to set the state of the I/O as early as possible before Linux has fully booted. You can accomplish this by adding a script for the U-Boot phase of the booting process.

In the gadget-buildroot folder, edit the following file for the board you’re using:

```
gadget-buildroot/gadget/board/nextthing/chippro/uboot-env
```

Let’s say you want to set the CSID6 (sysfs #138) and CSID7 (sysfs #139) pins to default to OUTPUT instead of INPUT. To do this, you need to add a function to the file like this:

```
set_gpio=gpio clear 138; gpio clear 139;
```

In this case, “clear” means resetting the I/O to an output state. You can also use commands like `gpio toggle` to invert the current value, `gpio set` to set the pin HIGH, or `gpio input` to set it as an input.

Now you need to call this function as early as possible in the boot process. In the same file, find this line:

```
preboot=run boot_fel
```

And change it to this:

```
preboot=run set_gpio; run boot_fel
```

Save this file and recompile your U-Boot changes.

```
/scripts/build-gadget make uboot-reconfigure all
```

Re-flash with the new build and reboot. Your I/O will now be set during the U-Boot portion of the booting process.

**NOTE:** If you then export this pin when Linux is booted, it may revert back to its default state, so be sure to set it again.

### Why is so much of my file system marked as “read-only”?

GadgetOS is designed to be as secure as possible. Making the file system read-only is one of the many steps we've taken to secure the OS. 

Additionally, a read-only root file system reduces the chance for data corruption during mission critical operations like over-the-air updates or surviving sudden power loss.

Of course, not all of the storage on in GadgetOS is read-only. Files in **the “/data” directory are fully read/write accessible**. 

### Why doesn’t my C.H.I.P. Pro (not in the Dev Kit) detect as a USB Serial Device when connected to my computer via the micro-USB port?

If you are using GadgetOS, the micro-USB port is configured as an ethernet gadget, which you can connect to using a shell application. If you want to use this as a USB serial port, you need to change the services running on the device and bind Getty to this port.

Alternatively, you can [connect a USB UART cable](https://docs.getchip.com/chip_pro.html#make-a-serial-connection) to communicate with C.H.I.P. Pro’s UART1-RX and UART1-TX pins (pins 44 and 43). This is essentially what the micro-USB port does on the C.H.I.P. Pro Dev Kit behind the scenes.

### In GadgetOS how do I reboot or shutdown my device from inside my Docker container?

The best practice is to write a script that runs outside of your Docker container and listens for some kind of event (a file change, a variable being set, etc). Once an event is detected inside the container, this script shuts down the system.

Another option is to install systemd on your device from the Buildroot menu. This approach will affect system boot time.

For a more brute force and lightweight approach, share the /proc directory with your container as a new volume. For example:

```	
docker run -v /proc:/host/proc -it "test" 
```

When your container is running, enter this command to synchronize the block devices and mount the read-only file system:

```
echo s > /host/proc/sysrq-trigger && echo u > /host/proc/sysrq-trigger && echo s > /host/proc/sysrq-trigger
```

Now to initiate a reboot, enter this command:

```
echo b > /host/proc/sysrq-trigger
```

Or to shutdown:

```
echo o > /host/proc/sysrq-trigger
```

### What kind of flash memory (NAND, SD cards, eMMC) does C.H.I.P. Pro and GR8 support? 

Currently, C.H.I.P. and C.H.I.P. Pro officially support the following NAND components:

* 512mb Toshiba SLC NAND: TC58NVG2S0HTA00
* 4gb Toshiba MLC NAND: TC58TEG5DCLTA00
* 4gb Hynix MLC NAND: H27UCG8T2ETR

### Can I add more NAND to the device to increase its available flash storage? 

Additional raw NAND components may work, but will most likely require changes to the Buildroot configuration. Be aware that NAND comes in two main varieties: SLC and MLC (single-level cells and multi-level cells). Accordingly, there are two different branches of the Next Thing Co. Linux kernel, one for each type of NAND.

### Can I boot from an SD Card?

Booting from an SD cards or eMMC is supported on the GR8 processor; however, on C.H.I.P. Pro, these pins are already taken by the on-board NAND storage. Custom GR8 boards don't have this problem, but you'll need configure Buildroot to use the appropriate settings to boot from an SD card.

### How can I make a backup of my NAND or eMMC file system?

Using **Rsync** is the current recommended way to backup. Rsync creates a compressed tar file of your root file system while excluding a few system directories. Here is an example of how you would do this:

```
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*",”/etc/udev/rules.d/*”,"/media/*","/lost+found","/boot/*"} / /tmp/backup && tar -C /tmp/backup -cvzf myBackup.tar.gz .
```

### How do I trigger an event when a USB device is added or removed?

Using udev rules you can specify a command to run when a device is added or removed. To learn more about udev functionality, please read Oracle’s [documentation](https://docs.oracle.com/cd/E37670_01/E41138/html/ch07s03.html).

### Can I connect an LCD or OLED display to C.H.I.P. Pro?

Small resolution SPI or I2C displays should work. It's also possible to reserve some of the available I/O to drive an 8-bit parallel display with additional driver support and configuration. Note that there are no HDMI, VGA, or composite video connections on C.H.I.P. Pro. 

Custom boards made with GR8 are a different story. The GR8 is able to drive high resolution displays up to 720p by exposing the 8080 interface. There is also a composite video connection (sometimes known as CVBS or RCA) for use with older televisions or monitors. For more information, please consult the [GR8 datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/Datasheets).

## WiFi and Bluetooth

### Why won’t GadgetOS use my settings from /etc/network/interfaces?

GadgetOS uses Connman to manage all network connections, which uses its own settings file (specified below). Anything written in /etc/network/interfaces will be overwritten.

```
/var/lib/connman/*/settings
```

Our [Debian C.H.I.P. Pro image called Pro](http://flash.getchip.com/) uses nmcli for its network management, which does support /etc/network/interfaces. However, if using Gadget OS, this would have to be added to your kernel configuration with some additional settings.

### Why am I getting poor WiFi signal strength and packet loss on my C.H.I.P. Pro?

C.H.I.P. Pro can use either the on-board ceramic SMT antenna or an external antenna attached to the on-board Hirose U.FL connector. Which antenna you should use depends on a few different factors like ground planes on the circuit board and location of power source in relation to the antenna connector.

For example, if you notice poor WiFi performance while using the C.H.I.P. Pro Dev Kit, you may want to switch to use the external antenna, even if you don’t have anything physically connected to it.

To enable the external antenna, set pin PB17 (Sysfs GPIO pin #49) to HIGH. To enable the on-board SMT antenna, set it to LOW. This process can also be found in the [C.H.I.P. Pro documentation page](https://docs.getchip.com/chip_pro.html#enable-wifi-antenna).

### I built and flashed a custom version of GadgetOS, but my WiFi isn’t working.

It’s possible that you may need to tell GadgetOS to recompile the Realtek WiFi drivers. This can be done with the following command:

```
./scripts/build-gadget make linux-reconfigure uboot-reconfigure rtl8723ds_mp_driver-dirclean rtl8723ds_mp_driver-rebuild rtl8723ds_bt-dirclean rtl8723ds_bt-rebuild all
```

### I’m using Bluez, but can’t find the hcid.conf file.

Due to a security risk, Bluez removed the ability to store PIN data in config files after version 3. At this time, Next Thing Co. only provides official support for Bluez 5.

### I install Bluez and tried to run “bluetoothctl”, but my system appears to have frozen.

Not to worry, your system did not freeze. (You can press Ctrl-C to exit bluetoothctl.) The most likely reason this is happening is that you have not yet started the dbus service. You can do this manually by running “bluetoothd” before running “bluetoothctl”.

### What is the proper way to set Bluetooth’s MTU to reduce power consumption or change signal strength?

Add the Bluez 5.x package and use tools such as “btgatt-client” and “btgatt-server”. Other utilities such as “hcitool” are deprecated and should no longer be used.

### Bluetooth is not working on C.H.I.P. Pro Debian-based Pro image.

Currently, the Debian-based Pro image with built-in Bluetooth drivers is a work in progress. Since our software and hardware is [open source](https://github.com/NextThingCo) for development, our community created an image that includes a working Bluetooth utility you can use to validate whether Bluetooth is working. Follow the instructions below to manually flash C.H.I.P. Pro with a Debian image that implements the Bluetooth stack using BlueZ.

These instructions are written for a development machine that runs a Debian distributions of Linux. Depending on what OS your machine runs you will either need to install packages using a different package manager than `apt-get` or your dev machine may already include them.

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
* Scan, pair, and connect to devices

```
scan on
pair [MAC ADDRESS]
connect [MAC ADDRESS]
scan off
```

Original forum [post](https://bbs.nextthing.co/t/chip-pro-bluetooth-driver-not-available/14905/26).








