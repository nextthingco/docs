# Connect and Control

C.H.I.P. Pro is a headless computer, so you will need a separate computer in order to interact with it. This section will go over how to connect to C.H.I.P. Pro Dev Kit through USB-serial, connect to a WiFI network and where to find example scripts on Buildroot.

## USB-Serial UART1 Connection

This is the first thing you want to do in order to get your board online and give you access to C.H.I.P. Pro's software. The Dev Kit has a built-in USB to Serial converter for a direct connection to UART1. 

![image page](images/usb0.jpg)

To get started, connect the Dev Kit's USB0 port (**not on the C.H.I.P. Pro!**) to your computer with a common USB A to Micro-USB B cable. Next, you will need terminal emulation software on the computer C.H.I.P. Pro Dev Kit is connected to. Find the OS you are using below to see what software is needed and how to connect.

### OS X & Linux

Mac systems and most flavors of Linux come with the terminal emulator software Screen. If your Linux distro does not come with Screen and uses Apt install using apt-get:

```
sudo apt-get install screen
```

With the Dev Kit connected to your computer, open a terminal window. Find out the tty.usbserial dev path the Dev Kit is attached to: 

**Mac**

```
ls /dev/tty.*
```
It will look something like `usbserial-DN02ACBB`. 

**Linux** 

```
ls /dev/ttyUSB*
```

The port name is usually `ttyUSB0`.

#### Connect 

Use Screen to create a serial terminal connection at 115200 bps:

**Mac**

```
screen /dev/tty.usbserialxxxxxxxx 115200
```
**Linux**

```
screen /dev/ttyUSB0 115200
```

Once a terminal window pops up, hit the Enter key twice. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.

#### Exit Screen

When done with Screen, press Ctrl+A then Ctrl+k to kill all windows and terminate Screen. 

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

This will return you to the previous screen session. Then use Ctrl+A Ctrl+K to close it (will ask you to confirm).


### Windows

