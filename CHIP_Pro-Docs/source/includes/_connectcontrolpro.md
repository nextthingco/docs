# Connect and Control

## Flash an Operating System

Like its older sibling C.H.I.P., C.H.I.P. Pro's GR8 SiP can run mainline Linux. This provides security, flexibility, robust tools, and open-source options for getting your product working. In the interest of power consumption and storage space, we have two OS options to best fit your needs. 

**Debian** is a classic amongst embedded Linux board users for rapid prototyping. It offers a full package manager and loads of precompiled software for many different architectures. 

**Buildroot** is simple and stripped down making it efficient and good for single application use cases. 

C.H.I.P. Pro's SLC NAND storage is optimized for commercial applications. While the storage is faster and more reliable it has less capacity - it's a good idea to know how much storage software will take before flashing and installing.  

Grab these items to flash an example:

 * C.H.I.P. Pro 
 * USB A to Micro-USB B cable
 * Separate computer with [Chrome](https://www.google.com/chrome/browser/desktop/index.html) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) browser 

### Flashing Process
If it's your first time flashing, when you arrive at [flash.getchip.com/pro](http://flash.getchip.com/pro) you will be asked to install an Chrome extension.

Once the extension is installed, plug the micro USB cable into the micro USB port on C.H.I.P. Pro.   

Hold down the FEL button (a pencil eraser works nicely) and with the other hand plug the USB cable into the computer. The C.H.I.P. Pro will power up which will be indicated by the pink power and white status LEDs illuminating. 

![pushing FELL button](images/hold_plugPro800.gif)

The web flasher will then search for and eventually recognize the C.H.I.P. Pro. 

![searching for board](images/searchPageCrop.png)

Keep holding the FEL button down until the magnifying glass goes away and the page with example images appear. Let go of the FEL button and choose an example image to flash.

![image page](images/imagePage.png)


## Examples
You can select an OS by flashing one of our examples using the web flasher [flash.getchip.com/pro](http://flash.getchip.com) in Chrome or Chromium browser. Before you go to the web flasher however, there is a method to flashing the C.H.I.P. Pro to know and get in the habit of. This process is explained below and is also illustrated on the flasher page.

We have built examples based on Buildroot specific to the hardware on the [Developer's Kit](https://docs.getchip.com/chip_pro_devkit.html). If you are building a circuit that incorporates mics and LEDs with a bare C.H.I.P. Pro you can start with these examples. 

#### Blinkenlights (Buildroot)
Size: ~60MB

This Python based example provides easy-to-understand code with exciting results! Flash C.H.I.P. Pro with this image and LEDs connected to **GPIO D0-D7** turn on and off in a cascading pattern. LEDs connected to the **PWM0 and PWM1 pins** will pulse from dim to bright. 

#### VU Meter (Buildroot)
Size: ~60MB

Want to make sure your mics are working? Use this handy VU Meter Python based example. LEDs connected to GPIO D0 - D7 will light proportional to the volume of the noise captured by two mics connected to the **MICIN1 and MICIN2 pins**.

### Debian
Size: ~180MB

We provide a standard Debian distribution, complete with all the package managers and conveniences you know and love. This package is ideal for development, since it is more flexible than the buildroot-based Gadget OS. However, you will want to keep track of your dependencies to more easily transition to the more nimble Gadget OS.

## Make a Serial Connection

C.H.I.P. Pro is a headless computer, so you will need a separate computer in order to interact with it. This section will go over how to connect via USB-serial to UART, connect to a WiFi network and where to find example scripts.

### USB-Serial to UART Pins

A UART to USB-serial connection between C.H.I.P. Pro and your computer offers the most comprehensive look at what's happening in C.H.I.P. Pro since you can get all message output from the moment it starts booting. 

#### Things you will need

* USB-UART cable ([for example](https://www.amazon.com/JBtek-WINDOWS-Supported-Raspberry-Programming/dp/B00QT7LQ88/ref=sr_1_6?srs=9123049011&ie=UTF8&qid=1488833574&sr=8-6))
* Drivers
* Soldering Iron
* Solder
* Pin headers
* Computer with monitor (for example, a [C.H.I.P.](http://www.getchip.com/)!)
* Terminal emulation software for Windows such as [PuTTY](http://www.chipkin.com/using-putty-for-serial-com-connections-hyperterminal-replacement/) (OS X and Linux have `screen` built-in)

#### Install USB-UART Cable Drivers

Not only will you need a USB-UART cable but you will need the appropriate drivers that go with the cable installed. Download and install the appropriate driver based on your computer's operating system.

For example, [this](https://www.amazon.com/JBtek-WINDOWS-Supported-Raspberry-Programming/dp/B00QT7LQ88/ref=sr_1_6?srs=9123049011&ie=UTF8&qid=1488833574&sr=8-6) cable uses the Prolific hardware. The drivers are [available on their site](http://www.prolific.com.tw/US/ShowProduct.aspx?pcid=41&showlevel=0041-0041). If you are on Windows the driver can be installed after connecting C.H.I.P. Pro to your computer and navigating to Device Manager, finding **Ports (COM & LPT)** and double-clicking on the unrecognized USB-serial port. From the window that pops up you will be able to tell the computer to go find the device's driver online and install it.

#### Power C.H.I.P. Pro 

C.H.I.P. Pro can be powered through a computer's USB port. However, some power intensive applications might require more current than the average computers provide via their USB port. A reliable way to power C.H.I.P. Pro is through the **micro USB port using an AC adapter** (we recommend getting one that supplies 12V and 3 amps).


#### Solder Headers to C.H.I.P. Pro

To connect the USB-UART cable to C.H.I.P. Pro you will need to solder headers onto the board for a reliable connection. 

![UART connection](images/solderHeaders_800.jpg)

The below connections work for the cable linked to in the above material list. Make sure to check the manufacturer's product description for the correct pinout for whatever cable you are using.
 
* black -  GND
* green - RX
* white - TX


![UART connection](images/UARTconnect_800.jpg)

### OS X & Linux

Mac systems and most flavors of Linux come with the terminal emulator software Screen. In case `screen` is missing, it can be installed using apt-get on Debian-based systems: 

```
sudo apt-get install screen
```

With C.H.I.P. Pro connected to your computer check to see if the usbserial port has appeared: 

**Mac**

```
ls /dev/tty.*
```

The port name will be `/dev/tty.usbserial` or something similar.

**Linux** 

```
ls /dev/ttyUSB*
```

The port name will be `ttyUSB0` or something similar.

#### Connect 

Use Screen to create a serial terminal connection at 115200 bps:

**Mac**

```
screen /dev/tty.usbserial 115200
```
**Linux**

```
screen /dev/ttyUSB0 115200
```

Once a terminal window pops up, hit the Enter key. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.

#### Exit Screen

When done with Screen, press Ctrl+A then Ctrl+\ to kill all windows and terminate Screen. 

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

This will return you to the previous screen session. Then use Ctrl+A Ctrl+\ to close it (will ask you to confirm).


### Windows

Download the [PuTTY terminal emulator](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

In Windows open the **Device Manager**. Find and expand **Ports (COM & LPT)**. Find the port labeled **USB-to-Serial Port (COMx)** and take note of the COMx port number. This is the port that the C.H.I.P. Pro is connected to.

In PuTTY choose **Serial** as the **Connection type**. Then, plug these items in and click **Open**. 

* COMx number as the **Serial Line**  
* 115200 as the **Speed** (baud rate)

[![Com Port](images/ComPort.PNG)] (images/ComPort.PNG) | [![puTTY](images/puTTYsetM.jpg)] (images/puTTYsetM.jpg) | 
|:---:|:---:|
| In Device Manager find COM port # | Plug port # and baud rate into puTTY | 

Once a terminal window pops up, press Enter. 

* For a Buildroot example you will automatically be logged in as ```root```. 
* For the Debian example, log in with the default username and password ```chip```.


## WiFi Antenna
C.H.I.P. Pro has an onboard ceramic antenna that is intended for debugging purposes only. We recommend the use of an external antenna for all product applications. 

### Connect Antenna
Coming straight from the top push the antenna onto the connector. Keep in mind the connector will wear out over time. We suggest keeping the disconnect/connect cycle down to 10 or less. 

[![wifi antenna connector](images/wifiConnectB.jpg)] (images/wifiConnectB.jpg) | [![push antenna on](images/wifiPush.jpg)] (images/wifiPush.jpg) | 
|:---:|:---:|
| WiFi antenna connector | Push antenna onto connector |

![wifi antenna connected](images/wifiOn.jpg)

### Enable Wifi Antenna
In order to use it, you need to set the path of the external antenna.

**Debian**

With the Debian C.H.I.P. Pro images comes a [set_antenna script](https://raw.githubusercontent.com/NextThingCo/CHIP-buildroot/34a8cfdab2bbecd6741c435d6c400e46848436f1/package/rtl8723ds_mp_driver/set_antenna) which accepts two arguments of either `pcb` or `ufl` depending on which you want enable. 

```
set_antenna pcb|ufl
``` 

**Buildroot**

Set the antenna path in Buildroot two ways:

* The RF switch is connected to logic pin PB17. Manually set the logic states to choose either the onboard or external antenna.

0 = PCB Antenna
1 = u.FL antenna. 

```
0=onboard-antenna 

1=external-antenna
```

* `wget` set_antenna script found [here](https://raw.githubusercontent.com/NextThingCo/CHIP-buildroot/34a8cfdab2bbecd6741c435d6c400e46848436f1/package/rtl8723ds_mp_driver/set_antenna) 

## WiFi Setup: Buildroot

The Buildroot operating system uses the `connman` command-line network manager to connect and manage your network connections. 

**Requirements**

  * C.H.I.P. Pro running buildroot OS
  * [Serial connection](https://docs.getchip.com/chip_pro.html#make-a-serial-connection) to C.H.I.P. Pro
    
### Step 1: Enable WiFi and Find a Network

These three commands will, in turn, enable wifi, scan for access points, and list what networks are available:

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

Copy the string that starts with "wifi_' to the right of the network name you want to connect to. If it has `psk` at the end, that means it is password protected (short for Wi-Fi Protected Access 2 - Pre-Shared Key) and you will need to go into connman interactive mode.

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
To deal with passwords you'll need to put `connman` into interactive mode:

```shell
connmanctl
```

which gives a `connmanctl` prompt:

```shell
connmanctl>
```

In the shell, turn the 'agent' on so it can process password requests:

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

To test the WiFi connection you can ping Google four times:

```shell
ping -c 4 8.8.8.8
```

Expect ping to output some timing messages:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=55 time=209.147 ms
64 bytes from 8.8.8.8: seq=1 ttl=55 time=111.125 ms
64 bytes from 8.8.8.8: seq=2 ttl=55 time=183.627 ms
64 bytes from 8.8.8.8: seq=3 ttl=55 time=147.398 ms
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 111.125/162.824/209.147 ms
```
&#10024; You are Connected! &#10024;

If your connection is not successful, then ping will tell you your network is down:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
ping: sendto: Network is unreachable
```

#### Troubleshooting Connection Problems

* Review any messages that the connect commnand gave you. Did they look like the examples of a successful connection?

* Double check you used the right network when you used the connect commnand.

* If everything checked out until you got to `ping`, there's a good chance the problem is with your router or connection to the internet. 

* Connman not Installed Error

If you try to use `connman` and you get an error that it is not found or is not a command, chances are that you are using the Debian image. The `connman` commands only apply to C.H.I.P. Pros running the simple Buildroot OS.

### Disconnect from Network with Connman
To disconnect from your network, you might first want a reminder of what unfriendly string is used to describe your access point:

```shell
connmanctl services
```

Which will output information about your current connection:

```shell
YOUR_NETWORK         wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Use the string ID to disconnect:

```shell
connmanctl disconnect wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

You will be notified when it has disconnected: 

```shell
Disconnected wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

### Forget Network with Connman
Generally, `conman` will remember and cache setup information. This means that if you reboot in the vicinity of a known network, it will attempt to connect. However, if you need to forget a network setup, these setups can be found by navigating:

```shell
cd /var/lib/connman/
```

You can delete a single connection by seeing what connections are stored and copying the one you want to delete:

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
The `-r` is needed because these are directories you are deleting and the star at the end of `wifi*` assumes your configurations all start with the string “wifi”.

## WiFi Setup: Debian

If you are using Debian OS you will find that `connman` is not installed, you will need to use `nmcli` instead. There are several tools in Linux for connecting and configuring networks. We will be using the command `nmcli` (Network Manager Client). 

**Requirements**

  * C.H.I.P. Pro loaded with Debian
  * [Serial connection](https://docs.getchip.com/chip_pro.html#usb-serial-uart1-connection) to C.H.I.P. Pro

### Step 1: List available Wi-Fi networks
In the terminal type:

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

You can connect to password-protected or open access points.

#### No Password
To connect to an open network with no password:

```shell
sudo nmcli device wifi connect "YOUR_NETWORK_SSID" ifname wlan0
```
These commands will respond with information about the connection. A successful connection looks like:

```shell
Connection with UUID 'xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy' created and activated on device 'wlan0'
```

#### Password-Protected

To connect to a password-protected network, use this command inserting your own network name and password:

```shell
sudo nmcli device wifi connect "YOUR_NETWORK_SSID" password "UR_NETWORK_PASSWORD" ifname wlan0
```

These commands will respond with information about the connection. A successful connection looks like:

```shell
Connection with UUID 'xxxxxxxx-yyyy-zzzz-xxxx-yyyyyyyyyyyy' created and activated on device 'wlan0'
```
#### Hidden SSID and Password-Protected

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

After you have connected once, your C.H.I.P. will automatically connect to this network next time you reboot (or start NetworkManager services).

#### Test
Finally, you can test your connection to the internet with `ping`. Google's DNS server at the IP address 8.8.8.8 is probably the most reliable computer on the internet, so:

```shell
ping -c 4 8.8.8.8
```

results in output like:

```shell
64 bytes from 8.8.8.8: icmp_seq=1 ttl=55 time=297 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=55 time=26.3 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=55 time=24.8 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=55 time=55.7 ms
```

You can stop this command by pressing CTRL-C on your keyboard. The `-c 4` option means it will happen only 4 times.

&#10024; **Congratulations! You are now Connected to a Network** &#10024;

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

Then, delete the network specified between quotes to forget it:

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
It is possible that you can connect to a wireless network, but have no access to the internet, so you'd see a connection when you request device status, but have a failed ping. This indicates a problem or restriction with the router or the access point, not a problem with the CHIP.

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

If you try to use `nmcli` and you get an error that it is not found or is not a command, chances are that you are using a C.H.I.P. Pro buildroot image. The `nmcli` commands only apply to C.H.I.P. Pro using Debian linux.

## SSH 

Once you connect to an network you can ssh into the C.H.I.P. Pro in order to program and control it. Our Debian example comes with ssh servers, our Buildroot examples do not. If you want to ssh while using Buildroot you will need to do a manual build. 

**Debian**

### Find IP

```
ip addr
``` 
The IP will be under `wlan0`.

### Connect

```
ssh root@<CHIPproIP>
```


## Access I/O via sysfs	

GPIO is accessed through a [sysfs interface](https://www.kernel.org/doc/Documentation/gpio/sysfs.txt). Below are some basic exercises to check if the digital in/out pins are are working correctly. 

**Debian** - use `sudo` to gain permission while logged in as default `chip` user.

**Buildroot** - with our examples you are already logged in as the root user so `sudo` is not necessary. 

### GPIO Input

These lines of code will let you read values on pin **PE4** which corresponds to **132** in Linux sysfs (PE4 - PE11 are numbers 132-139 in sysfs).

If reading a CSID0 - CSID7 which are pins PE4 - PE11, you will need to add a pull-down or pull-up resistor to prevent a floating pin while the switch is open. 

![pull-down resistor](images/buttonUART_800.jpg)

In terminal, tell the system you want to listen to a pin:

```shell
  sudo sh -c 'echo 132 > /sys/class/gpio/export'
```

View the mode of the pin. By default the pin modes are set to input. So, the following command will return “in” unless the pin mode was changed to "out" previously:

```shell
  cat /sys/class/gpio/gpio132/direction
```

Connect a jumper wire or switch between pin PE4 and GND. Now use this line of code to read the value:

```shell
  cat /sys/class/gpio/gpio132/value
```

Continuously poll switch pin PE4(132) for state change:

```shell
  while ( true ); do cat /sys/class/gpio/gpio132/value; sleep 1; done;
```

### GPIO Output

Attach an LED to pin PE4 and ground. 

![UART connection](images/ledBlink_800.gif)

Change the mode of the pin from “in” to “out”:

```shell
  sudo sh -c 'echo out > /sys/class/gpio/gpio132/direction'
```

Now that it's in output mode you can write a value to the pin and turn the LED on and off:

```shell
  sudo sh -c 'echo 1 > /sys/class/gpio/gpio132/value'
```


#### Blink an LED on Pin PE4(132)

```
while ( true ); do echo 1 > /sys/class/gpio/gpio132/value; cat /sys/class/gpio/gpio132/value; sleep 1; echo 0 >  /sys/class/gpio/gpio132/value; cat /sys/class/gpio/gpio132/value; sleep 1; done;
```


### GPIO Done

When you are done experimenting always tell the system to stop listening to the gpio pin:

```shell
  sudo sh -c 'echo 132 > /sys/class/gpio/unexport'
```

If pins are not unexported, the pins will be "busy" the next time you go to export them. 

### Finding GPIO Pin Names
You can calculate the sysfs pin number using the [Allwinner R8 Datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/Allwinner%20R8%20Datasheet%20V1.2.pdf), starting on page 18. 

As an example let's look at CSID_D0 which is pin **PE4** on the datasheet. 

Look at the letter that follows the "P". This represents the number it is in the english alphabet. The index starts at A = 0. So,```E=4```

Multiply the letter index by 32, then add the number that follows "PE":

``` (32*4)+4 = 132```

Therefore, listening to CSID0 in sysfs would begin with

```
sudo sh -c 'echo 132 > /sys/class/gpio/export'
```
