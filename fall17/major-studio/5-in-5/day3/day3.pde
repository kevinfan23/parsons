// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ParticleSystem ps;
Repeller repeller;

void setup() {
  size(700,700);
  ps = new ParticleSystem(new PVector(width/2, 100));
  repeller = new Repeller(width/2-20, height/2);
}

void draw() {
  colorMode(RGB, 255);
  background(33, 37, 43);
  ps.addParticle();

  // Apply gravity force to all Particles
  PVector gravity = new PVector(0,0.1);
  ps.applyForce(gravity);

  ps.applyRepeller(repeller);

  repeller.display();
  ps.run();
}
