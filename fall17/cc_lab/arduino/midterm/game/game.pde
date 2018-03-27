import processing.serial.*;

Serial myport;
Player player1;

PImage grass_img;
PImage rock_img;
PImage water_img;
PImage stone_img;

final static int NONE = -1;
final static int LEFT = 0;
final static int RIGHT = 1;
final static int UP = 2;
final static int DOWN = 3;

final static int TYPE_PLAYER = 0;
final static int TYPE_BULLET = 1;

final static int ELEMENT_SIZE = 50;

ArrayList<PVector> grassLoc = new ArrayList<PVector>();
ArrayList<PVector> stoneLoc = new ArrayList<PVector>();
ArrayList<PVector> rockLoc = new ArrayList<PVector>();
ArrayList<PVector> waterLoc = new ArrayList<PVector>();

// final static int NONE = -1;
// final static int LEFT = 0;
// final static int RIGHT = 1;
// final static int UP = 2;
// final static int DOWN = 3;

void setup() {
  size(1280, 750);
  colorMode(RGB);
  background(109, 131, 152);

  // Lisr all the available ports
  println(Serial.list());

  // select the incomming port
  String portName = Serial.list()[33];
  myport = new Serial(this, portName, 9600);

  // initiate player
  //player1 = new Player(round(random(0, width/2)), round(random(0, height)));
  player1 = new Player(200, 400);


  // load PImages
  grass_img = loadImage("grass.png");;
  rock_img = loadImage("rock.png");;
  water_img = loadImage("water.png");;
  stone_img = loadImage("stone.png");;

  // adding locations of elements
  // add grass locations
  grassLoc.add(new PVector(100, 50));
  grassLoc.add(new PVector(150, 50));
  grassLoc.add(new PVector(200, 50));
  grassLoc.add(new PVector(250, 50));
  grassLoc.add(new PVector(100, 90));
  grassLoc.add(new PVector(150, 90));
  grassLoc.add(new PVector(200, 90));
  grassLoc.add(new PVector(250, 90));
  grassLoc.add(new PVector(100, 130));
  grassLoc.add(new PVector(150, 130));
  grassLoc.add(new PVector(200, 130));
  grassLoc.add(new PVector(250, 130));
  grassLoc.add(new PVector(100, 170));
  grassLoc.add(new PVector(150, 170));

  grassLoc.add(new PVector(900, 400));
  grassLoc.add(new PVector(950, 400));
  grassLoc.add(new PVector(900, 440));
  grassLoc.add(new PVector(950, 440));
  grassLoc.add(new PVector(950, 480));
  grassLoc.add(new PVector(1000, 480));

  // add stone locations
  stoneLoc.add(new PVector(500, 500));
  stoneLoc.add(new PVector(500, 540));
  stoneLoc.add(new PVector(550, 500));

  stoneLoc.add(new PVector(600, 600));

  stoneLoc.add(new PVector(700, 300));
  stoneLoc.add(new PVector(750, 300));

  stoneLoc.add(new PVector(250, 550));
  stoneLoc.add(new PVector(250, 590));

  // add water locations
  waterLoc.add(new PVector(550, 180));
  waterLoc.add(new PVector(600, 180));
  waterLoc.add(new PVector(550, 220));
  waterLoc.add(new PVector(600, 220));

  waterLoc.add(new PVector(750, 580));
  waterLoc.add(new PVector(800, 580));
  waterLoc.add(new PVector(750, 620));
  waterLoc.add(new PVector(800, 620));

  // add rock locations
  rockLoc.add(new PVector(300, 350));

  rockLoc.add(new PVector(1100, 100));

}

void draw() {
  background(109, 131, 152);
  buildTerrain();

  for (int i = 0; i < player1.bullets.size(); i++) {
    if (!checkEdge(player1.bullets.get(i).x, player1.bullets.get(i).x, player1.bullets.get(i).facing, TYPE_BULLET)) {
      player1.bullets.remove(i);
      player1.bullet_num++;
    }
  }
  for (int i = 0; i < player1.bullets.size(); i++) {
    if (checkObstacle(player1.bullets.get(i).x, player1.bullets.get(i).x, player1.bullets.get(i).facing, TYPE_BULLET)) {
      player1.bullets.remove(i);
      player1.bullet_num++;
    }
  }
  player1.run();
}

void keyPressed() {
  if (key == ' ') {
    player1.shoot();
  }
}

