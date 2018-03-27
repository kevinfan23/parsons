static final float RADIUS_METEOR = 1.5;
static final float METEOR_SPEED = 10;
color COLOR_METEOR= color(81, 86, 89);

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

  void run() {
    update();
    display();
  }

  void update() {
    position.add(velocity);
  }

  void display() {
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
      i += 0.1;
    }
  }

  boolean isDead() {
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
