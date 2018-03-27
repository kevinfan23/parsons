import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class day4 extends PApplet {

// adapted from the coding example provided by Daniel Stiffman
// originally posted on https://youtu.be/IKB1hWWedMk
// MIT License
static final float RISING_SPEED = 0.5f;
static final float DIAMETER = 750;
int Y_AXIS = 1;
int X_AXIS = 2;

int cols, rows;
int scl = 20;
int w = 3000;
int h = 900;
float flying = 0;

float[][] terrain;
float[][] altitudes;


public void setup() {
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}


public void draw() {

  flying += 0.005f;
  float yoff = flying;

  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2f;
    }
    yoff += 0.2f;
  }

  //background(155, 196, 255);
  // set gradient background
  pushMatrix();
  translate(-w/2, -h/2, -700);
  setGradient(0, 0, width*5, height*5, color(155, 196, 255), color(222, 237, 253), Y_AXIS);
  popMatrix();

  // pushMatrix();
  // // translate(width/2, height/2+50);
  // // translate(-w/2, -h/2);
  // noStroke();
  // fill(255, 112, 83);
  // ellipse(width/2, height/2, 400, 400);
  // popMatrix();

  pushMatrix();
  translate(0, 0, -500);
  noStroke();
  fill(255, 112, 83);
  ellipse(width/2, 200, DIAMETER, DIAMETER);
  popMatrix();

  translate(width/2, height/2+50);
  rotateX(PI/(2.3f));
  translate(-w/2, -h/2);

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      stroke(211, 239, 252);
      fill(255);
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}

// set gradient function by Processing.org
// https://processing.org/examples/lineargradient.html
public void setGradient(int x, int y, float w, float h, int c1, int c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
  public void settings() {  size(1000, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
