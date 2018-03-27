import processing.video.*;
// import processing.serial.*;

Capture video;

color trackColor;
float threshold = 25;

void setup(){
  fullScreen();
  video = new Capture(this, width, height);
  video.start();
  trackColor = color(255, 0 , 0);

  // setup serial port
//   String portName = Serial.list()[33];
//   myPort = new Serial(this, portName, 9600);
// }
}

void draw(){
  video.loadPixels();
  image(video, 0, 0);

  threshold = map(mouseX, 0, width, 0, 50);
  float avgX = 0;
  float avgY = 0;

  int count = 0;

  float mostRed = 500;
  int closestX = 0;
  int closestY = 0;
  for (int x = 0; x<video.width; x++){
    for(int y = 0; y<video.height; y++){
      int loc = x+y*video.width; //LOCATION OF PIXELS

      color currentColor = video.pixels[loc]; //Search Color
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);

      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = dist(r1, g1, b1, r2, g2, b2);
      if(d<threshold){
        mostRed = d;
        avgX +=x;
        avgY +=y;
        count ++;
      }
    }
  }

  if(count > 0){
    avgX = avgX/count;
    avgY = avgY/count;
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
  }
}

void mousePressed(){
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

void captureEvent(Capture video){
  video.read();
}
