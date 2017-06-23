# Quick Start [David]

To get the most from Gadget's lighting fast deployment process, development is done on a host computer. Once your code is ready for testing it's compiled and pushed to the hardware device connected via USB using GadgetOS' daemon GadgetOSD. To get started, install the following on your host computer and Gadget compatible hardware. 

## Install Gadget

On your host computer download and install NTC's command-line tool, GadgetCLI [here]. 

## Install Docker

	* If already installed make sure it's up to date

Gadget makes use of Docker's container system. Dependent on your host computer's OS, download and install the appropriate version of Docker using the below links. For more information on Docker, read [here](https://www.docker.com/).

* MacOS - [Docker CE](https://store.docker.com/editions/community/docker-ce-desktop-mac?tab=description)
* Windows 10 - [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
* Ubuntu - [Docker CE](https://store.docker.com/editions/community/docker-ce-server-ubuntu?tab=description)

GadgetCLI uses the Docker daemon to pull from Docker Hub [check function with Crunch]. Once Docker is installed, run it before using GadgetCLI.

## Flash GadgetOS 

For GadgetCLI to be able to talk to your hardware device it needs to be flashed with the latest GadgetOS image. Find the latest image on our [web flasher](flash.getchip.com/pro). 

## Hello World Example

Get up and running in minutes with this straight forward "Hello World" example.

#### 1. Create Project Directory

```bash
mkdir hello-world
cd hello-world
```
	
#### 2. Initialize Project

```bash
gadget init
```

This command creates a template file gadget.yml and generates a project called "hello-world" ready to be deployed to your hardware. 

Open gadget.yml using Nano or another command-line editor. It should look like this except your will have a uuid unique to your container:

```bash
spec: "0.0"
name: directoryName
uuid: 1789cc27-e1a8-40ef-aa1f-324092e6eff7
type: docker
onboot:
- name: hello-world
  uuid: 1ef762fe-a500-41d1-8cf9-bbd621dd09b8
  image: arm32v7/hello-world
  directory: ""
  net: ""
  pid: ""
  readonly: false
  command: []
  binds: []
  capabilities: []
services: []
```
	
#### 3. Build
	
```bash
gadget build
```

Output:

```bash
INFO[0000] Running in directory:                        
INFO[0000]   /Users/xxxx/project/pathname/
INFO[0000] Building:                                    
INFO[0000]   'hello-world'
	```
	
#### 4. Deploy
	
```bash
gadget deploy
```

Output:

```bash
INFO[0000] Running in directory:                        
INFO[0000]   /Users/xxxx/project/pathname/ 
INFO[0000]   Deploying: 'hello-world'                   
INFO[0000]     Starting transfer..                      
INFO[0000]     Done!  
```
	
####5. Start
	
```bash
gadget start
```
	
Output:
	
```bash
INFO[0000] Running in directory:                        
INFO[0000]   /Users/xxxx/project/pathname/ 
INFO[0000] Starting:                                    
INFO[0000]   hello-world_1ef762fe-a500-41d1-8cf9-bbd621dd09b8 
INFO[0001]     - started 
```

#### 6. Confirm

To see if the container did indeed run use the `logs` command to print the output:

```bash
gadget logs
```

You should see a 'Hello' message that starts with:

```
Hello from Docker on armhf!
This message shows that your installation appears to be working correctly.
...
```
Congrats, you have built and deployed your first Gadget project!

If the container doesn't produce an output this will be blank. To see what containers are running check the status:

```bash
gadget status
```

#### 7. Stop and Cleanup
	
Stop all running containers:

```bash
gadget stop
```

Delete containers:

```bash
gadge delete
```

### Exit GadgetCLI //test with installer version

GadgetCLI simply opens a window using your host computer's terminal application. To exit, first stop the running application then exit. 

```shell
stop
exit 
```
