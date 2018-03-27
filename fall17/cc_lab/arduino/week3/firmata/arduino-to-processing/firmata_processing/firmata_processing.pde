// import processing.serial.*;
// import cc.arduino.*;
//
// Arduino arduino;
//
// int ledPin = 13;
//
// void setup() {
//   arduino = new Arduino(this, Arduino.list()[4], 57600);
//   arduino.pinMode(ledPin, Arduino.OUTPUT);
// }
//
// void draw() {
//   arduino.digitalWrite(ledPin, Arduino.HIGH);
//   delay(500);
//   arduino.digitalWrite(ledPin, Arduino.LOW);
//   delay(500);
// }

import processing.serial.*;

Serial myport;

float xPos;
float yPos;

void setup() {
  size(800, 600);

  // Lisr all the available ports
  println(Serial.list());

  // select the incomming port
  String portName = Serial.list()[4];
  myport = new Serial(this, portName, 9600);

  background(#081640);
}

void draw() {
  // draw the line in pretty color
  stroke(#A8D9A7);
  line(xPos, height, xPos, yPos);

  // at the edge of the screen, go back to the beginning
  if (xPos >= width) {
    xPos = 0;
    // clear the screen
    background(#081640);
  }
  else {
    xPos++;
  }
}

void serialEvent(Serial myPort) {
  // get the byte
  int inByte = myPort.read();
  // print
  println(inByte);

  yPos = height - inByte;
}
