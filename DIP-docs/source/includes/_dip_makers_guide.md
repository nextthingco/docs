# DIP Maker's Guide

This guide provides the resources and instructions for making a Device Tree Overlay (DTO) for your DIP. The DTO provides information at boot-time that can automatically configure your C.H.I.P. with drivers and resources to make your DIP work as expected on startup.

## Getting Started

Install git with `sudo apt-get install git`, then clone the [DIP device tree overlay sources](https://github.com/NextThingCo/CHIP-dt-overlays) onto a Debian/Ubuntu computer or C.H.I.P.:

```
sudo apt-get update && sudo apt-get install git
git clone https://github.com/NextThingCo/CHIP-dt-overlays.git
```

This repository has some very useful directories and files for getting your DIP working with your C.H.I.P.:

  * **samples/** - some basic examples
  * **nextthingco/** - NTC DIP overlay examples
  * **fimware/** - example of a DTS that would compile to DTBO that would load with EEPROM
  * **tools/** - script that generates an eeprom file that can be used to auto-load a DTBO
  * **Makefile** - run `make` to compile your device tree overlays in `/samples` and `/firmware` into device tree blob overlay files.

You will need to make sure you have Linux kernel version 4.4 or later. Read more about this in the [update section](#update-c-h-i-p-to-debian-4-4)


### When do you need a Device Tree Overlay?

The advantage to creating a Device Tree Overlay file is that it will automatically configure C.H.I.P. with the correct settings when C.H.I.P. is booted with the DIP attached. If your DIP merely used the GPIO XIO pins, for example, it would work without any further configuration in the system device tree.

However, most of the pins accessed on the U13 and U14 jumpers represent some protocol for addressing different types of hardware, and how they need to behave usually depends on what hardware they are interacting with. 

These types of hardware usually need a driver. They will need configuration by a Device Tree Overlay to let the system know how to present the hardware to software. The exceptions are devices simple enough to be driven by an application through the GPIO sysfs interface, `/dev/i2c-*` or `/dev/spidev*`. Even devices that work without configuration can be further refined for software when configured with an overlay.

The overlay will generally deal with the the bus used to connect to C.H.I.P. (i2c, 1wire, serial, etc) and the hardware added to that bus. 

The settings needed for the chosen bus will be related to the specifications of the hardware on your DIP and the pins on the [Allwinner R8](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/Allwinner%20R8%20Datasheet%20V1.2.pdf), which are exhaustively documented in the [R8 User Manual](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/Allwinner%20R8%20User%20Manual%20V1.1.pdf)

The settings needed for the overlay for the components on the bus are usually provided in the vendor's documents.

### Bus Protocols
The following protocols can be enabled and configured with Device Tree Overlay files. Each protocol can be configured with a "fragment" in a DTO. Because some of these functions share pins, not all of these can be enabled at once. For example, if SPI2 is enabled, then it would not be possible to enable the CSI interface, since they share pins on U14.

| **Device/Protocol** | **Target name** |
|---|---|
| Two Wire Serial (I2C) | <&i2c0> or <&i2c1> or <&i2c2> |
| Touch Screen | <&rtp> |
| LCD display |  multiple(+)  |
| GPIO | <&pio> |
| GPIO Expander Pins | <&xio>  |
| Pulse Width Modulation (PWM) | <&pwm> |
| Serial Peripheral Interface (SPI) | <&spi2> |
| CMOS (Camera) Sensor Interface (CSI) | no driver yet |
| API Interrupt | <&pio> |

(+) *several device and bus targets are used for an LCD display. See the PocketC.H.I.P. overlay in the DDK repo at nextthingco/dip-pocket.dts*

These protocols are enabled on C.H.I.P. by default. It is extremely unlikely your DIP would benefit from additional configuration with a DTO:

  * One Wire Serial
  * UART Serial
  * Audio I/O
  * Composite Video Output
  * USB OTG
  * USB
  * Bluetooth
  * Wifi
  * USB Power
  * Battery power
  * Low Res Analog Digital Converter (not yet enabled, but will be by default)

## Development by Example

In this section, we'll use a very simple DIP that hosts a button, an LED, and a temperature sensor ([Melexis MLX90614](http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx)) and controls it via I2C on C.H.I.P.'s TWI1 data and clock lines. These correspond to Pins 9 and 11 on [pin header U13](chip.html#pin-headers). The [R8 data sheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP[v1_0]/CHIPv1_0-BOM-Datasheets/Allwinner%20R8%20Datasheet%20V1.2.pdf) refers to these as PB15 and PB16. 

### Make your Add-on Device
In some ways, creating your overlay is interlaced with the process of development. As you prototype your DIP, you'll need to adjust your overlay as you change parts, add components, or test different hardware. 

Fortunately, our example is very basic: the temperature sensor is the only component that requires a device tree overlay, and the driver for that component already exists. Of course, we'll also need to put the EEPROM on it which will be used to identify the device when C.H.I.P. boots.

### Enable devices and components with DTS
Once you have a setup for your DIP, you'll need to create an overlay that will let you test your hardware with software. Here's an overlay that enables i2c1 on C.H.I.P. and configures the temperature sensor. 

The bindings for this sensor can be found in the [devicetree bindings directory](https://github.com/NextThingCo/CHIP-linux/blob/chip/stable/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt):

```shell
/*
 * Peter Nyboer
 * peter@nextthing.co
 * DTO for Melixis MLX90614 IR temperature sensor 3.3V
 * http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
 */

/dts-v1/;
/plugin/;

/ {
	compatible = "nextthing,chip", "allwinner,sun5i-r8";

	/*
	 * Make sure the i2c index is right
	 */
	fragment@0 {
		target-path = "/aliases";

		__overlay__ {
			/* Path to the i2c1 controller node */
			i2c1 = "/soc@01c00000/i2c@01c2b000";
		};
	};

	/*
	 * Device Tree Overlay to enable i2c1 and add an mlx temp sensor
	 */
	fragment@1 {
		target = <&i2c1>; // on U13
		
		__overlay__ {
			//configuration information for Allwinnerdevice protocol target.

			#address-cells = <1>;
			#size-cells = <0>;
			pinctrl-names = "default";
			pinctrl-0 = <&i2c1_pins_a>;
			status = "okay";
			
			
			mlx90614: mlx90614@5a { //using default addr
				compatible = "melexis,mlx90614";
				reg = <0x5a>;
				//wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
			};

		};
	};
};
```

Notice that the `wakeup-gpios` option is commented out - this makes testing simpler since this will not enable any power management features on the MLX90614.

### Make a DTBO - Device Tree Overlay Blob
Think it's right? Now it's time to compile and test it. Unfortunately, the device tree compiler patches needed to support the overlays have not been merged into the [mainline `dtc` code](https://git.kernel.org/cgit/utils/dtc/dtc.git) yet, so you need a patched version of the compiler. Lucky for you, we have a patched version available. The first line installs some dependencies that the `dtc` Makefile depends on.

```shell
sudo apt-get install flex bison
git clone https://github.com/nextthingco/dtc
cd dtc
make
sudo  make install PREFIX=/usr
```

The easy way to compile is to put your .dts file in the "samples/" directory of the `CHIP-dt-overlays` directory, then, from the root of this repository, just run `make`. This produces a .dtbo (device tree blob) file in the "samples/" directory with the .dts file.

The Makefile is designed to look in the "samples/" and "firmware/" directories for .dts files and compile them to .dtbo files using this command:

```shell
dtc -I dts -O dtb -o <output file>.dtbo <input file>.dts -@
```

You may find this useful if you are just want to compile a dts file in-place. More information on the device tree compiler can be found [in the ubuntu manpages site](http://manpages.ubuntu.com/manpages/trusty/man1/dtc.1.html)

### Manually Load your Overlay
Once you have compiled your device tree blob, you will need to add the overlay to the existing device tree. First, make sure configfs is mounted:

```shell
sudo mount -t configfs none /sys/kernel/config
```

then make a place for the overlay and catenate your blob:

```shell
sudo mkdir -p /sys/kernel/config/device-tree/overlays/DIPexample
su -c 'cat irtempi2c.dtbo > /sys/kernel/config/device-tree/overlays/DIPexample/dtbo'
```

If you want to remove it later on, simply remove the directory you
created:

```
sudo rmdir /sys/kernel/config/device-tree/overlays/DIPexample/
```

### Confirm Overlay Loaded
Before you started this procedure, you would have seen two i2c devices where `ls /dev/i2c*` would output `/dev/i2c-0  /dev/i2c-2`. After the overlay is applied, the output from that `ls` will show the new i2c device: `/dev/i2c-0  /dev/i2c-1  /dev/i2c-2`

If you want to find the device in sysfs, you can `ls /sys/bus/i2c/devices/` and see a device `1-005a`. The "1" refers to the new i2c bus `i2c-1` and "005a" refers to the address of the device ("reg" in the dts file). (You'll also see 0-0034 and 2-0038 which are the AXP209 power management and the GPIO expander for the XIO pins that are connected to i2c0 and i2c2, respectively). You can probe even deeper with `ls /sys/bus/i2c/devices/1-005a` to see what is exposed to the system for the IR temperature sensor.

You can also use `sudo i2cdetect -y 1` to see a table of all devices on i2c-1. That command will probe the i2c-1 bus for devices and see if any replies.

Overlays that have been manually loaded like this will not be available on reboot. You will need to [load the overlay](#manually-load-your-overlay) again if you reboot.

### Test board and iterate
Now that C.H.I.P. knows about the new devices, it's time to start programming and controlling the elements on the DIP.

## Make it a DIP
Once you have a final product, you can place the EEPROM chip on the 1wire bus, and flash the EEPROM to make C.H.I.P. automatically configure for your DIP. The EEPROM is the secret sauce that turns a "PCB with some stuff on it" into a flavorful DIP that pairs perfectly with your C.H.I.P.

### Flash EEPROM
With your finished board, you are now ready to flash the EEPROM with your unique data. The "tools/" directory in the DDK has a simple python script that can be used to generate a file that can be written to the hardware. 

Let's make up some values that you'll need to write to the EEPROM. 

  * vendor ID (vid) = 0x16 (22) [32 bit]
  * product ID (pid) = 0x44 (68) [16 bit]
  * vendor = RadCo [32 characters]
  * product = SuperT [32 characters]
  * product-version = 1 [8 bit]

From the "tools/" directory, run 

```shell
python dip-header-generator.py SuperTEEPROM.img --vid 22 --pid 68 --vendor 'RadCo' --product 'SuperT' --product-version 1
```

to generate an EEPROM file "SuperTEEPROM.img".


You'll find the EEPROM device in the sysfs file system:

```shell
ls /sys/bus/w1/devices/2*/eeprom
```

Once you know the UUID (name) of the directory (e.g. "2d-0000132785ea/"), you can write the data to the eeprom with:

```shell
su -c 'cat SuperTEEPROM.img > /sys/bus/w1/devices/2d-(UUID)/eeprom'
```

### Verify EEPROM
For personal assurances, you may want to verify that the EEPROM has the correct data on it. Use this command to print the data in (hexadecimal format) to your terminal:

```shell
cat /sys/bus/w1/devices/2*/eeprom |hexdump -C
```

You can also use a lowercase `-c` option to print the data in character format, which is useful for viewing the vendor strings. 

### Boot with DIP in place (read EEPROM)
Now that you have a functioning device tree blob and EEPROM populated with data unique to your product, you'll need to name your blob with a special name using your (hex) vendor ID and product id:

```shell
dip-16-44.dtbo
```

then

```shell
sudo mkdir -p /lib/firmware/nextthingco/chip && sudo cp dip-16-44.dtbo /lib/firmware/nextthingco/chip
```

to put it in `/lib/firmware/nextthingco/chip/` to ensure the overlay is loaded on EEPROM detection.

You may also need to make sure that the w1_ds2431 module loads on boot so the EEPROM module can be found and read. You simply need to modify the configuration file with a text editor `sudo nano /etc/modules.d/modules.conf` and add this line to the end: `w1_ds2431`

### Use DIP with software
Now you are ready to use your DIP with software. How you control your DIP with C.H.I.P. is really up to you. This procedure simply makes the DIP's parts available to the operating system for further control. 

# The Device Tree Overlay format
A template for a basic DTO:

```shell
/*
 * Copyright or left statement
 * Author name(s) and and contact
 * License Information
 */

/dts-v1/;
/plugin/;

/ {
	compatible = "nextthing,chip", "allwinner,sun5i-r8";

	/*
	 * Fragment description
	 */
	fragment@1 {
		target = <targetname>; // example: <&spi2>
		
		__overlay__ {
			//configuration information for Allwinner device target.
			
			controller: controller@0{
				//optional controller configuration and bindings to the hardware C.H.I.P. talks to on the DIP, usually needed for bu
			}; 
		};
	};
};
```

The device tree is composed of nodes, where each node configures a device that Linux must relate to a driver and know what interface to present to the system.

The top of the "__overlay__" node describes settings that are relevant to the C.H.I.P.'s target device, such as `<&i2c1>`, `<&spi2>`, `<&pwm>`. Example settings and documentation for these take some detective work in the C.H.I.P.-linux repo, for example device trees for [sun5i](https://github.com/NextThingCo/CHIP-linux/blob/nextthing/4.4/next/arch/arm/boot/dts/sun5i.dtsi) and [sun5i-r8](https://github.com/NextThingCo/CHIP-linux/blob/nextthing/4.4/next/arch/arm/boot/dts/sun5i-r8-chip.dts)

Documentation for the settings that will go in the controller sub-node depends on the device and what is built on the DIP. Much of this type of information can be found in the [bindings directory](https://github.com/NextThingCo/CHIP-linux/tree/chip/stable/Documentation/devicetree/bindings/) of the C.H.I.P.-linux repo. You may also need to refer to the hardware's data sheet to get some data for the node.

We realize this is fairly unspecific instruction; given the number of mainline Linux driver, devices and possible combinations, it's difficult to provide much more than *guidance*.

You may find these resources for other hardware useful:
  * [Beagle Bone Black](https://learn.adafruit.com/introduction-to-the-beaglebone-black-device-tree/device-tree-overlays)
  * [Raspberry Pi](https://www.raspberrypi.org/documentation/configuration/device-tree.md)

# The Device Tree and U-Boot

Some DIPs require the device tree to load with U-Boot, in order to make the devices available earlier in the startup process. The VGA, HDMI, and PocketC.H.I.P. overlay blobs are three examples of DIPs that require this behavior, because the display needs to be known to C.H.I.P. as early as possible. This requires a different overlay loading procedure, which is definitely the exception rather than the norm.

## Modify U-Boot
Connect C.H.I.P. to a monitor or use a USB UART cable so you can stop C.H.I.P. from fully booting. Hit any key in the first 2 seconds, then type these commands:

```shell
setenv dip_addr_r 0x43400000
setenv dip_overlay_dir /lib/firmware/nexttching/chip/early/
setenv dip_overlay_cmd 'ubifsload $dip_addr_r $dip_overlay_dir/$dip_overlay_name'
```

This process will soon be unneeded, as these commands will be rolled into U-Boot.
