static final int SUN_COUNT = 50;
static final int STAR_COUNT = 1000;
static final float ANGULAR_SPEED = 0.0002;
static final float FRAME_DIVIDER = 100;

float angle = 0;

String textStr1 = "30 DAYS";
String textStr2 = "OF";
float strOffset = 57;
float lineHeight = 65;

String language = "P r o c e s s i n g";

color [] textColors = {
  color(246, 147, 51),
  color(242, 111, 84),
  color(238, 77, 122),
  color(160, 102, 170),
  color(79, 114, 183),
  color(11, 151, 172),
  color(0, 177, 153),
  color(109, 185, 129)
};

PFont font;
ArrayList<Sun> suns;
ArrayList<Star> stars;
ArrayList<Meteor> meteors;


void setup() {
  size(1280,720);

  // load custom fonts
  font = createFont("StratumNo1 Medium.ttf", 24);
  suns = new ArrayList<Sun>();
  stars = new ArrayList<Star>();
  meteors = new ArrayList<Meteor>();

  // generate static suns
  for (int i = 0; i < SUN_COUNT; i++) {
    suns.add(new Sun(new PVector(random(0, width), random(0, height))));
  }

  // generate moving stars
  for (int i = 0; i < STAR_COUNT; i++) {
    stars.add(new Star(new PVector(random(-width, width), random(-width, height))));
  }
}

void draw() {
  colorMode(RGB, 255);
  rectMode(CORNER);
  fill(34, 41, 44, 70);
  rect(0, 0, width, height);
  //background(34, 41, 44);
  smooth();

  for (Sun s: suns) {
    s.display();
  }

  for (Star st: stars) {
    st.run(angle);
  }

  if (frameCount%FRAME_DIVIDER == 0) {
    meteors.add(new Meteor(new PVector(random(0, width), random(0, height))));
  }

  for (int i = 0; i < meteors.size(); i++) {
    Meteor m = meteors.get(i);
    if (m.isDead()) {
      meteors.remove(i);
    }
  }

  for (int i = 0; i < meteors.size(); i++) {
    Meteor m = meteors.get(i);
    m.run();
  }

  printLogo();

  // update moving stars's rotational angle
  angle += ANGULAR_SPEED;
}

void printLogo() {
  // set color mode
  colorMode(RGB, 255);
  textAlign(CENTER);
  float strStart = width/2 - strOffset*3;

  // print "30 days"
  for (int i = 0; i < textStr1.length(); i++) {
    char s = textStr1.charAt(i);
    fill(textColors[i]);
    textFont(font, (100));
    text(s, strStart + i*strOffset, height/2 - lineHeight);
  }

  // print "of"
  fill(136, 136, 136);
  textFont(font, (30));
  text("o f".toUpperCase(), width/2, height/2);

  // print "Processing"
  fill(255);
  textFont(font, (35));
  text(language.toUpperCase(), width/2, height/2 + lineHeight);
}
