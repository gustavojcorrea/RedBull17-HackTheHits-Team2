// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
int winWidth = 800;
int winHeight = 600;

void setup() {
  size(800, 600, P3D);
  //size(kinect.width,kinect.height);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
}

void draw() {
  background(255);
  //line(
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  
  //drawGrid
  drawGrid();
 
  
  
  //// Let's draw the raw location
  //PVector v1 = tracker.getPos();
  //fill(50, 100, 250, 200);
  //noStroke();
  //ellipse(v1.x, v1.y, 20, 20);

  //// Let's draw the "lerped" location
  //PVector v2 = tracker.getLerpedPos();
  //fill(100, 250, 50, 200);
  //noStroke();
  //ellipse(v2.x, v2.y, 20, 20);

  // Display some info
  //int t = tracker.getThreshold();
  int t = 980;
  tracker.setThreshold(t);
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}
void drawGrid(){
  //columns
  stroke(204, 102, 0);
  line(kinect.width/2,0,kinect.width/2,kinect.height);
  line(kinect.width/4,0,kinect.width/4,kinect.height);
  line(kinect.width*(.75),0,kinect.width*(.75),kinect.height);
  
  //rows
  line(0,kinect.height/3,kinect.width,kinect.height/3);
  line(0,kinect.height*(.66),kinect.width,kinect.height*(.66));
}
// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}