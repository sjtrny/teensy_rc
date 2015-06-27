# teensy_rc
USB interface for your RC receiver and computer using a teensy

# Parts Required
- [Teensy 3.1](https://www.pjrc.com/teensy/teensy31.html) or [Teensy LC](https://www.pjrc.com/teensy/teensyLC.html)
- RC Receiever

# Instructions
- Wire teensy and RC receiver up as per diagram
- Connect Teensy to your computer via USB
- Load arduino_teensy_rc.ino on your Teensy using the Arduino IDE
- Turn on your transmitter
- Run teensy_rc.pde in Processing to test everything
- That's it!

# Wiring for Teensy 3.1

<img src="https://raw.githubusercontent.com/sjtrny/teensy_rc/master/wiring.jpg" align = "center" width="400px"/> 

# Dependencies

- [controlP5](http://www.sojamo.de/libraries/controlP5/)