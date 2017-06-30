 
# Hello World 

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

Open gadget.yml using Nano or another command-line editor. It should look like this except the uuid will be different:

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
	
#### 4. Deploy 
	
```bash
gadget deploy
```
	
#### 5. Start 
	
```bash
gadget start
```

#### 6. Look at Logs and Check Status

Once the hello-world container runs, it outputs a message. To see if the container successfully started use the `logs` command to fetch the output:

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

#### 7. Stop and Cleanup Container

Stop the running container:

```bash
gadget stop
```

Delete container:

```bash
gadge delete
```


