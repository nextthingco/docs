# PCB Design Tips 

C.H.I.P. Pro was created to be seamlessly embedded into products and we at NTC are here to help you do that. Are you ready to go from breadboard to PCB? This section gives recommendations and provides resources and tips to help you plan a successful PCB design. 

![C.H.I.P. Pro PCBs](images/boards.jpg)

## From 1 to 1MM 

To make scaling up efficient and easy, we offer C.H.I.P. Pro in small or large quantities from our online [store](https://nextthing.co/pages/store). To start, we recommend ordering a handful to prototype with, then ramping up to larger quantities. 

## Tech Documents

NTC hardware and software is open source for development. You will find the following design and technical documents for [C.H.I.P. Pro](https://github.com/NextThingCo/CHIP_Pro-Hardware) and the [C.H.I.P. Pro Dev Kit](https://github.com/NextThingCo/CHIP_Pro-Dev-Kit) on our Github account. 

* C.H.I.P. Pro datasheet
* Component datasheets
* Mechanical documents
* C.H.I.P. Pro schematics
* C.H.I.P. Pro Dev Kit schematics
* PCB board files
* Eagle Footprint
	
## C.H.I.P. Pro Footprint

There are ready-made footprints available for C.H.I.P Pro to start a PCB layout with. Allowing you to get straight to designing the important parts of your circuit. Currently, there are footprints built for two software packages:

* [Eagle](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr) 
* [EasyEDA](https://easyeda.com/)
	* A user contributed footprint for C.H.I.P. Pro can be found by searching CHIP_Pro in EasyEDA's libraries.
	
We also provide all the measurements required to create your own footprint with the EDA (Electronic Design Automation) software of your choice. 

![C.H.I.P. Pro footprint](images/footprint0.png)

<aside class="notice">
The ready-made footprints include an open space in the middle allowing for the 1.4mm height extending from the bottom of C.H.I.P. Pro. **It's important to include this negative space measuring 43mm x 26mm** in the design of your PCB. C.H.I.P. Pro is populated on both sides and needs this open space to sit properly on the finished PCB.
</aside>

![C.H.I.P. Pro footprint](images/clearance.jpg)

Do you want to share a footprint that you have created with us? We would like to include it here for others to use. Send your footprint to docs@nextthing.co. 

## PCB Software and Services 

There are many software packages and services to design and manufacture a PCB with. Perhaps you already have a favorite go-to, but if you are just starting out or want to check out other options here are some recommendations to start exploring.

### EDA Software

There is a wealth of EDA software to choose from. Listed here are resources that are both used by beginners and professionals alike. 

*  [KiCad](http://kicad-pcb.org/)

	A free and open source software suite that is preferred by hobbyists and professionals alike. Design schematics, layout PCBs, and verify design for manufacturing. There are plenty of tutorials to learn from on their [website](http://kicad-pcb.org/help/tutorials/). 

* [EasyEDA](https://easyeda.com/)

	A cloud-based software suite that has free and professional priced packages. Not only can you design PCBS, they offer circuit simulation and take PCB fabrication orders through their website. Footprints to components can be designed and contributed by community members for use by anyone. A user contributed footprint for C.H.I.P. Pro can be found by searching CHIP_Pro in libraries. Get started with EasyEDA's online [tutorials](https://easyeda.com/Doc/Tutorial/). This is a great resource for someone who is starting out in PCB design.

* [Eagle](https://www.autodesk.com/products/eagle/overview) 

	Eagle is a powerful PCB design and schematic layout software. It's well used and has a strong community behind it. There are plenty of tutorials found online, such as at [Sparkfun](https://www.sparkfun.com/tutorials/108), [Adafruit](https://learn.adafruit.com/ktowns-ultimate-creating-parts-in-eagle-tutorial/introduction), and [YouTube](https://www.youtube.com/user/EAGLECadSoftComputer). Start by reading an overview of the software and finding links to tutorials, example projects and more on [Eagle's product page](https://www.autodesk.com/products/eagle/overview). Find our C.H.I.P. Pro Eagle compatible footprint for download above. 
	
* [Altium](http://www.altium.com/)

	Used by professionals and advanced hobbyists. A bigger learning curve comes with Altium but it is worth the time invested if you plan on continuing to design production ready grade PCBs.

### PCB Fabrication Services

When you are ready to get your board fabricated, there are several choices. Your choice will be based on a number of factors including, turn around time, board features (flex and color options) and scale of order. All of the services listed do small quantities to get you started. A few do large scale as well and offer multi-layer boards and other advanced services.

* [Advanced Circuits](http://www.4pcb.com/)

	Several pricing options to choose from depending on what your board design specifications are. Many board features available with no minimum quantity. They also offer design and assembly services.
	
* [PCBWay](https://www.pcbway.com/)

	No minimums, fast turn around and easy to use interface for uploading board designs and getting a quote. They offer flexible pcbs, SMD (surface mount device) stencils and assembly services. 
	
* [AllPCB](http://www.allpcb.com/)
	
	AllPCB offers low prices and quality services in small and large scale batches. Their website is comprehensive with instant quote services and a way to upload your BOM and search for specific components.
	
* [Seeed Fusion PCB & PCB Assembly](https://www.seeedstudio.com/fusion.html)

	They offer layout, manufacturing and assembly services along with other CNC services such as 3D printing and milling. They offer several PCB colors options with their cheapest fabrication option.
	
* [OSH Park](https://oshpark.com/)

	OSH Park does batch manufacturing meaning that your board gets created with others on the same panel. This affects the turn around time making them the slowest option on the list. However, their straight forward and simple ordering interface makes it very easy to upload and check a board design in minutes.
	
### Verify Manufacturer Design Rules

PCB manufacturers have specifications outlining their production capabilities called "design rules". These design rules include smallest possible traces, drill hole size, spacing, etc. Most PCB design software have an automated process that checks your design against these design rules using files. This is called the DRC (design rule checking) process. If the design software you are using does not have this feature some board manufacturers offer the service or you can use DRC specific software. 
 
As an example, OSH Park's PCB design rules are found on their OSH Park [Design Submission Guidelines](https://oshpark.com/guidelines) page. Conveniently, they provide a file for checking PCB designs using Eagle softeare. OSH Park also provides [design guideline documents](http://docs.oshpark.com/design-tools/) for many of the EDA software people submit designs with. To get you started, below are some design rule resources for software linked to in this doc.

* [Altium](https://techdocs.altium.com/display/ADOH/Design+Rules#) 
* [KiCad](http://kicadhowto.wikidot.com/co1drc)
* [Eagle](https://www.youtube.com/user/EAGLECadSoftComputer/videos)
* [EasyEDA](https://easyeda.com/Doc/Tutorial/introduction.htm) 


## Power Considerations

### Supplying Power to C.H.I.P. Pro

Powering C.H.I.P. Pro via the *CHG-IN* pin at 5-5.5V is the suggested route for all embedded applications. A reliable 2A+ rated power supply will work well to power C.H.I.P. Pro.

C.H.I.P. Pro can also be powered through *BAT* if a battery is connected, and *VBUS* if a USB charger/supply is connected. 

#### Recommended Operating Voltage

| Pin    | Min | Typical | Max        | Unit |
|--------|-----|---------|------------|------|
| CHG-IN | 3.8 | 5-5.5   | 6.3        | V    |
| BAT    | 3.0 | 3.8     | 4.2+/-0.5% | V    |
| VBUS   | 3.8 | 5-5.5   | 6.3        | V    |

#### PMU (Power Management Unit) Vout Current Available Before Loading Battery

| Iout         | Min    | Typical | Max     |
|--------------|--------|---------|---------|
| PMU Vout | 500 mA | 900 mA  | 2500 mA |

Programmable current limit can be set in software allowing for safe attachment to USB 2.0, USB 3.0, or high-current CHG-In sources. Check the [AXP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 
 for more information starting on page 33. The setting options are 100mA, 500mA, 900mA and "no limit".  "900mA" is what C.H.I.P. Pro is set to by default upon boot. Keep in mind that, if you set the current limit and the current draw exceeds the threshold, C.H.I.P. will shut down.

### Power Consumption

Like any feature-loaded SOM, how much current C.H.I.P. Pro draws depends on what you need it to do. The following measurements are offered as a rough starting point with which to begin to understand the range of power budgets relevant to a CHIP Pro-based device operated from a battery. Exact power consumption is significantly influenced by factors such as software power optimizations (or lack thereof), power source quality, external peripheral circuitry, and ambient operating conditions. 

| System State    | Measurement | Value |
|--------|-----|---------|
| Idle at Linux Shell | Supply (BAT) | 4.17V  |	
|     | Current | 125.90 mA    |
|    | Power | 525.00 mW   | 
| Playing Local Audio | Supply (BAT) | 4.17V  |	
|     | Current | 209.40 mA    |
|    | Power | 873.62 mW   |
| WiFi Pinging | Supply (BAT) | 4.17V  |	
|     | Current | 184.70 mA    |
|    | Power | 770.20 mW   |
| Standby | Supply (BAT) | 4.17V  |	
|     | Current | 5.30 mA    |
|    | Power | 22.10 mW   |
| Shutdown | Supply (BAT) | 4.17V  |	
|     | Current | 1.60 mA    |
|    | Power | 6.67 mW   |
  

### Battery and BTS Pin

Thinking of including a rechargeable battery as a product feature? Read on to learn more about the BTS pin. 

Pin 7 on C.H.I.P. Pro is marked **BATTEMP or BTS** and is directly connected to the **TS** pin on the AXP209 PMU. This pin supports a 10KΩ 1% thermistor to monitor the battery temperature when the battery is charging or discharging.  If you do not incorporate a thermistor into your circuit the pin may float from ground interfering with how much charge current is throttled to the **BAT** pin and the **JST connector**. To ensure maximum charge current without a thermistor disable the battery temperature monitoring system.

There are two ways to do this:

* Connect BTS pin to ground
* Disable the temperature functionality in software:

```shell
sudo i2cset -y -f 0 0x34 0x82 0x82
````

You can find more information on this setup in the [AXP209 Datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf) starting on page 21. 

### Power Button 

The PWRON pin can be connected to GND through a button as a Power Enable Key (PEK) or hibernation/wake button. The AXP209 can automatically identify long and short button presses. Read more about this on page 10 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf).  

## Additional USB Port

Whether you want to add a micro USB 5V source or a host USB-A port, here are some points on power to consider while designing your PCB.

* Standard USB peripherals operate at 5 volts and can draw a good amount of current so, budget a power supply appropriately.
* IPSOUT on C.H.I.P. Pro can provide 5 volts to the 5V pin of the additional USB port if there's a 5 volt input via VBUS or CHG-IN. If a battery is connected and power is not available through VBUS or CHG-IN, IPSOUT will provide 3.7 volts which is most likely not sufficient for a USB peripheral.
	* To avoid IPSOUT dropping to 3.7V in battery mode consider using a 5V DC/DC buck/boost converter to maintain a 5 volt rail to your additional USB port. If you go this route, set the VBUS current limit appropriately for your system's current draw. 
	
## Analog Input

C.H.I.P. Pro has many GPIO to choose from including two PWM pins. If your product needs analog input we recommend adding an I2C controlled ADC to your circuit. 

## WiFi Signal

The onboard ceramic WiFi antenna is for debugging purposes only. For products applications use the antenna that comes with the C.H.I.P. Pro Dev Kit or obtain any of these officially supported ones:

| Antenna Model | Manufacturer | Gain | Antenna Type | Connection Type | Freq. Range (GHz) | Cable Length (mm) |
|------------|-----|-----|-----|-----|-----|-----|
| AA107       | Unictron | 3.3 dBi | PCB | IPEX | 2.4 - 2.5 | 100 | 
| HCX-P321   | Wacosun | 2 dBi | PCB | IPEX | 2.4 - 2.5 | 150 |
| FXP73.07.0100A | Taoglas | 2.5 dBi | PCB | IPEX | 2.4 - 2.483 | 100 |
| AA055   | Unictron | 2.5 dBi | Ceramic | SMT | 2.4 - 2.5 | n/a |

## Make Use of Modular Certification 

* C.H.I.P. Pro is CE, IC, and FCC Part 15 Modular Transmitter certified for use with multiple commercially available external antennas as well as the onboard ceramic SMT antenna. 

* Any product with C.H.I.P. Pro as the only active radio transmitter will not require your company to run certification testing for the Intentional Radiator portion of FCC tests, specifically FCC Part 15C. This lessens the workload of taking your product through full FCC certification. You will still need to test and state compliance with FCC Part 15B Unintentional Radiation limits. 

* You will not need to apply for a new FCC-ID for your product. When you process your application with a certified test lab, they will file a Class II Permissive Change under NTC's FCC ID. For any questions on this, reach out to us at pro@nextthing.co. The FCC ID can be found etched on the WiFi module. 

![C.H.I.P. Pro FCC ID](images/CHIP_Pro_FCC.png)

## Do Something GR8

Are you thinking of going into mass production, but not sure what path to take? We offer services at several production stages to get you moving quickly towards a fully developed product.  

* Custom flashing 
* NRE software 
* Custom engineering support
* PCB material and manufacturer recommendations

If you would like to learn more about how we can help you make a GR8 product, reach out to us at pro@nextthing.co.





