# Bluetooth for Debian

On development machine:

* Connect to C.H.I.P. Pro via UART-serial
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




