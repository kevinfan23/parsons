static final float RADIUS_SUN = 2;
color COLOR_SUN = color(119, 123, 125);

class Sun {
  float radius; // radius of the sun
  PVector position;   // position

  Sun(PVector origin) {
    radius = RADIUS_SUN;
    position = origin.copy();
  }

  // void run() {
  //   pushMatrix();
  //   translate(width/2, height/2);
  //   rotate();
  //   popMatrix();
  // }

  void display() {
    colorMode(RGB, 255);
    fill(COLOR_SUN);

    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x,position.y, radius*2, radius*2);
  }
}
