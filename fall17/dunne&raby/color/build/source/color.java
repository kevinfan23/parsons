import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class color extends PApplet {


// import processing.serial.*;

Capture video;

int trackColor;
float threshold = 25;

public void setup(){
  
  video = new Capture(this, width, height);
  video.start();
  trackColor = color(255, 0 , 0);

  // setup serial port
//   String portName = Serial.list()[33];
//   myPort = new Serial(this, portName, 9600);
// }
}

public void draw(){
  video.loadPixels();
  image(video, 0, 0);

  threshold = map(mouseX, 0, width, 0, 50);
  float avgX = 0;
  float avgY = 0;

  int count = 0;

  float mostRed = 500;
  int closestX = 0;
  int closestY = 0;
  for (int x = 0; x<video.width; x++){
    for(int y = 0; y<video.height; y++){
      int loc = x+y*video.width; //LOCATION OF PIXELS

      int currentColor = video.pixels[loc]; //Search Color
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);

      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = dist(r1, g1, b1, r2, g2, b2);
      if(d<threshold){
        mostRed = d;
        avgX +=x;
        avgY +=y;
        count ++;
      }
    }
  }

  if(count > 0){
    avgX = avgX/count;
    avgY = avgY/count;
    fill(trackColor);
    strokeWeight(4.0f);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
  }
}

public void mousePressed(){
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

public void captureEvent(Capture video){
  video.read();
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "color" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
