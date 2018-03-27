import processing.video.*;
// import de.voidplus.leapmotion.*;

Capture video;



void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);

    }}
  video = new Capture(this, 640, 480);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

    // The camera can be initialized directly using an
    // element from the array returned by list():

  background(255);

  // Tinting using mouse location
  tint(mouseX, mouseY, 255);

  // A video image can also be moved, rotated, tinted, resized just as with a PImage.
  translate(width/2,height/2);
  imageMode(CENTER);
  image(video, 0, 0, width, height);
  filter(POSTERIZE, 10);
  filter(BLUR, 10);
}

// // Size of each cell in the grid, ratio of window size to video size
// int videoScale = 8;
// // Number of columns and rows in our system
// int cols, rows;
// // Variable to hold onto Capture object
//
// void setup() {
//   size(640, 480);
//
//   // Initialize columns and rows
//   cols = width / videoScale;
//   rows = height / videoScale;
//   video = new Capture(this, 80, 60);
//   video.start();
// }
//
// void captureEvent(Capture video) {
//   // Read image from the camera
//   video.read();
// }
//
// void draw() {
//
//   video.loadPixels();
//
//   // Begin loop for columns
//   for (int i = 0; i < cols; i++) {
//     // Begin loop for rows
//     for (int j = 0; j < rows; j++) {
//
//       // Where are we, pixel-wise?
//       int x = i * videoScale;
//       int y = j * videoScale;
//       // Looking up the appropriate color in the pixel array
//       color c = video.pixels[i + j * video.width];
//       fill(c);
//
//       stroke(0);
//       rect(x, y, videoScale, videoScale);
//     }
//   }
// }
//
// void mouseMoved() {
//   fill(255, 255, 255, 100);
//   rect(mouseX, mouseY, videoScale, videoScale);
// }
