static final float RADIUS_STAR = 1;
color COLOR_STAR = color(81, 86, 89);

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

  void run(float angle) {
    update(angle);
    //display();
  }

  void update(float angle) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    display();
    popMatrix();
  }

  void display() {
    colorMode(RGB, 255);
    fill(COLOR_STAR);

    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x,position.y, radius*2, radius*2);
  }
}
