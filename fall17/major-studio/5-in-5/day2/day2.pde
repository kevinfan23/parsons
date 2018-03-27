ParticleSystem ps;

void setup() {
  size(1280, 720);
  colorMode(RGB, 255);
  ps = new ParticleSystem();
  background(38, 42, 49);
}

void draw() {
  colorMode(RGB, 255);
  background(38, 42, 49);

  if (frameCount%13 == 0) {
    ps.addParticles(new PVector(random(0+50, width-50), random(0+50, height-50)));
  }
  ps.run();

}
