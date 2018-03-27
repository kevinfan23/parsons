final static int PLAYER_SPEED = 10;
final static int PLAYER_HEALTH = 3;
final static int PLAYER_BULLET = 5;

PImage left_img;
PImage right_img;
PImage up_img;
PImage down_img;

class Player {
  // coordinates of player
  int x;
  int y;
  int facing;

  int bullet_num;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  PImage avatar;

  int health;

  Player(int _x, int _y) {
    x = _x;
    y = _y;
    facing = RIGHT;
    bullet_num = PLAYER_BULLET;

    left_img = loadImage("player/left.png");
    right_img = loadImage("player/right.png");
    up_img = loadImage("player/up.png");
    down_img = loadImage("player/down.png");

    avatar = right_img;
  }

  void run() {
    //update(dir);
    display();

    // display bullets
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).run();
    }
  }

  void update(int dir) {
    switch(dir) {
      case LEFT:
        x -= PLAYER_SPEED;
        facing = LEFT;
        avatar = left_img;
        break;
      case RIGHT:
        x += PLAYER_SPEED;
        facing = RIGHT;
        avatar = right_img;
        break;
      case UP:
        y -= PLAYER_SPEED;
        facing = UP;
        avatar = up_img;
        break;
      case DOWN:
        y += PLAYER_SPEED;
        facing = DOWN;
        avatar = down_img;
        break;
      case NONE:
        break;
      default:
        break;
    }
  }

  void display() {
    imageMode(CENTER);
    image(avatar, x, y);
    // rectMode(CENTER);
    // noStroke();
    // fill(255);
    // rect(x, y, 20, 20);
  }

  void shoot() {
    if (bullet_num >= 0) {
      bullets.add(new Bullet(x, y, facing));
      //println("shot");
      bullet_num--;
    }
  }
}
