# Hello World 

Get up and running in minutes with this straight forward *Hello World* example.

### 1. Create Project a Directory

```bash
mkdir hello-world
cd hello-world
```

### 2. Initialize Project

```bash
gadget init
```

This command creates a template file called gadget.yml and generates a project called "hello-world" ready to be deployed.

Open gadget.yml using Nano or your favorite command-line text editor. The .yml file should look similar to what's below.

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
  readonly: false
  command: []
  binds: []
  capabilities: []
  devices: []
services: []
```

### 3. Build 

```bash
gadget build
```

### 4. Deploy 

```bash
gadget deploy
```

### 5. Start 

```bash
gadget start
```

### 6. Look at Logs and Check Status

Once the container runs, it outputs a "hello world" message to the log file. You can view these message by using the `gadget logs` command.

```bash
gadget logs
```

You should see a message with an intro similar to this:

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```
Congrats, you have built and deployed your first Gadget project!

### 7. Stop and Cleanup Container

To stop the running container use the `gadget stop` command.

```bash
gadget stop
```

To delete the container use the `gadget delete` command.

```bash
gadge delete
```

