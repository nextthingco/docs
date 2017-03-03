# Update C.H.I.P to Linux kernel 4.4
DIPs require that C.H.I.P. is running the Debian 4.4 Linux kernel. Here's a detailed guide to determining if you need to update and how to update using our web flasher.

## Determine C.H.I.P.’s Kernel Version
To determine if you need to upgrade your C.H.I.P.’s kernel, connect a keyboard, mouse, and display to C.H.I.P., then power up CHIP.
Then, open the Terminal application (from the drop-down menu at the top, left corner of the Desktop.

Once the applications loads, type `uname -a`. This outputs information about your system software version.

![uname results in terminal](images/update_uname.jpg)

Look for a number in appended with `-ntc`, for example `4.3.0` or `4.4.0`. This number is the kernel version running on your C.H.I.P. If the number is `4.4.0` or greater, you don’t need to upgrade your kernel version. Most likely, your number is `4.3.0`, keep reading: you need to upgrade your kernel.

## Back-up C.H.I.P.’s Data
Backup any important data on your C.H.I.P. before you upgrade your system. Upgrading will overwrite all of the C.H.I.P. storage. You can backup your user directory with a simple command in the Terminal emulator:

```shell
tar cfpzv homebackup.tar.gz /home/chip
```

You can transfer that `tar` file to another computer or cloud service from C.H.I.P. There's more to learn in [this detailed guide](https://mylinuxramblings.wordpress.com/2010/01/10/how-to-backup-and-restore-your-home-directory/).

If you have installed a lot of packages with Synaptic or `apt`, and would like to be able to be able to easily re-install those packages, there's some good [guides](http://www.debianadmin.com/clone-your-ubuntu-installation.html) and [suggestions](http://serverfault.com/questions/175504/how-do-i-get-the-history-of-apt-get-install-on-ubuntu) on the web.

## Upgrade the Kernel with the C.H.I.P. Flasher

Using the [Chrome](https://www.google.com/chrome/browser/desktop/) or [Chromium](https://www.chromium.org/getting-involved/download-chromium) web browser, visit [flash.getchip.com](http://flash.getchip.com) and follow the on-screen instructions. When the flasher presents you with different OS images to choose from, click on “CHIP OS 1.1” to select it.

When flashing is complete, follow the instructions for using your DIP.
