 View file @cb5ea69
# Troubleshooting

Error: 

Fix: Did you power cycle your board after flashing? 

Error:
E:  Error response from daemon: repository jelly/spike not found: does not exist or no pull access
E:  Failed to build 'spike'
W:  Are you sure '%s' is a valid image [and tag]?
W:  Is the docker daemon installed and running?

Fix: The image defined as `image:` is not a valid Docker Hub username, repo or tag. Double check name. If building an image from a local Dockerfile, leave this field blank and put pathname in "directory:".


* df -h
* Docker rmi and other clean-up commands
	* Gadget shell + clean-up commands
