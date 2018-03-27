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

public class day3 extends PApplet {

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ParticleSystem ps;
Repeller repeller;

public void setup() {
  
  ps = new ParticleSystem(new PVector(width/2, 100));
  repeller = new Repeller(width/2-20, height/2);
}

public void draw() {
  colorMode(RGB, 255);
  background(33, 37, 43);
  ps.addParticle();

  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1f);
  ps.applyForce(gravity);

  ps.applyRepeller(repeller);

  repeller.display();
  ps.run();
}
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  float mass = 1; // Let's do something better here!

  Particle(PVector l) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0f;
  }

  public void run() {
    update();
    display();
  }

  public void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }

  // Method to update position
  public void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 1.0f;
  }

  // Method to display
  public void display() {
    stroke(116, 73, 183,lifespan);
    strokeWeight(3);
    fill(167, 110, 247, lifespan);
    ellipse(position.x,position.y,12,12);
  }

  // Is the particle still useful?
  public boolean isDead() {
    if (lifespan < 0.0f) {
      return true;
    } else {
      return false;
    }
  }
}
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  public void addParticle() {
    particles.add(new Particle(origin));
  }

  // A function to apply a force to all Particles
  public void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  public void applyRepeller(Repeller r) {
    for (Particle p: particles) {
      PVector force = r.repel(p);        
      p.applyForce(force);
    }
  }


  public void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


static final float shape_width = 120;
static final float shape_height = 120;
static final float heightOffset = 90;


// A very basic Repeller class
class Repeller {

  // Gravitational Constant
  float G = 100;
  // position
  PVector position;
  float r = 10;

  Repeller(float x, float y)  {
    position = new PVector(x,y);
  }

  public void display() {
    stroke(255);
    strokeWeight(5);
    noFill();
    triangle(
      position.x - shape_width/2, position.y + shape_height/3 + heightOffset,
      position.x, position.y - (shape_height*2)/3 + heightOffset,
      position.x + shape_width/2, position.y + shape_height/3 + heightOffset
    );
    //ellipse(position.x,position.y,48,48);
  }

  // Calculate a force to push particle away from repeller
  public PVector repel(Particle p) {
    PVector dir = PVector.sub(position,p.position);      // Calculate direction of force
    float d = dir.mag();                       // Distance between objects
    dir.normalize();                           // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    d = constrain(d,5,100);                    // Keep distance within a reasonable range
    float force = -1 * G / (d * d);            // Repelling force is inversely proportional to distance
    dir.mult(force);                           // Get force vector --> magnitude * direction
    return dir;
  }
}
  public void settings() {  size(700,700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
