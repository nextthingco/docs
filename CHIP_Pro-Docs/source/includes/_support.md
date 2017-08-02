# Support

This support page is where you can find frequently asked questions and topics of the technical variety. For general inquiries, check out our C.H.I.P. Pro FAQ section.

## Power

### Why is my battery charging very slowly or not at all?
First, make sure the correct power source is connected to correct pin as stated in the [documentation](https://docs.getchip.com/chip_pro.html#power-c-h-i-p-pro). 

Assuming the power source is connected correctly, the issue may be with the BTS pin which is directly connected to the TS pin on the AXP209 power management unit. This pin expects a specific voltage range in order to know it is safe to charge the battery. It's recommended to disable it by either connecting the pin to ground or disabling through software. Read more about the TS pin and solutions provided in the [Power](https://docs.getchip.com/chip_pro.html#battery-charging-and-bts-pin) section of the C.H.I.P. Pro docs. 

### I think my C.H.I.P. Pro is overheating!

There are a few reasons why your C.H.I.P. Pro may experience sudden power loss or a freeze, but heat is almost never the issue. C.H.I.P. Pro has been tested and verified in various extreme temperatures. The cause of possible overheating issues is usually due to lack of a proper power source or a software issue. Check the most recent [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware) for minimum and maximum power and temperature ratings. 

### My CHIP Pro shuts down during boot or when under heavy processing loads.

Make sure your are using an adequate power source that can provide a recommended 1 Amp of current. You can also attach a single cell LiPo battery to the BAT pin to provide extra power when the processor needs it. 

Another common cause for sudden power loss is due to the AXP209’s power management shutting down if the current draw reaches a set threshold (900mA, for example). If your project has higher power needs, you may want to disable the current-limit feature so that the AXP209 will allow the system to tolerate higher current.

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

If you are experiencing a freeze but C.H.I.P. Pro did not experience a power loss, this is most likely due to running out of storage space in the onboard memory. Try rebooting and freeing disk space in your file system.

If C.H.I.P. Pro loses power during these operations, it is most likely a problem with your power source.

### How can I prevent data from being corrupted in the event of a power cut or some other kind of immediate shutdown?

The best practice is to try and ensure that your device never turns off without completing a proper shutdown procedure. For example, when adding a battery to your device, it is best to write code that will monitor battery usage and power down your system gracefully when the voltage drops below a specified threshold.

If this is not an option for your application, you can also try calling the “sync” command periodically when you are writing data. This ensures that the NAND blocks are synchronized and may eliminate data corruption in the case of a sudden power loss.

### Is there an interrupt or some kind of event for the AXP209 power management?

A simple way monitor power usage would be to write a script or service that queries the AXP209 on I2C bus 0 at periodic intervals.

The AXP209 has its own interrupts, which are connected to pin M2 (NMI) on the GR8. Currently we do not provide documentation on how to use the NMI to respond to such events.

## Hardware and Software

### How do I set the default state of the IO pins?

Sometimes you may have a project where you need to set the state of the IO as early as possible before Linux has fully booted. We can accomplish this by adding a script for the U-boot phase of the booting process.

In the gadget-buildroot folder, edit the following file for the board you’re using:

```
gadget-buildroot/gadget/board/nextthing/chippro/uboot-env
```

Let’s say we want to set the CSID6 (sysfs 138) and CSID7 (sysfs 139) pins to default to OUTPUT instead of INPUT. To do this, we need to add a function to the file like this:

```
set_gpio=gpio clear 138; gpio clear 139;
```

In this case, “clear” means resetting the IO to an output state. You can also use commands like “gpio toggle” to invert the current value, “gpio set” to set the pin HIGH, or “gpio input” to set it as an input.

Now we need to call this function as early as possible in the boot process. In the same file, find this line:

```
preboot=run boot_fel
```

And change it to this:

```
preboot=run set_gpio; run boot_fel
```

Save this file and recompile your uboot changes.

```
/scripts/build-gadget make uboot-reconfigure all
```

Re-flash with the new build and reboot. Your IO will now be set during the u-boot portion of the booting process.

**NOTE:** If you then export this pin when Linux is booted, it may revert back to its default state, so be sure to set it again.

### I’m using Docker and I need to be able to reboot or shutdown my device from within a container. How can I do this?

The best practice would be write a script that runs outside of your Docker container which listens for some kind of event (a file change, a variable being set, etc). The script could then shut down once this event has been received from the Docker container. Another option is to install systemd on your device from the buildroot menu, although this will affect your boot time.

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

### What kind of flash memory does CHIP Pro or the GR8 support? (NAND, SD cards, eMMC, etc.)

Currently, C.H.I.P. and C.H.I.P. Pro officially support the following NAND components:

* 512mb Toshiba SLC NAND: TC58NVG2S0HTA00
* 4gb Toshiba MLC NAND: TC58TEG5DCLTA00
* 4gb Hynix MLC NAND: H27UCG8T2ETR

### Can I add more flash memory by adding raw NAND Components? 

Additional raw NAND components may work, but will most likely require changes to the Buildroot configuration. Additionally, there are two different branches of the Next Thing Co. Linux kernel depending on what type of NAND you have: SLC or MLC.

### Can I boot From an SD Card?

Booting from SD cards or eMMC and are supported on the GR8 processor, but since C.H.I.P. Pro already reserves these data pins for the onboard NAND storage, you would need to create a custom GR8 board with some additional Buildroot configuration settings.

### How can I make a backup of my NAND or eMMC filesystem?

Using **Rsync** is the current recommended way to do this, as it will create a tar file of your root file system while excluding a few system directories. Here is an example of how you would use this command:

```
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*",”/etc/udev/rules.d/*”,"/media/*","/lost+found","/boot/*"} / /tmp/backup && tar -C /tmp/backup -cvzf myBackup.tar.gz .
```

### Why is so much of my file system marked as “read only”?

With GadgetOS the intent was to make an operating system distribution that is as secure as possible when deployed to hundreds of devices all over the world. It was also important to limit the possibility of corrupted data during operations like over-the-air updates or sudden power loss.

Because of this, much of the root file system is set to “read only” to create as stable of a device as possible. 

However, any files under **the “/data” folder have full read/write access**, so you should place any data that needs to be written in this location. 

### Why doesn’t my C.H.I.P. Pro (without the Dev Kit) register as a USB serial device when connected to my computer via the micro USB port?

If you are using GadgetOS, the micro USB port is configured as an ethernet gadget, which you can connect to using a shell application. If you want to use this as a USB serial port, you would need to make this change in the services running on the device and bind Getty to this port.

Alternatively, you can [connect a USB UART cable](https://docs.getchip.com/chip_pro.html#make-a-serial-connection) to C.H.I.P. Pro’s UART1-RX and UART1-TX pins (pins 44 and 43) and communicate with it that way. This is essentially what the micro USB port does on the CHIP Pro Dev Kit.

### How can I trigger an event when a USB device is added or removed?

Using udev rules is the recommended way of doing this, as you can specify a command to run when a device is added or removed. To learn more about udev functionality, please read Oracle’s [documentation](https://docs.oracle.com/cd/E37670_01/E41138/html/ch07s03.html).

### Can I connect an LCD or OLED display to C.H.I.P. Pro?

There is no HDMI, VGA, or composite video connections on C.H.I.P. Pro. However, any small resolution display with a controller board that supports an SPI or I2C interface should work. Additionally, it is also possible to reserve some of the available IO to drive an 8-bit parallel display with additional driver support and configuration.

If you wish to use the GR8 module to make your own board, it is possible to drive higher resolution displays up to 720p resolution by exposing the 8080 interface. There is also a composite video connection (sometimes known as CVBS or RCA) for use with older televisions or monitors. For more information, please consult the [GR8 datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/Datasheets).

## WiFi and Bluetooth

### Why won’t GadgetOS use my settings from /etc/network/interfaces?

Gadget OS uses Connman to manage all network connections, which does not support /etc/network/interfaces and will override any of those settings. Instead, Connman uses its own settings file, which can be found here:

```
/var/lib/connman/*/settings
```

Our [Debian C.H.I.P. Pro image called Pro](http://flash.getchip.com/) uses nmcli for its network management, which does support /etc/network/interfaces. However, if using Gadget OS, this would have to be added to your kernel configuration with some additional settings.

### Why am I getting poor WiFi signal strength and packet loss on my C.H.I.P. Pro?

C.H.l.P. Pro has the ability to use either the on-board ceramic SMT antenna or an external antenna via the onboard Hirose U.FL connector. Which antenna you should use depends on a few different factors (ground planes on the circuit board, location of power source in relation to the antenna connector, etc.)

For example, if you notice poor wifi performance when using the C.H.I.P. Pro Dev Kit, you may want to switch to use the external antenna, even if you don’t have anything physically connected to it.

To enable the external antenna, simply set pin PB17 (Sysfs GPIO pin #49) to HIGH. To enable the on-board SMT antenna, set it to LOW. This process can also be found in the [C.H.I.P. Pro documentation page](https://docs.getchip.com/chip_pro.html#enable-wifi-antenna).

### I built and flashed a custom version of GadgetOS, but my WiFi isn’t working.

It’s possible that you may need to tell GadgetOS to recompile the Realtek WiFi drivers. This can be done with the following command:

```
./scripts/build-gadget make linux-reconfigure uboot-reconfigure rtl8723ds_mp_driver-dirclean rtl8723ds_mp_driver-rebuild rtl8723ds_bt-dirclean rtl8723ds_bt-rebuild all
```

### I’m using Bluez, but can’t find the hcid.conf file.

Bluez removed the ability to store PIN data in config files after version 3 due to security risks. At this time, Next Thing Co only provides official support for Bluez 5.

### I install Bluez and tried to run “bluetoothctl”, but my system appears to have frozen.

Not to worry, your system did not freeze. (You can press Ctrl-C to exit bluetoothctl.) The most likely reason this is happening because you have not yet started the dbus service. You can do this manually by running “bluetoothd” first before running “bluetoothctl”.

### What is the proper way to set Bluetooth’s MTU to reduce power consumption or change signal strength?

The recommended way is to add the Bluez 5.x package and then use tools such as “btgatt-client” and “btgatt-server”. Other utilities such as “hcitool” are deprecated and should no longer be used.

### Bluetooth is not working on C.H.I.P. Pro Debian-based Pro image.

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








