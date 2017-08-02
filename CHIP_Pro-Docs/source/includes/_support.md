# Support

This support page is where you can find frequently asked questions and topics of the technical variety. For general inquiries, check out our C.H.I.P. Pro FAQ section.

## Power

### Why is my battery charging very slowly or not at all?
First, make sure the correct power source is connected to correct pin as stated in the documentation. 

Assuming the power source is connected correctly, the issue may be with the BTS pin which is directly connected to the TS pin on the AXP209 power management unit. This pin expects a specific voltage range in order to know it is safe to charge the battery. It's recommended to disable it by either connecting the pin to ground or disabling through software. Read more about the TS pin and solutions provided in the Power section of the C.H.I.P. Pro docs. 

### 