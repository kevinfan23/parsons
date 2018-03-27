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

  PVector attract(Star s) {
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
    d = constrain(d,5.0,60.0);
    force.normalize();
    float strength = (G * mass * s.mass) / (d * d);
    force.mult(strength);
    return force;
  }

  void display() {
    float shadowOffset = (radius*2 * Utils.shadowMultiplier - radius*2)/4;

    colorMode(HSB, 360, 100, 100);
    noStroke();
    ellipseMode(CENTER);
    translate(width/2, height/2);
    fill(48.11, 94.19, Utils.outerBrightness);
    ellipse(position.x,position.y, radius*2 * Utils.shadowMultiplier, radius*2 * Utils.shadowMultiplier);
    fill(48.11, 94.19, Utils.innerBrightness);
    ellipse(position.x - shadowOffset, position.y - shadowOffset,radius*2, radius*2);
  }
}
