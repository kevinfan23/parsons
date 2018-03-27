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

public class day7 extends PApplet {

static final float HUE = 110;
static final float ROAD_WIDTH = 110;

int cols, rows;
int scl = 10;
int w = 1280;
int h = 720;

float[][] terrain;
float[][] trees;

public void setup() {
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];

  float xoff = 0;

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff), 0, 1, 0, 50);
      xoff += 0.2f;
    }
  }
}

public void draw() {
  background(0);

  for (int y = 0; y < rows -1; y++) {
    for (int x = 0; x < cols; x++) {
      colorMode(HSB, 360, 100, 100);
      noStroke();

      fill(HUE, terrain[x][y], terrain[x][y]);
      rect(x*scl, y*scl, scl, scl);
    }
  }

  drawRoad();
}

public void drawRoad() {
  beginShape();
  colorMode(RGB, 255);

  fill(37, 44, 51);
  vertex(width/2, 0);
  vertex(width/2 + ROAD_WIDTH, 0);
  bezierVertex(80, 0, 80, 75, 30, 75);
  vertex(width/2, height);
  endShape();
}
  public void settings() {  size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day7" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
