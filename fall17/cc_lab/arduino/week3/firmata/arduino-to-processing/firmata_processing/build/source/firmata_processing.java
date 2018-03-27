import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class firmata_processing extends PApplet {

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



Serial myport;

float xPos;
float yPos;

public void setup() {
  

  // Lisr all the available ports
  println(Serial.list());

  // select the incomming port
  String portName = Serial.list()[4];
  myport = new Serial(this, portName, 9600);

  background(0xff081640);
}

public void draw() {
  // draw the line in pretty color
  stroke(0xffA8D9A7);
  line(xPos, height, xPos, yPos);

  // at the edge of the screen, go back to the beginning
  if (xPos >= width) {
    xPos = 0;
    // clear the screen
    background(0xff081640);
  }
  else {
    xPos++;
  }
}

public void serialEvent(Serial myPort) {
  // get the byte
  int inByte = myPort.read();
  // print
  println(inByte);

  yPos = height - inByte;
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "firmata_processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
