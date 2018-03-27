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

public class day1 extends PApplet {

Sun sun;
//Star mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
ArrayList<Star> stars;

public void setup() {
  
  sun = new Sun(112.0f/5, 333/2);

  // configure Stars within the system based on astromonical data
  // Star(float _radius, float _mass, float _distance, float _hue, float _saturation)
  stars = new ArrayList<Star>();

  // add mercury
  stars.add(new Star(3.8f/2, 0.0553f, 58/2, 345, 1.77f));

  // add venus
  stars.add(new Star(9.5f/2, 0.815f, 108/2, 37.5f, 3.72f));

  // add earth
  stars.add(new Star(10/2, 1, 150/2, 231.22f, 71.93f));

  // add mars
  stars.add(new Star(5.3f/2, 0.107f, 227/2, 6, 85.2f));

  // add jupiter
  stars.add(new Star(112/3, 317.83f, 779/3.5f, 22.82f, 42.26f));

  // add saturn
  stars.add(new Star(94.5f/3, 95.162f, 1428/4, 27.62f, 28.38f));

  // add uranus
  stars.add(new Star(40/3, 14.536f, 2974/6, 184.39f, 16.6f));

  // add neptune
  stars.add(new Star(38.8f/3, 17.147f, 4506/6, 223.14f, 72.55f));
}

public void draw() {
  colorMode(HSB, 360, 100, 100);
  // fill(0, 0, 13, 20);
  // rect(0, 0, width, height);
  background(0, 0, 13);
  smooth();
  sun.display();

  for (int i = 0; i < stars.size(); i++) {
    Star s = stars.get(i);
    PVector force = sun.attract(s);
    s.applyForce(force);
    s.update();
    s.display();
  }
}
class Star {
  float radius; // radius of the star
  float mass;    // Mass, tied to size
  float distance; // /distance from the sun
  float hue;
  float saturation;

  PVector position;   // position
  PVector velocity;
  PVector acceleration;

  Star(float _radius, float _mass, float _distance, float _hue, float _saturation) {
    mass = _mass;
    radius = _radius;
    distance = _distance;
    hue = _hue;
    saturation = _saturation;

    //float angle = random(0, TWO_PI);
    float angle = (PI/2);
    position = new PVector(cos(angle) * distance, sin(angle) * distance);
    acceleration = new PVector(0, 0);

    // calculate the velocity vector which is perpendicular to the position vector
    velocity = new PVector(
      position.x * cos(PI/2) + position.y * sin(PI/2),
      position.x * sin(PI/2) * -1 + position.y * cos(PI/2)
    );
    velocity.normalize();

    //velocity = new PVector(1, 0);
  }

  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  public void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  public void display() {
    float shadowOffset = (radius*2 * Utils.shadowMultiplier - radius*2)/4;

    colorMode(HSB, 360, 100, 100);
    noStroke();
    ellipseMode(CENTER);
    //translate(width/2, height/2);
    // println("Positions are: " + position.x + ", " + position.y);
    // println(radius*2 * Utils.shadowMultiplier);
    fill(hue, saturation, Utils.outerBrightness);
    ellipse(position.x, position.y, radius*2 * Utils.shadowMultiplier, radius*2 * Utils.shadowMultiplier);
    fill(hue, saturation, Utils.innerBrightness);
    ellipse(position.x - shadowOffset, position.y - shadowOffset, radius*2, radius*2);
  }
}
class Sun {
  float radius; // radius of the sun
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position

  Sun(float _radius, float _mass) {
    radius = _radius;
    mass = _mass;
    //position = new PVector(width/2,height/2);
    position = new PVector(0, 0);
    mass = 20;
    G = 1;
  }

  public PVector attract(Star s) {
    // // claculate the distance between two objects
    // float d = abs(PVector.dist(position, s.position));
    //
    // // limit the distance to eliminate "extreme" results for very close or very far objects
    // d = constrain(d,5.0,60.0);
    //
    // PVector force = s.velocity.copy();
    // force.normalize();
    // force.rotate(-1 * HALF_PI);
    //
    // // calculate the magnitude of the gravitational force
    // float strength = (G * mass * s.mass) / (d * d);
    // force.mult(strength);     // Get force vector --> magnitude * direction
    // return force;

    // Based on the example from the The Nature of Code
    // Credits: Daniel Shiffman

    // calculate the direction of force
    PVector force = PVector.sub(position,s.position);
    float d = force.mag();
    // limit the distance to eliminate "extreme" results for very close or very far objects
    d = constrain(d,5.0f,60.0f);
    force.normalize();
    float strength = (G * mass * s.mass) / (d * d);
    force.mult(strength);
    return force;
  }

  public void display() {
    float shadowOffset = (radius*2 * Utils.shadowMultiplier - radius*2)/4;

    colorMode(HSB, 360, 100, 100);
    noStroke();
    ellipseMode(CENTER);
    translate(width/2, height/2);
    fill(48.11f, 94.19f, Utils.outerBrightness);
    ellipse(position.x,position.y, radius*2 * Utils.shadowMultiplier, radius*2 * Utils.shadowMultiplier);
    fill(48.11f, 94.19f, Utils.innerBrightness);
    ellipse(position.x - shadowOffset, position.y - shadowOffset,radius*2, radius*2);
  }
}
// utilities classses for global variables between classese
public class Utils {

  public static final float shadowMultiplier = 1.15f;
  public static final float innerBrightness = 95;
  public static final float outerBrightness = 85;

}
  public void settings() {  size(1280,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "day1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
