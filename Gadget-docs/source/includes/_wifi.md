# Set Up WiFi

GadgetOS comes with a quick and convenient way to connect to your device through the host computer's USB port, which is handy for things like setting up WiFi. To connect your computer to GadgetOS type the following command.

```shell
gadget shell
```
### Enable WiFi and Find a Network

Use connmanctl to enable WiFi, scan for available networks, and list all the networks in range.

```shell
connmanctl enable wifi
connmanctl scan wifi
connmanctl services
```

The `services` command will give output similar to:

```shell
WaffleHouse          wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
                         wifi_xxxxxxxxxxxx_hidden_managed_psk
YOUR_NETWORK         wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
                                 wifi_xxxxxxxxxxxx_xxxxxx_managed_none
Donut_Hut            wifi_xxxxxxxxxxxx_xxxxxxxxx_managed_psk
```

### Connect 

Copy the string to the right of the network name you want to connect to that starts with "wifi_." If the string contains a `psk` at the end, it means the network is password protected. Follow the "Password Protected" section further down to connect.


#### No Password

To connect to YOUR_NETWORK, which has no password, `services` shows two choices. You want the one without `psk` in the string. Use the `connect` command:

```shell
connmanctl connect wifi_xxxxxxxxxxxx_xxxxxx_managed_none
```

If your network is not password protected, you'll get some output that will indicate a successful connection, such as:

```shell
[  961.780000] RTL871X: rtw_set_802_11_connect(wlan0)  fw_state=0x00000008
[  962.070000] RTL871X: start auth
[  962.080000] RTL871X: auth success, start assoc
[  962.090000] RTL871X: rtw_cfg80211_indicate_connect(wlan0) BSS not found !!
[  962.100000] RTL871X: assoc success
[  962.110000] RTL871X: send eapol packet
[  962.290000] RTL871X: send eapol packet
[  962.300000] RTL871X: set pairwise key camid:4, addr:xx:xx:xx:xx:xx:xx, kid:0, type:AES
[  962.320000] RTL871X: set group key camid:5, addr:xx:xx:xx:xx:xx:xx, kid:1, type:AES
```

If your network is password protected, you'll get an error.

#### Password Protected
To deal with passwords, you'll need to put ConnMan into interactive mode:

```shell
connmanctl
```

This command gives a `connmanctl` prompt:

```shell
connmanctl>
```

In the shell, turn the agent on so it can process password requests:

```shell
  agent on
```

Now use the `connect` command with your pasted wifi network string:

```shell
  connect wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Enter your password when prompted:

```shell
  Agent RequestInput wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
  Passphrase?
```

You will be notified that you are connected:

```shell
  Connected wifi_xxxxxxxxxxxx_xxxxxx_managed_psk
```

Exit connmanctl interactive mode:

```shell
  quit
```

### Step 3: Test Connection

Test your connection with `ping`. Google's DNS server at the IP address 8.8.8.8 is probably the most reliable computer on the internet, so:

```shell
ping -c 4 8.8.8.8
```
The `-c 4` option means it will happen only 4 times. Expect ping to output some timing messages:

```shell
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=60 time=7.631 ms
64 bytes from 8.8.8.8: seq=1 ttl=60 time=7.474 ms
64 bytes from 8.8.8.8: seq=2 ttl=60 time=7.697 ms
64 bytes from 8.8.8.8: seq=3 ttl=60 time=9.004 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 7.474/7.951/9.004 ms
```

If you have issues connecting, read our "[Troubleshooting Connection Problems](https://docs.getchip.com/chip_pro.html#step-3-test-connection)" on the C.H.I.P. Pro Doc page.

### Step 4. Exit Gadget Shell

```
exit
```