void serialEvent(Serial myPort) {
  String val;
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');

      if(val!=null && val.contains("l")) {
        if (!checkObstacle(player1.x, player1.y, LEFT, TYPE_PLAYER)) {
          if (checkEdge(player1.x, player1.y, LEFT, TYPE_PLAYER)) {
            player1.update(LEFT);
          }
        }
        //println("left");
      }
      else if (val!=null && val.contains("r")) {
        if (!checkObstacle(player1.x, player1.y, RIGHT, TYPE_PLAYER)) {
          if (checkEdge(player1.x, player1.y, RIGHT, TYPE_PLAYER)) {
            player1.update(RIGHT);
          }
        }
        //println("right");
      }
      else if (val!=null && val.contains("u")) {
        if (!checkObstacle(player1.x, player1.y, UP, TYPE_PLAYER)) {
          if (checkEdge(player1.x, player1.y, UP, TYPE_PLAYER)) {
            player1.update(UP);
          }
        }
        //println("up");
      }
      else if (val!=null && val.contains("d")){
        if (!checkObstacle(player1.x, player1.y, DOWN, TYPE_PLAYER)) {
          if (checkEdge(player1.x, player1.y, DOWN, TYPE_PLAYER)) {
            player1.update(DOWN);
          }
        }
        //println("down");
      }
      else {
        player1.update(NONE);
        //println("none");
      }
  }
  else {
    player1.update(NONE);
    //println("none");
  }
}

boolean checkEdge(int _x, int _y, int dir, int type) {
  switch(dir) {
    case LEFT:
      if (type == TYPE_PLAYER) {
        if (_x - PLAYER_SPEED <= 0) {
          return true;
        }
        else
          return false;
      }
      else {
        if (_x - BULLET_SPEED <= 0) {
          return true;
        }
        else {
          return false;
        }
      }
    case RIGHT:
      if (type == TYPE_PLAYER) {
        if (_x + PLAYER_SPEED >= width) {
          return false;
        }
        else
          return true;
      }
      else {
        if (_x + BULLET_SPEED >= width) {
          return false;
        }
        else {
          return true;
        }
      }
    case UP:
      if (type == TYPE_PLAYER) {
        if (_y - PLAYER_SPEED <= 0) {
          return false;
        }
        else
          return true;
      }
      else {
        if (_y - BULLET_SPEED <= 0) {
          return false;
        }
        else {
          return true;
        }
      }
    case DOWN:
      if (type == TYPE_PLAYER) {
        if (_y + PLAYER_SPEED >= height) {
          return false;
        }
        else
          return true;
      }
      else {
        if (_y + BULLET_SPEED >= height) {
          return false;
        }
        else {
          return true;
        }
      }
    case NONE:
      return true;
    default:
      return false;
  }
}

