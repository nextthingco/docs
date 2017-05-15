# PCB Design Tips 

C.H.I.P. Pro was created to be seamlessly embedded into products and we at NTC are here to help you do that. Are you ready to go from breadboard to PCB? This section includes recommendations and tips to help you plan a successful PCB design. It provides a go-to reference for all C.H.I.P. Pro's technical documents and suggested resources for beginners.  

![C.H.I.P. Pro PCBs](images/boards.jpg)

## Ordering C.H.I.P. Pros

Order C.H.I.P. Pro in small or large quantities from our [store](https://nextthing.co/pages/store). To start, we recommend ordering a handful to prototype with, then ramping up to quantities. 

## Tech Documents

We are open source so you will find design and technical documents on our Github account. For convenience, here are all the technical documents that relate to designing a PCB from our Github in one place. 

* [C.H.I.P. Pro datasheet](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Datasheets/CHIP_PRO_Datasheet_v1.0.pdf)
* C.H.I.P. Pro Manual
* [Component datasheets](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/Component%20Datasheets)
* [Mechanical documents](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/Mechanical_Documents)
* [C.H.I.P. Pro schematics](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/v1.0/CHIP_Pro_v1_0_Schematic.pdf)
* [PCB board files](https://github.com/NextThingCo/CHIP_Pro-Hardware/tree/master/v1.0/PCB%20Source)
* [Eagle Footprint](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr) 
* [C.H.I.P. Pro and Dev Kit Docs](https://docs.getchip.com/)
	
## Footprint

There are ready-made footprints available for C.H.I.P Pro to start with. We also provide all the measurements required to create your own footprint with the EDA software of your choice. 

If a beginner, it's best to start with an already designed footprint for C.H.I.P. Pro so you can get straight to designing the rest of your circuit. Currently, there are footprints built for two software packages:

* [Eagle](https://github.com/NextThingCo/CHIP_Pro-Hardware/blob/master/Footprint/EAGLE/CHIP_Pro-Footprint.lbr) 
* EasyEDA
	A user contributed footprint for C.H.I.P. Pro can be found by searching CHIP_Pro in EasyEDA's libraries.

If designing your own, use our diagram that includes measurements to ensure CHIP Pro aligns with the solder pads correctly.  

![C.H.I.P. Pro footprint](images/footprint.png)

**Footprint Cutout**

The ready-made footprints include an open space in the middle allowing for the 1.4mm height extending from the bottom of C.H.I.P. Pro. **It's important to include this negative space measuring 43mm x 26mm** in the design of your PCB. C.H.I.P. Pro is populated on both sides and needs this open space to sit properly on the footprint.

![C.H.I.P. Pro footprint](images/clearance.jpg)


## PCB Software and Services 

There are many software packages to start designing your PCB and services to use to manufacture one. Perhaps you already have a favorite go-to, but if you are just starting out here are some recommendations to start exploring.

### EDA (Electronic Design Automation) Software

There is a wealth of EDA software to choose from. Some are good for beginners others have a bigger learning curve that is worth the effort.

*  [KiCad](http://kicad-pcb.org/)

	A free and open source software suite that is preferred by hobbyists and professionals alike. Design schematics, layout PCBs, and verify design for manufacturing. There are plenty of tutorials to learn from on their [website](http://kicad-pcb.org/help/tutorials/).

* [EasyEDA](https://easyeda.com/)

	A cloud-based software suite that has free and professional priced packages. Not only can you design PCBS, they offer circuit simulation and take PCB fabrication orders through their website. Footprints to components can be designed and contributed by community members for use by anyone. A user contributed footprint for C.H.I.P. Pro can be found by searching CHIP_Pro in libraries. Get started with EasyEDA's online [tutorials](https://easyeda.com/Doc/Tutorial/).

* [Eagle](https://www.autodesk.com/products/eagle/overview) 

	Eagle is powerful PCB design and schematic layout software. It's features go deep but it's main work flow can be learned by beginners quickly. It's well used and has a strong community behind it. There are plenty of tutorials found online, such as at [Sparkfun](https://www.sparkfun.com/tutorials/108), [Adafruit](https://learn.adafruit.com/ktowns-ultimate-creating-parts-in-eagle-tutorial/introduction), and [YouTube](https://www.youtube.com/user/EAGLECadSoftComputer). Start by reading an overview of the software and finding links to tutorials, example projects and more on [Eagle's product page](https://www.autodesk.com/products/eagle/overview). Find our C.H.I.P. Pro Eagle compatible footprint for download above. 
	
* [Altium](http://www.altium.com/)

	Used by professionals and hobbyists, a bigger learning curve comes with Altium but it is worth the time invested if you plan on continuing to design PCBs.

### PCB Fabrication Services

When you are ready to get your board fabricated, there are several choices to choose from. Your choice will be based on a number of factors including, turn around time, board features (flex and color options) and scale of order. All of the services listed do small quantities to get you started. 

* [Advanced Circuits](http://www.4pcb.com/)

	Several pricing options to choose from depending on what your board design specifications are. Many board features available with no minimum quantity. They also offer design and assembly services.
	
* [PCBWay](https://www.pcbway.com/)

	No minimums, fast turn around and easy to use interface for uploading board designs and getting a quote. They offer flexible pcbs, SMD (surface mount device) stencils and assembly services. 
	
* [Seeed Fusion PCB & PCB Assembly](https://www.seeedstudio.com/fusion.html)

	They offer layout, manufacturing and assembly services along with other CNC services such as 3D printing and milling. They offer several colors of PCB starting at the cheapest fabrication option.
	
* [OSH Park](https://oshpark.com/)

	They do batch manufacturing meaning that your board gets created with others on the same panel. This affects the turn around time making them the slowest option on the list. However, their straight forward and simple ordering interface makes it very easy to upload and check a board design in a minutes.
	
### Verify Manufacturer Design Rules

PCB manufacturers have specifications outlining their production capabilities called "design rules". When you choose a board manufacturer, find their production specs and check that your PCB design follow the guidelines. These include smallest possible traces, drill hole size and spacing. Most PCB design software automate the DRC (design rule checking) process. If the design software you are using does not have that feature some board manufacturers offer the service or you can use DRC specific software. 
 
As an example, OSH Park's PCB design rules are found on their OSH Park [Design Submission Guidelines](https://oshpark.com/guidelines) page. Conveniently, they provide a ready-made file for checking PCB designs using Eagle. OSH Park also provides [design guideline documents](http://docs.oshpark.com/design-tools/) for many of the EDA software people submit design files to them with. Below are more links to get you started. 

* [Altium](https://techdocs.altium.com/display/ADOH/Design+Rules#) 
* [KiCad](http://kicadhowto.wikidot.com/co1drc)
* [Eagle](https://www.youtube.com/user/EAGLECadSoftComputer/videos)
* [EasyEDA](https://easyeda.com/Doc/Tutorial/introduction.htm) 


## Power Considerations

### Supplying Power to C.H.I.P. Pro

Powering C.H.I.P. Pro via the CHG-IN pin at 5-5.5V is the suggested route for all embedded applications. 

C.H.I.P. Pro can also be powered through BAT if a battery is connected, and VBUS if a USB charger/supply is connected. 

Operating Voltage

| Pin    | Min | Typical | Max        | Unit |
|--------|-----|---------|------------|------|
| CHG-IN | 3.8 | 5-5.5   | 6.3        | V    |
| BAT    | 3.0 | 3.8     | 4.2+/-0.5% | V    |
| VBUS   | 3.8 | 5-5.5   | 6.3        | V    |

PMU (Power Management Unit) Vout Current Available Before Loading Battery

| Iout         | Min    | Typical | Max     |
|--------------|--------|---------|---------|
| Min. and Max | 500 mA | 900 mA  | 2500 mA |

Power is managed by the AXP209 Power Management Unit. Read the [AXP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf) to get all the information needed to power C.H.I.P. Pro appropriately for your product.

### Current Draw

**C.H.I.P. Pro Current Draw**

Like any feature-loaded SOM, how much current C.H.I.P. Pro draws depends on what you need it to do. When idle, current gets down to 100 mA with multiple peripherals unused. Peak current can get around 750 mA during WiFi radio signaling while maxing out processor, NAND, and DRAM loads. Budgeting 250-350 mA for normal operation is a midrange target to aim for. A reliable 2A+ rated power supply will work well to power C.H.I.P. Pro.

**Setting USB VBUS Current Draw** 

The current draw limit of VBUS can be set by software. Check the [AXP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). 
 for information starting on page 33. The setting options are 100mA, 500mA, 900mA and "no limit".  "No Limit" is what C.H.I.P. Pro is set to by default upon boot. Keep in mind that, if you set the current limit and the current draw exceeds the threshold, C.H.I.P. will shut down.  

### Battery and BTS Pin

Thinking of including a rechargeable battery as a product feature? Read on to learn more about the BTS pin. 

Pin 7 marked **BATTEMP or BTS** is directly connected to the **TS** pin on the AXP209 PMU. This pin supports a thermistor to monitor the battery temperature when the battery is charging or discharging.  If you do not incorporate a thermistor into your setup the pin may float from ground interfering with how much charge current is throttled to the **BAT** pin and the **JST connector**. To ensure maximum charge current without a thermistor disable the battery temperature monitoring system.

There are two ways to do this:

* Connect BTS pin to ground
* Disable the temperature functionality in software:

```shell
sudo i2cset -y -f 0 0x34 0x82 0x82
````

The AXP209 IC is seen as a I2C device on C.H.I.P. Pro. By default the AXP209 is tuned for a 10KΩ 1% thermistor at 25°C with a programmable register for thermistor current to adapt to different devices. You can find more information on this setup in the [AXP209 Datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf). Search "ts pin" to quickly find

### Power Button 

The PWRON pin can be connected to GND through a button as a Power Enable Key (PEK) or hibernation/wake button. The AXP209 can automatically identify long and short button presses. Read more about this on page 10 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf).  

## Additional USB Port

Whether you want to add a micro USB 5V source or a host USB-A port, here are some points on power to consider while designing your PCB.

* Standard USB peripherals operate at 5 volts and can draw a good amount of current.
* IPSOUT can provide 5 volts to your USB-A 5V pin if there's a 5 volt input to the system via VBUS or CHG-IN. If a battery is connected and power is not available through VBUS or CHG-IN, IPSOUT will provide 3.7 volts which is most likely not sufficient for a USB peripheral.
	* Consider using a 5V DC/DC buck/boost converter on IPSOUT to maintain a 5 volt rail to your additional USB port. In this case, if the device goes into battery mode it will still be getting 5 volts. If you go this route, set the VBUS current limit appropriately for your system's current draw. See page 33 of the [AXMP209 datasheet](https://github.com/NextThingCo/CHIP-Hardware/blob/master/CHIP%5Bv1_0%5D/CHIPv1_0-BOM-Datasheets/AXP209_Datasheet_v1.0en.pdf) to learn more.

## WiFi Signal

The onboard ceramic WiFi antenna is for debugging purposes only. For products applications use the antenna that comes with the C.H.I.P. Pro Dev Kit or obtain any of these officially supported ones:

| Antenna Model | Manufacturer | Gain | Antenna Type | Connection Type | Freq. Range (GHz) | Cable Length (mm) |
|------------|-----|-----|-----|-----|-----|-----|
| AA107       | Unictron | 3.3 dBi | PCB | IPEX | 2.4 - 2.5 | 100 | 
| HCX-P321   | Wacosun | 2 dBi | PCB | IPEX | 2.4 - 2.5 | 150 |
| FXP73.07.0100A | Taoglas | 2.5 dBi | PCB | IPEX | 2.4 - 2.483 | 100 |
| AA055   | Unictron | 2.5 dBi | Ceramic | SMT | 2.4 - 2.5 | n/a |

## Modular Certification 

* C.H.I.P. Pro is CE, IC, and FCC Part 15 Modular Transmitter certified for use with multiple commercially available [external antennas](https://docs.getchip.com/chip_pro_devkit.html#wifi-antenna) as well as the onboard ceramic SMT antenna. 

* Any product with C.H.I.P. Pro as the only active radio transmitter will not require your company to run certification testing for the unintentional radiator portion of FCC tests, specifically FCC Part 15B. This will save you testing time and cost associated with taking your product through FCC certification. You will still need to run FCC Part 15C tests (EMC testing for the intentional radiator portion). 

* You will not need to apply for a new FCC-ID for your product; when you process your application with a certified test lab, they will file a Class II Permissive Change under NTC's FCC ID. For any questions on this, reach out to us at pro@nextthing.co. The FCC ID can be found etched on the WiFi module. 

![C.H.I.P. Pro FCC ID](images/CHIP_Pro_FCC.png)

## Analog Input

C.H.I.P. Pro has many GPIO to choose from including two PWM pins. If your product needs analog input we recommend adding an I2C controlled ADC to your circuit. 

## Mass Production

Are you thinking about mass production? We can offer 

## Community Projects

See what other people are making with C.H.I.P. Pro.


