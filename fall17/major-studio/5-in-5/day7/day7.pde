static final float HUE = 110;
static final float ROAD_WIDTH = 110;

int cols, rows;
int scl = 10;
int w = 1280;
int h = 720;

float[][] terrain;
float[][] trees;

void setup() {
  size(1280, 720);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];

  float xoff = 0;

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff), 0, 1, 0, 50);
      xoff += 0.2;
    }
  }
}

void draw() {
  background(0);

  for (int y = 0; y < rows -1; y++) {
    for (int x = 0; x < cols; x++) {
      colorMode(HSB, 360, 100, 100);
      noStroke();

      fill(HUE, terrain[x][y], terrain[x][y]);
      rect(x*scl, y*scl, scl, scl);
    }
  }

  drawRoad();
}

void drawRoad() {
  beginShape();
  colorMode(RGB, 255);

  fill(37, 44, 51);
  vertex(width/2, 0);
  vertex(width/2 + ROAD_WIDTH, 0);
  bezierVertex(80, 0, 80, 75, 30, 75);
  vertex(width/2, height);
  endShape();
}
