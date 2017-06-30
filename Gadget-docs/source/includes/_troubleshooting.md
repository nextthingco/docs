# Troubleshooting

* Error: 

```
W:    Private key login failed, trying default key
E:    Default key login also failed
W:    Is the gadget connected and powered on?
W:    Was the gadget first used on another computer/account?
E:  Failed to connect to Gadget
```

Fix: Did you power cycle your board after flashing? 

* Error:

```
E:  Error response from daemon: repository jelly/spike not found: does not exist or no pull access
E:  Failed to build 'spike'
W:  Are you sure '%s' is a valid image [and tag]?
W:  Is the docker daemon installed and running?
```

Fix: The image defined as `image:` is not a valid Docker Hub username, repo or tag. Double check name. If building an image from a local Dockerfile, leave this field blank and put pathname in "directory:".

* After running `gadget deploy` the transfer slows to a crawl. 

Fix: Your NAND is full due. A good habit is to use `df-h` to check availability and to delete previous images as soon as you are done with them.

# Command Glossary

* df -h
* Docker rmi and other clean-up commands
	* Gadget shell + clean-up commands
