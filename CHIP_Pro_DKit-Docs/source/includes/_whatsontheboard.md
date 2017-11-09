# What's on the Board

## C.H.I.P. Pro Dev Kit Features

![Front Callouts](images/frontCallout.jpg)

* **USB1 Port (2.0 Host)** - USB A jack lets C.H.I.P. Pro act as a USB EHCI/OHCI host for external devices. By default, this is powered by the USB micro jack. Cut the appropriate trace to power this from the barrel jack instead. 
* **USB0 VBUS Power LED** - When there is power available to the USB1 port, this LED will illumniate.
* **USB0 + UART1** - The micro USB jack provides serial and USB gadget connectivity, power from a USB power source, and UART connectivity for complete terminal messages from boot time.
* **3.7 LiPo battery jack** - a JST connector for connecting and powering the dev kit from a 3.7 volt Lithium Polymer battery.
* **1/8" Audio Jack** - This TRRS jack provides stereo audio out and optional mono input.
* **DC In Jack** - Connect a power supply ranging from 6V to 23V to power the C.H.I.P. Pro.
* **CHG-IN On/Off Switch** - Switch can enable or disable the power feed from the DC in jack, allowing you to isolate the power source.
* **PWM0/1 LEDs** - Two LEDs are connected directly to the PWM pins on C.H.I.P. Pro to make it easy to test PWM in software by dimming these LEDs.
* **C.H.I.P. Pro Power Button** - If there is power from DC, USB, or battery, you can hold this down for 1 second to turn C.H.I.P. Pro on, or hold for 5 seconds to turn it off.
* **MIC1/2** - Two on-board microphones are spaced 40mm apart, ideal for testing voice control applications and beam-forming algorithms. (With sound travelling at ~340 m/s, the delay between the two microphones is 5.64 samples @ 48K sampling rate, or 117 microseconds)
* **GPIO D0-7 LED** - These are connected directly to GPIO D0 to D7 on C.H.I.P. Pro for easy software examples using GPIO control.
* **UART1 TX/RX LEDs** - These LEDs indicate when data is passing on the UART1 TX and RX pins.
* **FEL Button** - This button needs to be held down before C.H.I.P. Pro is powered up to put it in FEL mode for flashing new firmware.

## Pin Headers

![Pin Headers](images/ThruHoles.jpg)

There are several areas where pin headers can be soldered into through-holes for easy access and control of the pins on C.H.I.P. Pro.

* **PWM0/1 Through-Hole Breakout** - Add pin headers to connect servos and LEDs with pulse width modulation.
* **Battery Switch** - Add a switch so you can easily disable or enable power from a battery. You will need to [cut a trace](#back-traces) to make this switch work. 
* **C.H.I.P. Pro** - The through-holes surrounding the C.H.I.P. Pro can be filled with pin headers to give access to the pin you need.

## Cuttable Traces

The C.H.I.P. Pro Dev Kit is designed to be flexible for your design and provide valuable built-in hardware. There are several cuttable circuit paths that will disconnect onboard components and reroute power and data to where you need. You can find all of the cuttable paths jumpers outlined in the images below.

Default circuit paths are indicated with a silkscreened bar under the connected pads. 

Most of these traces are on the back of the board with one very important exception. The USB0 jumpers on the front are connected to the micro USB0 port on the Dev Kit. This renders the micro USB port on the C.H.I.P. Pro itself unusable. If you would like to use the micro USB port on C.H.I.P. Pro these must be cut. 

![Front Callouts](images/cutJumpers.jpg)

### Front Traces

* **USB0 Disconnect** - There are two traces that are important for USB communication and one (1) trace that will disconnect USB power from the main micro USB connnector to C.H.I.P. Pro. To disconnect the dev kit's main micro USB connector, cut between the pads for the traces marked "+" and "-". These are for the "D+" and "D-" USB data lines. This will allow you to use the micro USB connector on the C.H.I.P. Pro.

### Back Traces

* **UART Disconnect** - Cut these traces to disable the UART functionality from the dev kit's USB micro connector. This disables the FE1.1S USB hub controller IC.
* **MIC1/MIC2 Power Select** - Cut-and-solder these pads to change the power source for the onboard mics. Cut between the pads marked with the line, then solder bridge the other two pads to select 3.3 volt power instead of the default VMIC power for MIC1 or MIC2. By default the dev kit is wired to VMIC which provides power only while recording. 
* **MIC1/MIC2 Ground Select** - Cut-and-solder these pads to change the ground for the onboard mics. Cut between the pads with the line, then solder between the other two pads to select GND instead of the default AGND power for MIC1 or MIC2.
* **GPIO LED Disconnect** - If you don't want the on-board GPIO LEDs to illuminate, cut this trace.
* **MIC2 Disconnect** - Cut this trace to disconnect the onboard microphone and enable the MIC2 pin on C.H.I.P. Pro.
* **PWM LED Disconnect** - If you don't want the LEDs to illuminate when using PWM from the C.H.I.P. Pro pins, cut this trace. 
* **MIC1 Disconnect** - Cut this trace to disconnect the onboard microphone and enable the MIC1 pin on C.H.I.P. Pro.
* **Enable Sleeve for MIC1 IN** - Solder over these pads to use the sleeve ("S" of the TRRS) of the 1/8" audio jack.
* **HP (headphone) Ground Select** - Cut-and-solder these pads to change the grounding for the headphone jack. Cut between the pads with the line, then solder between the other two pads to use HPCOM instead of GND.
* **Battery Disconnect** - If you want to add a switch for a battery, you'll need to cut this trace, then solder a switch into the through-holes provided.
* **USB1 Host Power Select** - Cut-and-solder to power the USB A (host) jack from the barrel jack (wall power) instead of the default power from the USB Micro. 

## How to Cut

Here's what you need to know about modifying and repairing the traces on the Dev Kit to experiment and test different configurations.

### Cut 
To get the job done you need to grab an X-acto knife or another small, sharp blade. The goal is to cut the trace connecting the two solder pads while NOT cutting anything else. The area to cut is very small so if you happen to own a pair of magnifying eye glasses now is the time to use them! To help stay in one place and not accidentally run the blade over another trace think of the cutting action as more of a digging one. 

![Cut Jumper](images/traces_cut.jpg)

When you feel like you may have successfully cut through test the connection with your multimeter to confirm the disconnect.
 	
![Test Jumper](images/traces_test.jpg)

### Cut-and-Solder
Some of these require both a trace cut and a solder bridge. For example, the MIC1 power has three pads. Cut between two of the pads, and bridge two with solder.

![Solder and Cut Jumper](images/traces_solderCutHand.jpg)

### Revert and Repair
Once you cut a trace it can be reverted to the original behavior. To replace the jumper solder a small piece of wire across all the contacts you wish to reconnect, or, if you are nimble, bridge the contacts with a solder blob.

If you need some reminding, circuit paths that came as default are indicated with a silkscreened bar under the originally connected pads.

![Solder Bridge](images/traces_solderBridge.jpg)
