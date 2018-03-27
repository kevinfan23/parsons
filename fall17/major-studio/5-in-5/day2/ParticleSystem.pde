import java.util.Iterator;

static final float SYSTEM_SIZE_MIN = 20.0;
static final float SYSTEM_SIZE_MAX = 30.0;

class ParticleSystem {
  ArrayList<Particle> particles;
  int size;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    size = round(random(SYSTEM_SIZE_MIN, SYSTEM_SIZE_MAX));
  }

  void addParticles(PVector origin) {
    for (int i = 0; i < size; i++) {
      particles.add(new Particle(origin));
    }
  }

  void run() {
    Iterator<Particle> it =
        particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}
