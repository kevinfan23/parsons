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

public class day5 extends PApplet {

static final int SUN_COUNT = 50;
static final int STAR_COUNT = 1000;
static final float ANGULAR_SPEED = 0.0002f;
static final float FRAME_DIVIDER = 80;

float angle = 0;

String textStr1 = "30 DAYS";
String textStr2 = "OF";
float strOffset = 57;
float lineHeight = 65;

String language = "P r o c e s s i n g";

int [] textColors = {
  color(246, 147, 51),
  color(242, 111, 84),
  color(238, 77, 122),
  color(160, 102, 170),
  color(79, 114, 183),
  color(11, 151, 172),
  color(0, 177, 153),
  color(109, 185, 129)
};

PFont font;
ArrayList<Sun> suns;
ArrayList<Star> stars;
ArrayList<Meteor> meteors;


public void setup() {
  

  // load custom fonts
  font = createFont("StratumNo1 Medium.ttf", 24);
  suns = new ArrayList<Sun>();
  stars = new ArrayList<Star>();
  meteors = new ArrayList<Meteor>();

  // generate static suns
  for (int i = 0; i < SUN_COUNT; i++) {
    suns.add(new Sun(new PVector(random(0, width), random(0, height))));
  }

  // generate moving stars
  for (int i = 0; i < STAR_COUNT; i++) {
    stars.add(new Star(new PVector(random(-width, width), random(-width, height))));
  }
}

public void draw() {
  colorMode(RGB, 255);
  rectMode(CORNER);
  fill(34, 41, 44, 70);
  rect(0, 0, width, height);
  //background(34, 41, 44);
  smooth();

  for (Sun s: suns) {
    s.display();
  }

  for (Star st: stars) {
    st.run(angle);
  }

  if (frameCount%FRAME_DIVIDER == 0) {
    meteors.add(new Meteor(new PVector(random(0, width), random(0, height))));
  }

  for (int i = 0; i < meteors.size(); i++) {
    Meteor m = meteors.get(i);
    if (m.isDead()) {
      meteors.remove(i);
    }
  }

  for (int i = 0; i < meteors.size(); i++) {
    Meteor m = meteors.get(i);
    m.run();
  }

  //printLogo();

  // update moving stars's rotational angle
  angle += ANGULAR_SPEED;
}

public void printLogo() {
  // set color mode
  colorMode(RGB, 255);
  textAlign(CENTER);
  float strStart = width/2 - strOffset*3;

  // print "30 days"
  for (int i = 0; i < textStr1.length(); i++) {
    char s = textStr1.charAt(i);
    fill(textColors[i]);
    textFont(font, (100));
    text(s, strStart + i*strOffset, height/2 - lineHeight);
  }

  // print "of"
  fill(136, 136, 136);
  textFont(font, (30));
  text("o f".toUpperCase(), width/2, height/2);

  // print "Processing"
  fill(255);
  textFont(font, (35));
  text(language.toUpperCase(), width/2, height/2 + lineHeight);
}
static final float RADIUS_METEOR = 1.5f;
static final float METEOR_SPEED = 10;
int COLOR_METEOR= color(81, 86, 89);

class Meteor {
  float radius; // radius of the sun
  PVector position;   // position
  PVector velocity;   // position
  float lifeSpan = 0;

  Meteor(PVector origin) {
    radius = RADIUS_METEOR;
    position = origin.copy();
    velocity = new PVector(random(-1, 1), random(-1, 1));
    velocity.normalize();
    velocity.mult(METEOR_SPEED);
  }

  // void run() {
  //   pushMatrix();
  //   translate(width/2, height/2);
  //   rotate();
  //   popMatrix();
  // }

  public void run() {
    update();
    display();
  }

  public void update() {
    position.add(velocity);
  }

  public void display() {
    colorMode(RGB, 255);
    noStroke();

    ellipseMode(CENTER);

    // fill(255);
    // ellipse(position.x,position.y, radius*2, radius*2);

    for (float i = 0; i < RADIUS_METEOR;) {
      //fill(81, 86, 89, map(i, 0, RADIUS_METEOR, 0, 255));
      //ellipse(position.x,position.y, radius*2, radius*2);
      fill(255, map(i, 0, RADIUS_METEOR, 100, 255));
      ellipse(position.x, position.y, i*2, i*2);
      i += 0.1f;
    }
  }

  public boolean isDead() {
    if (position.y >= height || position.y <= 0) {
      return true;
    }
    else if (position.x >= width || position.x <= 0) {
      return true;
    }
    else {
      return false;
    }
  }
}
static final float RADIUS_STAR = 1;
int COLOR_STAR = color(81, 86, 89);

class Star {
  float radius; // radius of the sun
  PVector position;   // position

  Star(PVector origin) {
    radius = RADIUS_STAR;
    position = origin.copy();
  }

  // void run() {
  //   pushMatrix();
  //   translate(width/2, height/2);
  //   rotate();
  //   popMatrix();
  // }

  public void run(float angle) {
    update(angle);
    //display();
  }

  public void update(float angle) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    display();
    popMatrix();
  }

  public void display() {
    colorMode(RGB, 255);
    fill(COLOR_STAR);

    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x,position.y, radius*2, radius*2);
  }
}
static final float RADIUS_SUN = 2;
int COLOR_SUN = color(119, 123, 125);

class Sun {
  float radius; // radius of the sun
  PVector position;   // position

  Sun(PVector origin) {
    radius = RADIUS_SUN;
    position = origin.copy();
  }

  // void run() {
  //   pushMatrix();
  //   translate(width/2, height/2);
  //   rotate();
  //   popMatrix();
  // }

  public void display() {
    colorMode(RGB, 255);
    fill(COLOR_SUN);

    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x,position.y, radius*2, radius*2);
  }
}
  public void settings() {  size(1280,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
