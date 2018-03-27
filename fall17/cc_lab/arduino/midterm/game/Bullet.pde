final static int BULLET_SPEED = 15;
final static int BULLET_SIZE = 10;

PImage bullet_img;

class Bullet {
  // coordinates of player
  int x;
  int y;
  int facing;

  boolean isDead;

  Bullet(int _x, int _y, int _facing) {
    x = _x;
    y = _y;
    facing = _facing;

    bullet_img = loadImage("ice.png");
  }

  void run() {
    update();
    display();
  }

  void update() {
    switch(facing) {
      case LEFT:
        x -= BULLET_SPEED;
        break;
      case RIGHT:
        x += BULLET_SPEED;
        break;
      case UP:
        y -= BULLET_SPEED;
        break;
      case DOWN:
        y += BULLET_SPEED;
        break;
      case NONE:
        break;
      default:
        break;
    }
  }

  void display() {
    imageMode(CENTER);
    image(bullet_img, x, y, BULLET_SIZE, BULLET_SIZE);
  }
}
