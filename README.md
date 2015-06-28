# teensy_rc
USB interface for your RC receiver and computer using a teensy

<img src="https://raw.githubusercontent.com/sjtrny/teensy_rc/master/processing_teensy_rc.png" align = "center" width="333px"/> 

# Parts Required
- [Teensy 3.1](https://www.pjrc.com/teensy/teensy31.html) or [Teensy LC](https://www.pjrc.com/teensy/teensyLC.html)
- RC Receiever

# Instructions
- Wire teensy and RC receiver up as per diagram
- Install the [Arduino](https://www.arduino.cc/en/Main/Software), [Processing](https://processing.org/download/?processing) and [Teensyduino](https://www.pjrc.com/teensy/teensyduino.html) software
- Connect Teensy to your computer via USB
- Set your teensy's USB Type to "Serial + KB + Mouse + Joystick"
- Load arduino_teensy_rc.ino on your Teensy using the Arduino IDE
- Turn on your transmitter
- Run processing_teensy_rc.pde in Processing to test everything
- That's it!

# Wiring for Teensy 3.1

<img src="https://raw.githubusercontent.com/sjtrny/teensy_rc/master/wiring.jpg" align = "center" width="350px"/> 

# Dependencies

- [controlP5](http://www.sojamo.de/libraries/controlP5/)