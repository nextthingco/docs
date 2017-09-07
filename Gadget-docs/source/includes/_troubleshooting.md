# Troubleshooting

## Unable to `gadget deploy` image to board 

### Private key login error

```
W:    Private key login failed, trying default key
E:    Default key login also failed
W:    Is the gadget connected and powered on?
W:    Was the gadget first used on another computer/account?
E:  Failed to connect to Gadget
```

* Directly after flashing GadgetOS to your C.H.I.P. Pro Dev Kit the board needs to reboot. Unplug from USB port and plug back in or power cycle using the On/Off button.
* As a security precaution, GadgetCLI generates a unique set of login credentials for each computer. This means that if you have deployed a project from one computer, you will not be able to deploy from another computer unless you transfer the authorized keys found in the host computer .ssh/ directory. 

	**File names:**
	
	* gadget_default_rsa
	* gadget_rsa
	* gadget_rsa.pub
	
	**File Locations:**
	
	**Linux**: /home/$USER/.ssh
	
	**Windows**: C:/Users/$USER/.ssh 
	
	**Mac OSX**: /Users/$USER/.ssh
	
	* A device's authorized keys can also be reset by re-flashing. 
	

### Transferring has slowed to a crawl

Your NAND is most likely full. Power down your board and re-flash with GadgetOS. 

To prevent this, connect to the host device with `gadget shell` and use `df-h` to check NAND availability. Docker image sizes can also be checked on the host with the `docker images` command.

Make sure to delete previous images as soon as you are done with them.

## Unable to `gadget build` image

### Failed to build/valid image error

```
E:  Error response from daemon: repository jelly/spike not found: does not exist or no pull access
E:  Failed to build 'spike'
W:  Are you sure '%s' is a valid image [and tag]?
W:  Is the docker daemon installed and running?
```

The entry next to `image:` is not a valid Docker Hub username, repo or tag. Double check the entry. 

If building an image from a local Dockerfile, leave this field blank and put the project's path in "directory."

### Unknown flag/failed to build error

```
I:  Running in directory:
I:    ~/projectName
I:  Building:
I:    'projectName'
E:  Unknown flag: from
E:  Failed to build 'projectName'
W:  Is the docker daemon installed and running?
```

Your version of Docker may be out of date. Docker version 17.06 or greater is required. To check which version of Docker you have run the command `docker -v`.


## Unable to `Docker build` an `arm32v7/8*` image 

### "exec format error"

```
standard_init_linux.go:187: exec user process caused "exec format error"

```
The latest versions of Docker for Windows and Docker for Mac can build non-native architecture containers which is not the case for some distributions of Linux. Additional files need to be added and packages installed to enable to ability to build `arm32v7/*` Docker images. To install the necessary packages and get the necessary files, follow the instructions in [Setup for Linux](https://docs.getchip.com/gadget.html#setup-for-linux) section.

```
standard_init_linux.go:187: exec user process caused "no such file or directory"

```

There is one more step to the process to enable the ability to build `arm32v7/*` Docker images you may have overlooked. Or, the files did not copy over successfully. Head to the [Setup for Linux](https://docs.getchip.com/gadget.html#setup-for-linux) section to complete the step of creating a directory `binfmt.d`, copying files over and restarting `systemd-binfmt.service`.

### Unable to `restart systemd-binfmt.service`

```
Job for systemd-binfmt.service failed because the control process exited with error code.
See "systemctl status systemd-binfmt.service" and "journalctl -xe" for details.

```

Download the packages listed in the [Setup for Linux](https://docs.getchip.com/gadget.html#setup-for-linux) section and reboot.
