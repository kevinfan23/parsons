static final int SATURATION = 150;
static final int BRIGHTNESS = 255;
static final float DAMPING = 0.9;
static final float SIZE_MIN = 20.0;
static final float SIZE_MAX = 35.0;
static final float SPEED_MIN = 10.0;
static final float SPEED_MAX = 20.0;


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

  void run() {
    update();
    display();
  }

  void update() {
    velocity.mult(DAMPING);
    position.add(velocity);
    radius *= DAMPING;
  }

  void display() {
    colorMode(HSB, 255);
    noStroke();
    smooth();
    ellipseMode(CENTER);

    fill(hue, SATURATION, BRIGHTNESS);
    ellipse(position.x, position.y, radius*2, radius*2);
  }

  boolean isDead() {
    return (radius <= 1);
  }
}
