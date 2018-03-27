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

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
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