Download the [PuTTY terminal emulator](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

In Windows, open the **Device Manager**. Find and expand **Ports (COM & LPT)**. Find the port labeled **USB Serial Port (COMx)** and take note of the COMx port number. This is the port that the C.H.I.P. Pro Dev Kit is connected to.

In PuTTY choose **Serial** as the **Connection type**. Plug the following items in and click **Open**. 

* COMx number as the **Serial Line**  
* 115200 as the **Speed** (baud rate)

[![Com Port](images/ComPort.PNG)] (images/ComPort.PNG) | [![puTTY](images/puTTYsetM.jpg)] (images/puTTYsetM.jpg) | 
|:---:|:---:|
| In Device Manager find COM port # | Plug port # and baud rate into puTTY | 

Once a terminal window pops up, press Enter. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.

## Edit Buildroot Examples

After connecting to the Dev Kit via [USB-serial](https://docs.getchip.com/chip_pro_devkit#usb-serial-uart1-connection) you can check out and edit the scripts for each Buildroot example. Use the Vi command-line editor to read and edit example scripts found in ```/usr/bin```. 

**Blinkenlights**

```
vi /usr/bin/blink-leds
vi /usr/bin/fade-pwms
```

**VU-Meter**

```
vi /usr/bin/vu-meter
```


### Basic Vi Editor Commands

To **edit text** take Vi from command mode (default) to insert mode. Press the following keys to edit text.

* i - go into insert mode (to edit text)
* Esc - exit insert mode

Vi was built for Qwerty keyboards without arrow keys. They may work but if not, use these keys to **move cursor**:

* J - move down one line
* K - move up one line
* H - move left one character
* L - move right one character

Other helpful commands:

* u - undo last action
* :x then Enter - save and exit
* :q! then Enter - exit without saving

## WiFi Antenna
C.H.I.P. Pro has an onboard ceramic antenna that is intended for debugging purposes only. We recommend the use of an external antenna for all product applications. 

### Connect Antenna
C.H.I.P. Pro uses a standard 50Ω IPEX (Hirose U.FL compatible) connector for the external antenna path.

To connect an antenna, come straight from the top and push the antenna onto the connector. Keep in mind the connector will wear out over time. We suggest keeping the disconnect/connect cycle down to 10 or less. 

[![wifi antenna connector](images/wifiConnectB.jpg)] (images/wifiConnectB.jpg) | [![push antenna on](images/wifiPush.jpg)] (images/wifiPush.jpg) | 
|:---:|:---:|
| WiFi antenna connector | Push antenna onto connector |

![wifi antenna connected](images/wifiOn.jpg)

### Enable Wifi Antenna
In order to use it, you need to set the path of the external antenna.

**Buildroot**

With the Buildroot C.H.I.P. Pro images comes a [set_antenna script](https://raw.githubusercontent.com/NextThingCo/CHIP-buildroot/34a8cfdab2bbecd6741c435d6c400e46848436f1/package/rtl8723ds_mp_driver/set_antenna) which accepts two arguments of either `pcb` or `ufl` depending on which you want enable. 

```
sh set_antenna pcb|ufl
``` 

**Debian**

In Debian, there are two ways to set the antenna path:

* The RF switch is connected to logic pin PB17. Manually set the logic states to choose either the onboard or external antenna.

0 = onboard-antenna 

1 = external-antenna


* `wget` set_antenna script found [here](https://raw.githubusercontent.com/NextThingCo/CHIP-buildroot/34a8cfdab2bbecd6741c435d6c400e46848436f1/package/rtl8723ds_mp_driver/set_antenna). Run and pass either the `pcb` or `ufl` argument, as stating above.  

## WiFi Setup: Buildroot

The Buildroot operating system uses the ConnMan command-line network manager to connect and manage your network connections. 

**Requirements**

  * C.H.I.P. Pro running buildroot OS
  * [Serial connection](https://docs.getchip.com/chip_pro_devkit.html#usb-serial-uart1-connection) to C.H.I.P. Pro
    
### Step 1: Enable WiFi and Find a Network

These three commands will in turn, enable wifi, scan for access points, and list what networks are available:

```shell
connmanctl enable wifi
connmanctl scan wifi
connmanctl services
```

The `services` command has output similar to:

```shell
WaffleHouse          wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
                	 wifi_xxxxxxxxxxxx_hidden_managed_psk
YOUR_NETWORK         wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
    				 wifi_xxxxxxxxxxxx_xxxxxx_managed_none
Donut_Hut            wifi_xxxxxxxxxxxx_xxxxxxxxx_managed_psk
```

### Step 2: Connect 

Copy the string that starts with "wifi_' to the right of the network name you want to connect to. If it has `psk` at the end, that means it is password protected (short for Wi-Fi Protected Access 2 - Pre-Shared Key) and you need to scroll further down to the " Password Protected" section.

#### No Password

For example, to connect to NTC Guest, which has no password, `services` shows two choices. We want the one without `psk` in the string. Use the `connect` command:

```shell
connmanctl connect wifi_xxxxxxxxxxxx_xxxxxx_managed_none
```

If your network is not password protected, you'll get some output that will indicate a successful connection, such as:

```shell
[  961.780000] RTL871X: rtw_set_802_11_connect(wlan0)  fw_state=0x00000008
[  962.070000] RTL871X: start auth
[  962.080000] RTL871X: auth success, start assoc
[  962.090000] RTL871X: rtw_cfg80211_indicate_connect(wlan0) BSS not found !!
[  962.100000] RTL871X: assoc success
[  962.110000] RTL871X: send eapol packet
[  962.290000] RTL871X: send eapol packet
[  962.300000] RTL871X: set pairwise key camid:4, addr:xx:xx:xx:xx:xx:xx, kid:0, type:AES
[  962.320000] RTL871X: set group key camid:5, addr:xx:xx:xx:xx:xx:xx, kid:1, type:AES
```

If your network is password protected you'll get an error.

#### Password-Protected
To deal with passwords you'll need to put ConnMan into interactive mode:

```shell
connmanctl
```

This command gives a `connmanctl` prompt:

```shell
connmanctl>
```

In the shell, turn the agent on so it can process password requests:

```shell
  agent on
```

Now use the `connect` command with your pasted wifi network string:

```shell
  connect wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Enter your password when prompted:

```shell
  Agent RequestInput wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
  Passphrase?
```

You will be notified that you are connected:

```shell
  Connected wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Exit connmanctl interactive mode:

```shell
  quit
```

### Step 3: Test Connection

Finally, you can test your connection to the internet with `ping`. Google's DNS server at the IP address 8.8.8.8 is probably the most reliable computer on the internet, so:

```shell
ping -c 4 8.8.8.8
```

Expect ping to output some timing messages:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=60 time=7.631 ms
64 bytes from 8.8.8.8: seq=1 ttl=60 time=7.474 ms
64 bytes from 8.8.8.8: seq=2 ttl=60 time=7.697 ms
64 bytes from 8.8.8.8: seq=3 ttl=60 time=9.004 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 7.474/7.951/9.004 ms
```
The `-c 4` option means it will happen only 4 times.

&#10024; **Congratulations! You are now Connected to a Network** &#10024;

If your connection is not successful, then ping will tell you your network is down:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
ping: sendto: Network is unreachable
```

#### Troubleshooting Connection Problems

* Review any messages that the connect command gave you. Did they look like the examples of a successful connection?

* Double check that you used the right network with the `connect` command.

* If everything checked out until you got to `ping`, there's a good chance the problem is with your router or connection to the internet. Some networks have firewalls on them that will allow you to connect but prevent foreign devices from transferring information. 

* Connman not Installed Error

	If you try to use ConnMan and you get an error that it is not found or is not a 	command, chances are that you are using the Debian image. The ConnMan commands only apply to C.H.I.P. Pros running the Buildroot OS.

### Disconnect from Network with Connman
To disconnect from your network, you might first want a reminder of the unfriendly string used to describe your access point:

```shell
connmanctl services
```

This command will output information about your current connection:

```shell
YOUR_NETWORK         wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Copy and paste the string ID along with the `disconnect` command:

```shell
connmanctl disconnect wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

You will be notified when it has disconnected: 

```shell
Disconnected wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

### Forget Network with Connman
Generally, ConnMan will remember and cache setup information. This means that if you reboot in the vicinity of a known network, it will attempt to connect. However, if you need to forget a network setup, navigate to:

```shell
cd /var/lib/connman/
```

You can delete a single connection by seeing which are stored and copying the one you want to delete:

```shell
/var/lib/connman # ls
settings
wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
wifi_xxxxxxxxxxxx_xxxxxx_managed_none
```

Then delete that connection:

```shell
rm -r wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

You can delete all the “wifi” connections with:

```shell
rm -r wifi*
```
The `-r` is needed because these are directories you are deleting and the star at the end of `wifi*` assumes your connection IDs all start with the string “wifi”.

## WiFi Setup: Debian

If you are using the Debian OS you will find that ConnMan is not installed, you will need to use Networking/CLI or the command `nmcli` instead. 

**Requirements**

  * C.H.I.P. Pro loaded with Debian
  * [Serial connection](https://docs.getchip.com/chip_pro.html#usb-serial-uart1-connection) to C.H.I.P. Pro

### Step 1: List available Wi-Fi networks
In terminal type:

```shell
nmcli device wifi list
```

The output will list available access points:

```shell
*  SSID      MODE   CHAN  RATE       SIGNAL  BARS  SECURITY
*  YOUR_NETWORK    Infra  11    54 Mbit/s  100     ▂▄▆█  --
   CatCafe         Infra  6     54 Mbit/s  30      ▂___  WPA1 WPA2
   2WIRE533        Infra  10    54 Mbit/s  44      ▂▄__  WPA1 WPA2
```
### Step 2: Connect 

You can connect to password protected or open access points.

#### No Password
To connect to an open network with no password:

```shell
sudo nmcli device wifi connect "YOUR_NETWORK_SSID" ifname wlan0
```
These commands will respond with information about the connection. A successful connection looks like:

```shell
Connection with UUID 'xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy' created and activated on device 'wlan0'
```

#### Password Protected

To connect to a password protected network, use this command inserting your own network name and password:

```shell
sudo nmcli device wifi connect "YOUR_NETWORK_SSID" password "UR_NETWORK_PASSWORD" ifname wlan0
```

These commands will respond with information about the connection. A successful connection looks like:

```shell
Connection with UUID 'xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy' created and activated on device 'wlan0'
```
#### Hidden SSID and Password Protected

To connect to a hidden and password-protected network:
 
 ```shell
sudo nmcli device wifi connect "YOUR_NETWORK_SSID" password "UR_NETWORK_PASSWORD" ifname wlan0 hidden yes
```

### Step 3: Test your Connection

You can verify and test your wireless network connection.

#### Verify

```shell
nmcli device status
```

This outputs a list of the various network devices and their connections. For example, a successful connection would look like this:

```shell
DEVICE   TYPE      STATE         CONNECTION
wlan0    wifi      connected     YOUR_NETWORK
wlan1    wifi      disconnected  --
ip6tnl0  ip6tnl    unmanaged     --
lo       loopback  unmanaged     --
sit0     sit       unmanaged     --
```

Because it is worth knowing that Linux offers many ways of doing things, another command that shows your current active connection is:

```shell
nmcli connection show --active
```

Which outputs:

```shell
NAME  		   UUID                                  TYPE             DEVICE
YOUR_NETWORK   xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy  802-11-wireless  wlan0
```

After you have connected once, C.H.I.P. Pro will automatically connect to this network next time you reboot (or start NetworkManager services).

#### Test
Finally, you can test your connection to the internet with `ping`. Google's DNS server at the IP address 8.8.8.8 is probably the most reliable computer on the internet, so:

```shell
ping -c 4 8.8.8.8
```

Expect ping to output some timing messages:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=60 time=7.631 ms
64 bytes from 8.8.8.8: seq=1 ttl=60 time=7.474 ms
64 bytes from 8.8.8.8: seq=2 ttl=60 time=7.697 ms
64 bytes from 8.8.8.8: seq=3 ttl=60 time=9.004 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 7.474/7.951/9.004 ms
```
The `-c 4` option means it will happen only 4 times.

&#10024; **Congratulations! You are now Connected to a Network** &#10024;

If your connection is not successful, then ping will tell you your network is down:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
ping: sendto: Network is unreachable
```

### Disconnect Network with Nmcli

Disconnect from the wireless device:

```shell
sudo nmcli dev disconnect wlan0
```

### Forget Network with Nmcli
You may want to prevent auto-connection to a network. If so, you want the device to forget the a specific network. First, list the connections:

```shell
nmcli c
```

Which outputs something like:

```shell
NAME           UUID                                  TYPE             DEVICE 
YOUR_NETWORK   xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy  802-11-wireless  wlan0
```

Then delete the network specified between quotes to forget it:

```shell
sudo nmcli connection delete id "YOUR_NETWORK"
```

### Troubleshooting Connection Problems

* No Network Found

No network within range. If there's no network, you can't connect. Go find a network!

* Incorrect Password

If you type in the wrong password, you'll get some errors like this:

```shell
[32258.690000] RTL871X: rtw_set_802_11_connect(wlan0) fw_state=0x00000008
[32258.800000] RTL871X: start auth
[32263.720000] RTL871X: rtw_set_802_11_connect(wlan0) fw_state=0x00000008
[32263.820000] RTL871X: start auth
[32264.430000] RTL871X: auth success, start assoc
[32269.850000] RTL871X: rtw_set_802_11_connect(wlan0) fw_state=0x00000008
[32269.970000] RTL871X: start auth
Error: Timeout 90 sec expired.
```

Try connecting again with the correct password.

* Failed Ping

If you don't have access to the internet, your ping to an outside IP will fail.
It is possible that you can connect to a wireless network, but have no access to the internet, so you'd see a connection when you request device status, but have a failed ping. This indicates a problem or restriction with the router or the access point.

A failed ping looks something like:

```shell
From 192.133.2.10 icmp_seq=14 Destination Host Unreachable
From 192.133.2.10 icmp_seq=15 Destination Host Unreachable
From 192.133.2.10 icmp_seq=16 Destination Host Unreachable
18 packets transmitted, 0 received, +9 errors, 100% packet loss, time 17013ms
pipe 4
```
Change the router or access point permissions to allow a foreign board to connect to it. Alternatively, a personal mobile hotspot can obtained and used if you are in a work environment that can not change its network security settings.

* Loss of Wireless Network

A sudden, unplanned disconnection will post an error in the terminal window:

```shell
[30863.880000] RTL871X: linked_status_chk(wlan0) disconnect or roaming
```

The Network Manager will periodically try to reconnect. If the access point is restored, you'll get something like this in your terminal window:

```shell
[31798.970000] RTL871X: rtw_set_802_11_connect(wlan0)
[31799.030000] RTL871X: start auth
[31799.040000] RTL871X: auth success, start assoc
[31799.050000] RTL871X: rtw_cfg80211_indicate_connect(wlan0) BSS not found !!
[31799.060000] RTL871X: assoc success
```

* Nmcli not Installed Error 

If you try to use `nmcli` and you get an error that it is not found or is not a command, chances are that you are using a C.H.I.P. Pro Buildroot image. The `nmcli` commands only apply to C.H.I.P. Pro using Debian linux. 

## SSH 

Once you connect to an network you can ssh into the C.H.I.P. Pro in order to program and control it. Our **Debian example comes with ssh servers**, our **Buildroot examples do not**. If you want to ssh while using Buildroot you will need to do a manual build. 


### Find IP

```
ip addr
``` 
The IP is on `wlan0` or sometimes on `wlan1`.

### Connect

```
ssh root@<CHIPproIP>
```

## Audio

The C.H.I.P. Pro Development Kit has several ways to access audio in and out. Stereo audio in and out is handled by a 24-bit DAC built-in to the GR8 processor. There are also digital options that you can use, but require configuration of the Linux kernel and additional hardware to access.

* Audio output via 3.5mm TRRS jack
* Mono input via 3.5mm TRRS jack
* Stereo microphones
* MIC1 and MIC2 header pins
* I2S digital audio
* SPIDIF digital audio

### Input
There are two (2) analog MEMS (micro electro mechanical) microphones on the Dev board. These are enabled by default. 

If you want to use the MIC1 and MIC2 pins for audio input, you'll need to [cut a trace](#back-traces).

The "Sleeve" (bottom-most ring) on the TRRS jack can be used as a mono audio input, suitable for microphones commonly built-in to headphones. If you want to used this connector, you'll need to [cut a trace](#back-traces).

### Output

The 3.5mm TRRS jack provides stereo output suitable for headphones or amplification to stereo speakers.

## USB Accessories

The USB1 port can be used to connect and use popular accessories like storage, MIDI controllers, keyboards, pointing devices, audio hardware, and more. C.H.I.P. Pro does not provide power to the USB1 port on its own, so the Development Kit is a good example of how this works. 

**USB1 Power**

USB1 is provided with 5V from pass-through of the 5V supplied to the USB0+UART micro USB port on the devkit pcb 

**For high-load devices** attached to USB1, make sure an adequate power supply is provided. For example, when you plug in a keyboard and an optical mouse, they will draw too much current from the C.H.I.P. Pro Dev Kit, not leaving enough for the processor. As a result, C.H.I.P. Pro will immediately shut down. There are a few ways to avoid this.

* Use a powered USB hub
* Use a bluetooth keyboard and mouse. Yes, this is a very specific solution, but a good one when you are only using the USB port for keyboard and mouse. Keeps your desk cleaner too!
* Execute the command `sudo axp209 --no-limit` in the terminal before you attach your USB peripherals.
* Provide power from a supply connecting ground and 4.8V to 6V to the CHG-IN , pin 4.

## GPIO	

C.H.I.P. Pro has a total of 28 GPIO pins ready for use:

* 2 PWM
	* pins 9 & 10
* 3 input
	* pins 39 - 41
* 22 input/output
	* pins 11-16, 21-25, 30-38, 43 & 44
* 1 LRADC
	* pin 42

To see all the functions C.H.I.P. Pro pins offer check out the [Multiplexing table](https://docs.getchip.com/chip_pro.html#gr8-pins-and-multiplexing-on-c-h-i-p-pro).

![pin out](images/Pro_Pinout.jpg)

### Interacting with Sysfs**

The Linux kernel provides a simple [sysfs interface](https://www.kernel.org/doc/Documentation/gpio/sysfs.txt) to access GPIO from. Depending on the image flashed to C.H.I.P. Pro, the commands used to interact with the sysfs interface will differ. If using the **Pro** image, you need to act as root and use `sudo sh -c` with quotes around the command string. For example:

**Pro** 

```shell
sudo sh -c 'echo 132 > /sys/class/gpio/export' 
```

**Buildroot**:

```shell
echo 132 > /sys/class/gpio/export 
```

Follow along with the examples to learn more about sysfs including how to directly read and write to sysfs. ** All examples in the GPIO documentation are done using one of NTC's **Buildroot** based images. 

#### Get GPIO Sysfs File Name

To address a GPIO port via sysfs, you do not use the C.H.I.P. Pro or GR8 pin name. Sysfs sees the pins as another set of numbers. To find out what number to use for each GPIO pin reference the table below. 

**Sysfs Pin Names**

D0 - D7:

| C.H.I.P. Pro Pin # | 37 | 36 | 35 | 34 | 33 | 32 | 31 | 30 | 
|------------|-----|-----|-----|-----|-----|-----|------|------|
| sysfs #    | 132 | 133 | 134 | 135 | 136 | 137 | 138  | 139  |

TWI1, UART2:

| C.H.I.P. Pro Pin # | 11 | 12 | 13 | 14 | 15 | 16 |  
|------------|-----|-----|-----|-----|-----|-----|
| sysfs #    | 47 | 48 | 98 | 99 | 100 | 101 | 

I2S:

| C.H.I.P. Pro Pin # | 21 | 22 | 23 | 24 | 25 |   
|------------|-----|-----|-----|-----|-----|
| sysfs #    | 37 | 38 | 39 | 40 | 41 |

SPI2:

| C.H.I.P. Pro Pin # | 41 | 40 | 39 | 38 |   
|------------|-----|-----|-----|-----|
| sysfs #    | 128 | 129 | 130 | 131 | 

| C.H.I.P. Pro Pin # | 9 | 10 | 
|------------|-----|-----|
| sysfs #    | 0 | 1 | 

UART1:
** These pins are being used thus not available while connected to the C.H.I.P. Pro Dev board via USB-serial. You can disconnect the micro USB port on the Dev board from the UART1 pins by cutting a [couple traces](https://docs.getchip.com/chip_pro_devkit.html#cuttable-traces). 

| C.H.I.P. Pro Pin # | 44 | 43 | 
|------------|-----|-----|
| sysfs #    | 195 | 196 | 

**Calculate sysfs Number**

If a pin is not listed above you can calculate the sysfs number starting with the GR8 port number. All port numbers are printed on C.H.I.P. Pro for your convenience. They can also be found in the [Allwinner R8 Datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Datasheets/GR8_Datasheet_v1.0.pdf) starting on page 15. 

As an example, take a look at **D0** which is port **PE4**. Look at the letter that follows the "P", in this case it's "E". Starting with A = 0, count up in the alphabet until you arrive at "E" and that is the letter index. For example, **E=4**.

Multiply the letter index by 32, then add the number that follows "PE":

(4*32)+4 = 132

### Export Digital GPIOs

The GPIO control interface can be found at `/sys/class/gpio`. To explore the sysfs file structure, connect to C.H.I.P. Pro via [USB-serial](https://docs.getchip.com/chip_pro_devkit.html#usb-serial-uart1-connection) and in a terminal window type: 

```
ls /sys/class/gpio
```  
In the **gpio** directory you will find:

* **export** - Exports a GPIO signal to read and write to. 
* **unexport** - Reverses the effect of exporting. 

As an example, use the sysfs number **132** to export pin **PE4**:

```shell
echo 132 > /sys/class/gpio/export
```

Once exported, a GPIO signal will have a path like `/sys/class/gpio/gpioN` where N is the sysfs number. Once a pin is exported, look in the **gpioN** directory to see what attributes are available to read and write:

```shell
ls /sys/class/gpio/export/gpio132 
```
These are the main attributes you will work with: 

* **direction** - Set direction of pin using "in" or out". All GPIOs are I/Os except for PE0, PE1 and PE2 which are input only.
* **value** - Value of pin written or read as either 0 (low) or 1 (high).
* **edge** - Written or read as either "non", "rising", "falling", or "both". This attribute only shows up when the pin can be configurred as an interrupt.
* **active_low** - Reads as either 0 (false) or 1 (true). Write any nonzero value to invert the value attribute both for reading and writing.

Learn more about the sysfs interface [here](https://www.kernel.org/doc/Documentation/gpio/sysfs.txt).

### Digital Input

The following example goes through a general command sequence to read a changing state of a pin. This example reads a switch connected to **PE4**. When wiring up a switch, add an external pull-up or pull-down resistor to prevent a floating pin logic state. The photo below shows a pull-down resistor.

![pull-down resistor](images/pullDown.jpg)

In terminal, tell the system you want to listen to a pin by exporting it:

```shell
echo 132 > /sys/class/gpio/export
```

Next, the pin direction needs to be set. Use `cat` to read what direction the pin is currently set to:

```shell
cat /sys/class/gpio/gpio132/direction
```

Switch the pin's direction to "in":

```shell
echo in > /sys/class/gpio/gpio132/direction
```

Connect a switch between pin PE4 and GND and read the value:

```shell
cat /sys/class/gpio/gpio132/value
```

Continuously check the value of the switch pin for its state change:

```shell
while ( true ); do cat /sys/class/gpio/gpio132/value; sleep 1; done;
```

### Digital Output

**Onboard LEDs**

The Dev board provides ten onboard LEDs to make testing the GPIOs easy without having to wire anything up. Eight of these LEDs are connected to digital I/O pins that can be turned on and off with standard Linux sysfs commands. 

* Pins CSIDO - CSID7 which are seen as 132 - 139 in sysfs.

**Blinkenlights Image**

To start with an example that demos the eight I/Os and two PWM onboard LEDs [flash C.H.I.P. Pro Dev Kit with our Blinkenlights](https://docs.getchip.com/chip_pro_devkit.html#examples) image and [view the example scripts](https://docs.getchip.com/chip_pro_devkit.html#edit-buildroot-examples) using the command-line editor Vi. 

**Turn LED On and Off**

Follow along to turn on and off the LED attached to PE4.

![UART connection](images/blink.gif)

Export the pin and change the mode from "in” to “out”:

```shell
echo 132 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio132/direction
```

Now that it's in output mode, you can write a value to the pin and turn the LED on and off:

```shell
echo 1 > /sys/class/gpio/gpio132/value
echo 0 > /sys/class/gpio/gpio132/value
```


#### Blink 
Blink an LED on pin PE4(132).

``` shell
while ( true ); do echo 1 > /sys/class/gpio/gpio132/value; cat /sys/class/gpio/gpio132/value; sleep 1; echo 0 >  /sys/class/gpio/gpio132/value; cat /sys/class/gpio/gpio132/value; sleep 1; done;
```


### Unexport GPIO 

When you are done using any GPIO pin always tell the system to stop listening by unexporting it:

```shell
echo 132 > /sys/class/gpio/unexport
```

If pins have not been unexported the pins will be "busy" the next time you go to export them. 

## PWM 

C.H.I.P. Pro can output a PWM signal up to 24 MHz on two pins: PWM0 and PWM1. The Dev Kit also features two places to connect servos to that provide the power needed to drive them. 

### PWM via sysfs

Our Linux kernel provides a simple **sysfs** interface to access PWM from. The PWM controller can be found exported as **pwmchip0** at `/sys/class/pwm/pwmchip0`. To test the PWM channels and explore the sysfs file structure, connect to C.H.I.P. Pro via [USB-serial](https://docs.getchip.com/chip_pro_devkit.html#usb-serial-uart1-connection) and in a terminal window type: 

```
ls /sys/class/pwm/pwmchip0
```  
In the **pwmchip0** directory you will find:

* **export** - Exports a PWM channel for use. 
* **unexport** - Unexports PWM channel from sysfs (always do this after you are done using a channel).
* **npwm** - Says how many PWM channels are available. 

You can see there are two PWM channels available from C.H.I.P. Pro's PWM controller/chip by using `cat`:

```
cd /sys/class/pwm/pwmchip0
cat npwm
```    

#### Export PWM Channels

Before you can use a channel it needs to be exported. Use these numbers to reference which pin you would like to export:

* 0 = PWM0
* 1 = PWM1

Depending on the image that is flashed to C.H.I.P. Pro, the commands used to interact with the sysfs interface will differ. If using a **Pro** image, you need to act as root and use `sudo sh -c` with quotes around the command string. For example:

**Pro**

```shell
sudo sh -c 'echo 0 > export' #PWM0
sudo sh -c 'echo 1 > export' #PWM1
ls
```

**Buildroot**:

```shell
echo 0 > export #PWM0
echo 1 > export #PWM1
ls
```

** All PWM examples are written for the **Buildroot image**.

After exporting, you will find that a new directory **pwmX**, where X is the channel number, has been created. Go into the pwmX directory to check out the attributes available for use:

```shell
cd pwm0 
ls
```

In the pwmX directory you will find: 

* **duty_cycle** - The active time of the PWM signal in nanoseconds. Must be less than the **period**.
* **enable** - Enable/disable the PWM signal using either 0 or 1.

	0 - disabled
	
	1 - enabled
* **period** - Total period of inactive and active time of the PWM signal in nanoseconds.
* **polarity** - Changes the polarity of the PWM signal. Value is "normal" or "inversed".

To test the PWM channels follow the examples below.

### PWM LEDs

There are two onboard LEDs connected to the PWM pins for testing and learning about pulse width modulation. If you need to disconnect these PWM LEDs that can be done at any time by [cutting traces](https://docs.getchip.com/chip_pro_devkit.html#cuttable-traces) on the back. 

![PWM0 LED fade](images/fade.gif)

Export a channel, set the polarity and enable PWM0:

```shell
echo 0 > /sys/class/pwm/pwmchip0/export
echo "normal" > /sys/class/pwm/pwmchip0/pwm0/polarity
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
```

Set the period to 10000000 nanoseconds (1 second) and the duty cycle to 0:

```shell
echo 10000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
```
From here, set the duty_cycle in nanoseconds. Start dim at 1% and step up to the 100%:

```shell
echo 100000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 500000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 5000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 10000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
```

Disable and unexport:

```shell
echo 0 > /sys/class/pwm/pwmchip0/enable
echo 0 > /sys/class/pwm/pwmchip0/unexport
```

### PWM Servo 

![servo connected to dev kit](images/mainServo.jpg)

The C.H.I.P. Pro Dev board provides breakout pins to conveniently power and control servos from. 

Most servos have three pins: **power**, **ground**, and a **control signal**. The control signal is a pulse-width-modulated input signal whose high pulse width (within a determined period) determines the servo's angular position. The control signal pin draws a small enough amount of current that it can be directly controlled by the PWM pins on C.H.I.P. Pro. 

![servo connected to dev kit](images/pwmPins.jpg)

While the signal pin draws a low amount, the servo motor connected to the power pin draws more power than the C.H.I.P. Pro can provide on its own. The Dev Kit board helps with this by providing a **5 volt power pin** next to the signal and ground pin. This pin is connected to the **DC-In barrel jack providing 5 volts**. 

The PWM0 and PWM1 through-holes are staggered just enough to friction hold male header pins. So, no soldering is needed. 

Export the PWM pin you want to use:

```shell
echo 0 > /sys/class/pwm/pwmchip0/pwm0/export
```

**Enable** the channel and set the **polarity**, **period** of the waveform and **duty cycle**. Units are in **nanoseconds**. The **polarity** can only be set before the pin is enabled. If you set it after enabling a pin the script should still work but you will see a "I/O error". Most servos operate at **50Hz which translates into a 20000000 ns period**. Start the **duty cycle** at **0**:

```shell
echo normal > /sys/class/pwm/pwmchip0/pwm0/polarity
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 20000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
```

Once you do this initial setup, the **duty_cycle** is what needs to change to rotate the servo. Whatever value is written to the duty_cycle changes the pulse width. To get you started, there are two examples below, one rotates a 180º servo, the other rotates and stops a 360º continuous servo.
  
#### 180º Servo

![180º servo sweeping](images/sweep_180.gif)

**Servo Used in Example**

* 180º degree 4.8V - 6V [Hitec HS-40](http://hitecrcd.com/products/servos/micro-and-mini-servos/analog-micro-and-mini-servos/hs-40-economical-nano-nylon-gear-servo/product)

Before you start to work with your servo, check the datasheet. There you can sometimes find the pulse widths needed to control it. 

To rotate 180º most servos require a duty cycle where 1000000 ns/1 ms corresponds to the minimum angle and 2000000 ns/2 ms corresponds to the maximum angle. However, not all servos are the same and will require calibration. For example, the HS-40 used in this example has a minimum of 600000 ns/0.6 ms and maximum of 2400000 ns/2.4 ms. A good place to start is somewhere in the middle like 1500000 ns/1.5 ms. You can then go up and down from there to find the max. and min. 

Change the duty cycle to 1500000 ns and step up every 100000 ns to move the servo:

```shell
echo 1500000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1600000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1700000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
```

When done, disable and unexport pin:

```shell
echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip0/unexport
```

##### Sweep Script

Find a Sweep script example [here](https://github.com/laraCat/CHIP_Pro_DKit_Examples/blob/master/PWM/sweep.sh). This script moves the servo back and forth from 0º - 180º while printing the duty cycle. You may need to calibrate the minimum and maximum to fit your servo.

#### 360º Continuos Servo 

![360º sweeping](images/sweep_360.gif)

**Servo Used in Example**

* 360º Continuous 4.8V - 6V [FEETEC FS90R Micro Servo](https://cdn-shop.adafruit.com/product-files/2442/FS90R-V2.0_specs.pdf)

For a continuous servo the PWM input signal allows control of the speed, direction of rotation and stopping period.  Before you start to work with your servo, check the datasheet. There you can sometimes find the pulse widths needed to control it. 

A typical stop width is **1500000 ns/1.5 ms**. The further the time travels above and below the stop width, the slower the rotation speed gets.

Below are the pulse widths for the FS90R servo. Yours may be slightly different. 

* 1500000 ns: stop
* 1000000 ns - 1400000 ns: slow - fast right
* 1600000 ns - 2000000 ns: slow - fast left  

##### Sweep Script

This [script](https://github.com/laraCat/CHIP_Pro_DKit_Examples/blob/master/PWM/sweepCont.sh) steps through different speeds while rotating in each direction. Each speed lasts for two seconds. It stops for one second at 1500000 ns before rotating in the opposite direction.



