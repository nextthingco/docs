# GadgetCLI Commands

To see all the available GadgetCLI commands and options:

```
gadget help
```

```
Options:

-C <path> Run in directory (default ".") #gadget -C <path> <command>
-v	Verbose execution 

Commands:

init        Initialize gadget project
add         Add new container to config
build       Build container[s]
deploy      Deploy container[s]
start       Run container[s]
stop        Stop running container[s]
status      Fetch status of container[s]
delete      Remove container[s] from gadget
shell       Connect to remote device running GadgetOS
logs        Fetch logs(stdout) of container[s]
version     Print version information
help        Print this message
 
```

* Containers can be layered in the gadget.yml configuration file by adding them as services or at onboot. For optimization, one container can be targeted by adding its name after a `gadget` command. For example:

```
gadget build gpio
```

* A `gadget` command can be issued from a different directory. For example to build an project in a directory called "blinkdemo" from its parent directory: 

```
gadget -C blinkdemo/ build 
```







