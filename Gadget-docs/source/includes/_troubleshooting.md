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

* Directly after flashing GadgetOS to CHIP Pro Dev Kit the board needs to reboot. Unplug from USB port and plug back in or power cycle using the on/off button.
* As a security precaution, GadgetCLI generates a unique set of login credentials for each computer. This means that if you have deployed a project from one computer you will not be able to deploy from another computer unless you transfer the authorized keys. 

	Files names:
	
	/home/$USER/.ssh/gadget_default_rsa
	/home/$USER/.ssh/gadget_rsa
	/home/$USER/.ssh/gadget_rsa.pub
	
	File location:
	
	**Windows**
	C:/Users/$USER/.ssh directory
	
	**Mac OSX**
	/Users/$USER/.ssh
	
	* A device's authorized keys can also be reset by re-flashing. 
	

### Transferring has slowed to a crawl

Your NAND is most likely full. Power down your board and re-flash with GadgetOS. 

To prevent this, connect to the host device with `gadget shell` and use `df-h` to check NAND availability. Also, make sure to delete previous images as soon as you are done with them. 

Docker image sizes can also be checked on the host with the `docker images` command.

## Unable to `gadget build` image

### Failed to build error

```
E:  Error response from daemon: repository jelly/spike not found: does not exist or no pull access
E:  Failed to build 'spike'
W:  Are you sure '%s' is a valid image [and tag]?
W:  Is the docker daemon installed and running?
```

The entry next to `image:` is not a valid Docker Hub username, repo or tag. Double check the entry. 

If building an image from a local Dockerfile, leave this field blank and put pathname in "directory:".




