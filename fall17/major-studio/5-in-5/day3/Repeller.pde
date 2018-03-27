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

  void display() {
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
  PVector repel(Particle p) {
    PVector dir = PVector.sub(position,p.position);      // Calculate direction of force
    float d = dir.mag();                       // Distance between objects
    dir.normalize();                           // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    d = constrain(d,5,100);                    // Keep distance within a reasonable range
    float force = -1 * G / (d * d);            // Repelling force is inversely proportional to distance
    dir.mult(force);                           // Get force vector --> magnitude * direction
    return dir;
  }
}