boolean checkObstacle(int _x, int _y, int dir, int type) {
  switch(dir) {
    case LEFT:
      for (int i = 0; i < stoneLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_x - PLAYER_SPEED - stoneLoc.get(i).x) <= ELEMENT_SIZE/2 && abs(_y - stoneLoc.get(i).y) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_x - BULLET_SPEED - stoneLoc.get(i).x) <= 25 && abs(_y - stoneLoc.get(i).y) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      for (int i = 0; i < rockLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_x - PLAYER_SPEED - rockLoc.get(i).x) <= ELEMENT_SIZE/2 && abs(_y - rockLoc.get(i).y) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_x - BULLET_SPEED - rockLoc.get(i).x) <= 25 && abs(_y - rockLoc.get(i).y) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      return false;
    case RIGHT:
      for (int i = 0; i < stoneLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_x + PLAYER_SPEED - stoneLoc.get(i).x) <= ELEMENT_SIZE/2 && abs(_y - stoneLoc.get(i).y) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_x + BULLET_SPEED - stoneLoc.get(i).x) <= 25 && abs(_y - stoneLoc.get(i).y) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      for (int i = 0; i < rockLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_x + PLAYER_SPEED - rockLoc.get(i).x) <= ELEMENT_SIZE/2 && abs(_y - rockLoc.get(i).y) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_x + BULLET_SPEED - rockLoc.get(i).x) <= 25 && abs(_y - rockLoc.get(i).y) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      return false;
    case UP:
      for (int i = 0; i < stoneLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_y - PLAYER_SPEED - stoneLoc.get(i).y) <= ELEMENT_SIZE/2 && abs(_x - stoneLoc.get(i).x) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_y - BULLET_SPEED - stoneLoc.get(i).y) <= 25 && abs(_x - stoneLoc.get(i).x) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      for (int i = 0; i < rockLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_y - PLAYER_SPEED - rockLoc.get(i).y) <= ELEMENT_SIZE/2 && abs(_x - rockLoc.get(i).x) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_y - BULLET_SPEED - rockLoc.get(i).y) <= 25 && abs(_x - rockLoc.get(i).x) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      return false;
    case DOWN:
      for (int i = 0; i < stoneLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_y + PLAYER_SPEED - stoneLoc.get(i).y) <= ELEMENT_SIZE/2 && abs(_x - stoneLoc.get(i).x) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_y + BULLET_SPEED - stoneLoc.get(i).y) <= 25 && abs(_x - stoneLoc.get(i).x) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      for (int i = 0; i < rockLoc.size(); i++) {
        if (type == TYPE_PLAYER) {
          if (abs(_y + PLAYER_SPEED - rockLoc.get(i).y) <= ELEMENT_SIZE/2 && abs(_x - rockLoc.get(i).x) <= ELEMENT_SIZE/2 ) {
            return true;
          }
          else {
            return false;
          }
        }
        else {
          if (abs(_y + BULLET_SPEED - rockLoc.get(i).y) <= 25 && abs(_x - rockLoc.get(i).x) <= 25 ) {
            return true;
          }
          else {
            return false;
          }
        }
      }
      return false;
    case NONE:
      return false;
    default:
      return false;
  }
}

void buildTerrain() {
  imageMode(CENTER);

  // build grass
  for (int i = 0; i < grassLoc.size(); i++) {
    image(grass_img, grassLoc.get(i).x, grassLoc.get(i).y, ELEMENT_SIZE, ELEMENT_SIZE);
  }

  // build stonewall
  for (int i = 0; i < stoneLoc.size(); i++) {
    image(stone_img, stoneLoc.get(i).x, stoneLoc.get(i).y, ELEMENT_SIZE, ELEMENT_SIZE);
  }

  // build water
  for (int i = 0; i < waterLoc.size(); i++) {
    image(water_img, waterLoc.get(i).x, waterLoc.get(i).y, ELEMENT_SIZE, ELEMENT_SIZE);
  }

  // build rock
  for (int i = 0; i < rockLoc.size(); i++) {
    image(rock_img, rockLoc.get(i).x, rockLoc.get(i).y, ELEMENT_SIZE, ELEMENT_SIZE);
  }
}


// SERVER CODE
// import processing.net.*;
//
// Server s;
// Client c;
// String input;
// int data[];
//
// void setup() {
//   size(450, 255);
//   background(204);
//   stroke(0);
//   frameRate(5); // Slow it down a little
//   s = new Server(this, 12345);  // Start a simple server on a port
// }
// void draw() {
//   if (mousePressed == true) {
//     // Draw our line
//     stroke(255);
//     line(pmouseX, pmouseY, mouseX, mouseY);
//     // Send mouse coords to other person
//     s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
//   }
//
//   // Receive data from client
//   c = s.available();
//   if (c != null) {
//     input = c.readString();
//     input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
//     data = int(split(input, ' '));  // Split values into an array
//     // Draw line using received coords
//     stroke(0);
//     line(data[0], data[1], data[2], data[3]);
//   }
// }



// CLIENTs CODE
// import processing.net.*;
//
// Client c;
// String input;
// int data[];
//
// void setup() {
//   size(450, 255);
//   background(204);
//   stroke(0);
//   frameRate(5); // Slow it down a little
//   // Connect to the server’s IP address and port­
//   c = new Client(this, "127.0.0.1", 12345); // Replace with your server’s IP and port
// }
//
// void draw() {
//   if (mousePressed == true) {
//     // Draw our line
//     stroke(255);
//     line(pmouseX, pmouseY, mouseX, mouseY);
//     // Send mouse coords to other person
//     c.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
//   }
//
//   // Receive data from server
//   if (c.available() > 0) {
//     input = c.readString();
//     input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
//     data = int(split(input, ' '));  // Split values into an array
//     // Draw line using received coords
//     stroke(0);
//     line(data[0], data[1], data[2], data[3]);
//   }
// }
