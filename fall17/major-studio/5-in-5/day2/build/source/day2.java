import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Iterator; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class day2 extends PApplet {

ParticleSystem ps;

public void setup() {
  
  colorMode(RGB, 255);
  ps = new ParticleSystem();
  background(38, 42, 49);
}

public void draw() {
  colorMode(RGB, 255);
  background(38, 42, 49);

  if (frameCount%13 == 0) {
    ps.addParticles(new PVector(random(0+50, width-50), random(0+50, height-50)));
  }
  ps.run();

}
static final int SATURATION = 150;
static final int BRIGHTNESS = 255;
static final float DAMPING = 0.9f;
static final float SIZE_MIN = 20.0f;
static final float SIZE_MAX = 35.0f;
static final float SPEED_MIN = 10.0f;
static final float SPEED_MAX = 20.0f;


class Particle {
  float radius;
  float hue;
  PVector position;
  PVector velocity;

  Particle(PVector origin) {
    radius = random(SIZE_MIN, SIZE_MAX);
    position = new PVector(origin.x + random(-5, 5), origin.y + random(-5, 5));

    hue = random(10, 250);

    float angle = random(0, TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    velocity.normalize();
    velocity.mult(random(SPEED_MIN, SPEED_MAX));
  }

  public void run() {
    update();
    display();
  }

  public void update() {
    velocity.mult(DAMPING);
    position.add(velocity);
    radius *= DAMPING;
  }

  public void display() {
    colorMode(HSB, 255);
    noStroke();
    smooth();
    ellipseMode(CENTER);

    fill(hue, SATURATION, BRIGHTNESS);
    ellipse(position.x, position.y, radius*2, radius*2);
  }

  public boolean isDead() {
    return (radius <= 1);
  }
}


static final float SYSTEM_SIZE_MIN = 20.0f;
static final float SYSTEM_SIZE_MAX = 30.0f;

class ParticleSystem {
  ArrayList<Particle> particles;
  int size;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    size = round(random(SYSTEM_SIZE_MIN, SYSTEM_SIZE_MAX));
  }

  public void addParticles(PVector origin) {
    for (int i = 0; i < size; i++) {
      particles.add(new Particle(origin));
    }
  }

  public void run() {
    Iterator<Particle> it =
        particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}
  public void settings() {  size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
