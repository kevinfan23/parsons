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

public class shaking_hands_processing extends PApplet {



Serial myPort;  // Create object from Serial class
String val;        // Data received from the serial port
boolean firstContact = false;

public void setup()
{
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUnitl('\n');
}

public void draw() {
}

public void serialEvent(Serial myPort) {
  val = myPort.readStringUntil('\n');

  if (val != null) {
    val = trim(val);
    println(val);
  }

  if (firstContact == false) {
    if (val.equals('A')) {
      myPort.clear();
      firstContact = true;
      myPort.write("A");
      println("contact");
    }
  }
  else {
    println(val);

    if (mousePressed == true) {
      myPort.write('1');
      println('1');
    }
    myPort.write('A');
  }
}
  public void settings() {  size(200, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "shaking_hands_processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
