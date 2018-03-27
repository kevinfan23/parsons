Sun sun;
//Star mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
ArrayList<Star> stars;

void setup() {
  size(1280,720);
  sun = new Sun(112.0/5, 333/2);

  // configure Stars within the system based on astromonical data
  // Star(float _radius, float _mass, float _distance, float _hue, float _saturation)
  stars = new ArrayList<Star>();

  // add mercury
  stars.add(new Star(3.8/2, 0.0553, 58/2, 345, 1.77));

  // add venus
  stars.add(new Star(9.5/2, 0.815, 108/2, 37.5, 3.72));

  // add earth
  stars.add(new Star(10/2, 1, 150/2, 231.22, 71.93));

  // add mars
  stars.add(new Star(5.3/2, 0.107, 227/2, 6, 85.2));

  // add jupiter
  stars.add(new Star(112/3, 317.83, 779/3.5, 22.82, 42.26));

  // add saturn
  stars.add(new Star(94.5/3, 95.162, 1428/4, 27.62, 28.38));

  // add uranus
  stars.add(new Star(40/3, 14.536, 2974/6, 184.39, 16.6));

  // add neptune
  stars.add(new Star(38.8/3, 17.147, 4506/6, 223.14, 72.55));
}

void draw() {
  colorMode(HSB, 360, 100, 100);
  // fill(0, 0, 13, 20);
  // rect(0, 0, width, height);
  background(0, 0, 13);
  smooth();
  sun.display();

  for (int i = 0; i < stars.size(); i++) {
    Star s = stars.get(i);
    PVector force = sun.attract(s);
    s.applyForce(force);
    s.update();
    s.display();
  }
}
