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

Directly after flashing GadgetOS to CHIP Pro Dev Kit the board needs to reboot. Unplug from USB port and plug back in or power cycle using the on/off button.

### Transferring has slowed to a crawl

Your NAND is most likely full. Power down your board and re-flash with GadgetOS. 

To prevent this, use `df-h` to check NAND availability and delete previous images as soon as you are done with them. 

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




