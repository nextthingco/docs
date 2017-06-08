http://ntc-docs-unstable.surge.sh/gadget.html#welcome
Lara fills in outline on unstable branch 
 
Intro [David]
	What is Gadget intro paragraph
		Beta, we want feedback!
	GadgetCLI
	GadgetOS
	Workflow diagram [Lara]
 
Quick Start [David]
	Install Gadget
	Install Docker, if already installed make sure it’s the most up to date
	Hello World test
	Command def (do they need further explanation than what’s in the help file?)
	WiFi Setup via gadget shell & connmanctl
 
Build With Gadget [Lara]
	Two ways to deploy images 
		build image on local machine 
		git clone from our repo 
	Common command sequence
		init
		build	
		deploy
		start
		logs
		status
		shell w/ illustration showing where you are in relation to the container.
	Containerize an Application
	Examples
		I2C
		SPI
		VU-meter
		Python CHIP_IO
		Google Assistant?
		Multiple containers?
	Gadget.yml breakdown
	Where and how do you pass args to the docker run command?
	Once we know ^ we can answer how to add network, volume, kernel module, and device sharing between the host and container.

Alpine [David]
	Link to forum for feedback
	What is is Alpine
	Why is it being used? Why not Debian?
	Useful CMDs for Alpine Linux
		How to use APK
		Note: apk is not the android package!

Git basics [Lara]
	Clone
	Pull
	(commit and push are outside the scope, so we’ll link to outbound docs)
 
Troubleshooting [Lara]
	df -h
	Docker rmi and other clean-up commands
		Gadget shell + clean-up commands

Feedback
 
Gadget Forum Category [David]
	Start private for invite only beta
	Move to public once there’s a public launch
	Gadget
	Kernel Hacking? (we need feedback about the gadgetos kernel, but what’s the best way to get it?)
	Containers
	Alpine
