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

public class day6 extends PApplet {

// remake of Tate Chow's Dribbble shot with Processing
// original post: https://dribbble.com/shots/2295564-Rain

static final int RAIN_COUNT = 20;

Drop [] rain;
ArrayList<Ripple> ripples;

public void setup() {
  
  colorMode(RGB, 255);
  background(253, 253, 253);

  rain = new Drop[50];

  for (int i = 0; i < RAIN_COUNT; i++) {
    rain[i] = new Drop();
  }

  ripples = new ArrayList<Ripple>();

}

public void draw() {
  background(24, 24, 24);

  int j, waveCount;
  waveCount = ripples.size();

  for (int i = 0; i < RAIN_COUNT; i++) {
    if (rain[i].isBottom()) {
      ripples.add(new Ripple(rain[i].position));
      rain[i].velocity.y *= -1;
      //rain[i] = new Drop();
    }
    if(rain[i].isDead()) {
      rain[i] = new Drop();
    }
    rain[i].run();
  }

  for(j = waveCount - 1; j > 0; j--) {
    Ripple ripple = (Ripple) ripples.get(j);
    if(ripple.make()) {
      ripples.remove(j);
    }
  }
}
// Rain drop class

// line properties
static final float LINE_ANGLE = HALF_PI/4;
static final float LINE_LENGTH = 70;
static final float LINE_WEIGHT = 2;
static final float LINE_SPEED = 5.5f;

// ripple properties
static final float RIPPLE_RATIO = 6;
static final float RIPPLE_TIME = 50;

static final float G = 0.1f;

class Drop {
  float len;
  float len_original;

  //float angle;
  float weight;
  float bottom;
  PVector position;
  PVector velocity;
  PVector acceleration;
  Ripple ripple;

  Drop() {
    len = random(LINE_LENGTH-2, LINE_LENGTH);
    len_original = len;
    //angle = ANGLE;
    weight = random(0.7f, 1);
    bottom = height - random(5, 10);
    position = new PVector(random(-300, width-300), random(-1000, 10));
    velocity = new PVector(1, sqrt(3));
    velocity.normalize();
    velocity.mult(LINE_SPEED);

    acceleration = new PVector(G*sin(LINE_ANGLE), G*cos(LINE_ANGLE));
  }

  public void run() {
    update();
    display();
    ripple();
  }

  public void update() {
    velocity.add(acceleration);
    if (velocity.y < 0) {
      velocity.mult(0.9f);
    }
    if (isBottom()) {
      len *= 0.5f;
    }
    position.add(velocity);
  }

  public void display() {
    // pushMatrix();
    // rotate(-1*LINE_ANGLE);
    stroke(255);
    strokeWeight(weight);

    if (velocity.y >= 0) {
      line(position.x, position.y, position.x + len*sin(LINE_ANGLE), position.y + len*cos(LINE_ANGLE));
    }
    else {
      //line(position.x, position.y, position.x + len*sin(LINE_ANGLE), position.y - len*cos(LINE_ANGLE));
      float diff = len_original - len;
      bezier(position.x, position.y, position.x + len*sin(LINE_ANGLE), position.y - len*cos(LINE_ANGLE), position.x + diff*sin(LINE_ANGLE), position.y - diff, position.x + (diff+50)*sin(LINE_ANGLE), position.y - diff);
      len -= 3;
    }

    // if (!isBottom()) {
    //   line(position.x, position.y, position.x + len*sin(LINE_ANGLE), position.y + len*cos(LINE_ANGLE));
    // }
    // else {
    //   if (velocity.y < 0) {
    //     line(position.x, position.y, position.x + len*sin(LINE_ANGLE), position.y - len*cos(LINE_ANGLE));
    //   }
    // }
    //popMatrix();
  }

  public boolean isBottom() {
    return ((position.y + len*cos(LINE_ANGLE)) >= bottom);
  }

  public boolean isDead() {
    return (len <= 0);
  }

  public void ripple() {
    if (isBottom()) {
      ripple = new Ripple(position);
    }
  }

}
/**
 * Click Wave
 *
 * @author Zheng-Xian Qiu
 * @date 2012-09-23
 */

class Ripple
{
   int waveBaseSize = 10;
   int waveSizeFix = 5;
   int waveAlphaFix = 20;
   int waveCount = 0;
   int loopCount = 255/waveAlphaFix;
   PVector position;

   Ripple(PVector location)
   {
     position = location.copy();
   }

   public boolean make()
   {
     int i;

     if(frameCount % 2 == 1) {
       waveCount++;
     }

     if(waveCount > loopCount) {
       return true;
     }

     int waveSize = waveBaseSize + waveSizeFix * waveCount;
     int waveAlpha = 255 - waveAlphaFix * waveCount;

     noFill();
     stroke(255, waveAlpha);
     strokeWeight(1);
     ellipse(position.x, position.y, waveSize, waveSize/5);

     return false;
   }
}
  public void settings() {  size(400, 300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day6" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
