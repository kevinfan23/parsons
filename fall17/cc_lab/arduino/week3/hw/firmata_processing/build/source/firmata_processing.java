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

/**
 * Simple Write.
 *
 * Check if the mouse is over a rectangle and writes the status to the serial port.
 * This example works with the Wiring / Arduino program that follows below.
 */




Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

public void setup()
{
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
}

public void draw() {
  background(40, 44, 52);
  if (mouseOverRect() == 'G') {
    cursor(HAND);
    myPort.write('G');
  }
  else if (mouseOverRect() == 'R') {
    cursor(HAND);
    myPort.write('R');
  }
  else {
    cursor(ARROW);
    myPort.write('L');
  }

  colorMode(RGB);
  noStroke();
  rectMode(CENTER);
  fill(52, 238, 115);
  rect(width/2 - 100, height/2, 100, 100);         // Draw a square
  fill(234, 32, 32);
  rect(width/2 + 100, height/2, 100, 100);         // Draw a square
}

public char mouseOverRect() { // Test if mouse is over square
  if ((mouseX >= width/2 - 100 - 50) && (mouseX <= width/2 - 100 + 50) && (mouseY >= height/2 - 50) && (mouseY <= height/2 + 50)) {
    return 'G';
  }
  else if ((mouseX >= width/2 + 100 - 50) && (mouseX <= width/2 + 100 + 50) && (mouseY >= height/2 - 50) && (mouseY <= height/2 + 50)) {
    return 'R';
  }
  else {
    return ' ';
  }
}

/*
  // Wiring/Arduino code:
 // Read data from the serial and turn ON or OFF a light depending on the value

 char val; // Data received from the serial port
 int ledPin = 4; // Set the pin to digital I/O 4

 void setup() {
 pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
 Serial.begin(9600); // Start serial communication at 9600 bps
 }

 void loop() {
 while (Serial.available()) { // If data is available to read,
 val = Serial.read(); // read it and store it in val
 }
 if (val == 'H') { // If H was received
 digitalWrite(ledPin, HIGH); // turn the LED on
 } else {
 digitalWrite(ledPin, LOW); // Otherwise turn it OFF
 }
 delay(100); // Wait 100 milliseconds for next reading
 }

 */
  public void settings() {  size(800, 450); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "firmata_processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
