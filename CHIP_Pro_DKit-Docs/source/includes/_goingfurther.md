## Audio

The C.H.I.P. Pro Development Kit has several ways to access audio in and out. Stereo audio in and out is handled by a 24bit/48K DAC built-in to the GR8 processor. There are also digital options that you can use, but require configuration of the Linux kernel and additional hardware to access.

* Audio output via 3.5mm TRRS jack
* Mono input via 3.5mm TRRS jack
* Stereo microphones
* MIC1 and MIC2 header pins
* I2S digital audio
* SPIDIF digital audio

### Input
There are two (2) analog MEM (micro electro mechanical) microphones on the Dev board. These are enabled by default. 

If you want to use the MIC1 and MIC2 pins for audio input, you'll need to [cut a trace](#back-traces).

The "Sleeve" (bottom-most ring) on the TRRS jack can be used as a mono audio input, suitable for microphones commonly built-in to headphones. If you want to used this connector, you'll need to [cut a trace](#back-traces).

### Output

The 3.5mm TRRS jack provides stereo output suitable for headphones or amplification to stereo speakers.

## USB
The USB A jack can be used to connect and use popular accessories like storage, MIDI controllers, keyboards, pointing devices, audio hardware, and more. C.H.I.P. Pro does not provide power to the USB A port on its own, so the Development Kit is a good example of how this works.  

## On-board LEDs
The Dev board provides ten LEDs to make it easy to test your GPIO skills without having to wire anything up. 

### GPIO LEDs
Eight of these LEDs can be turned on and off with standard Linux sysfs commands to the GPIO pins DO to D7. 

### PWM LEDs
There are also two LEDs that are connected to the PWM pins for testing and learning about pulse width modulation. 

## Make it with C.H.I.P. Pro! 
The Dev Kit board contains hardware to make rapid prototyping with C.H.I.P. Pro a unique experience. When it comes to software however, the C.H.I.P. Pro and Dev Board are the same. To learn more about C.H.I.P. Pro, such as connecting to WiFi and accessing GPIO, head over to the official [C.H.I.P. Pro Docs page](http://docs.getchip.com/chip_pro.html#get-working-with-c-h-i-p-pro).