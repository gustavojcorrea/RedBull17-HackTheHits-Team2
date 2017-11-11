// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

class KinectTracker {

  // Depth threshold
  int threshold = 745;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
  
  int boxSize = 20;
  
  float[] tileCenterX = {kinect.width*.125,kinect.width*.375,kinect.width*.625, kinect.width*.875,
                            kinect.width*.125,kinect.width*.375,kinect.width*.625, kinect.width*.875,
                            kinect.width*.125,kinect.width*.375,kinect.width*.625, kinect.width*.875};
                            
  float[] tileCenterY = {kinect.height*.15,kinect.height*.15,kinect.height*.15,kinect.height*.15,
                         kinect.height*.50,kinect.height*.50,kinect.height*.50,kinect.height*.50,
                         kinect.height*.83,kinect.height*.83,kinect.height*.83,kinect.height*.83};
    
   
  KinectTracker() {
    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    kinect.enableMirror(true);
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
  }

  void track() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      loc = new PVector(sumX/count, sumY/count);
    }

    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }

  void display() {
    PImage img = kinect.getDepthImage();

    // Being overly cautious here
    if (depth == null || img == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot of this is redundant, but this is just for demonstration purposes
    display.loadPixels();
    //for (int x = 0; x < kinect.width; x++) {
    //  for (int y = 0; y < kinect.height; y++) {

    //    int offset = x + y * kinect.width;
    //    // Raw depth
    //    int rawDepth = depth[offset];
    //    int pix = x + y * display.width;
    //    if (rawDepth < threshold) {
    //      // A red color instead
    //      display.pixels[pix] = color(150, 50, 50);
    //      //checkRegion(x,y);
    //    } 
    //    else {
    //      display.pixels[pix] = img.pixels[offset];
    //      display.pixels[pix] = color(255,255,255);
    //    }
    //  }
    //}
    
    
    
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {

        int offset = x + y * kinect.width;
        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * display.width;
        if (rawDepth < threshold) {
          // A red color instead
          display.pixels[pix] = color(150, 50, 50);
          //checkRegion(x,y);
          //checkBoundary(x,y);
          
          
          for(int i = 0; i < 12; i++){
            if ((x > tileCenterX[i]-boxSize) && (x < tileCenterX[i]+boxSize) && 
          (y > tileCenterY[i]-boxSize) && (y < tileCenterY[i]+boxSize)) {
            rectMode(CENTER);
            fill(255);
            rect(tileCenterX[i], tileCenterY[i],50,50);
            }
          }
    
        } 
        else {
          display.pixels[pix] = img.pixels[offset];
          display.pixels[pix] = color(255,255,255);
        }
      }
    }
     
    
    display.updatePixels();

    // Draw the image
    image(display, 0, 0);
  }

  void checkBoundary(int x, int y){
    
    for(int i = 0; i < 12; i++){
      
      if (x > tileCenterX[0]-boxSize && x < tileCenterX[0]+boxSize && 
        y > tileCenterY[0]-boxSize && y < tileCenterY[0]+boxSize) {
          rectMode(CENTER);
          fill(255);
          rect(tileCenterX[i], tileCenterY[i],50,50);
        }
    }
    
    //(1,1)
    //if((x > kinect.width*.18) && (x < kinect.width*.22) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.125, kinect.height*.15,50,50);
    //}
    ////(2,1)
    //if((x > kinect.width*.25) && (x < kinect.width*.5) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.375, kinect.height*.15,50,50);
    //}
    ////(3,1)
    //if((x > kinect.width*.5) && (x < kinect.width*.75) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.625, kinect.height*.15,50,50);
    //}
    
    ////(4,1)
    //if((x > kinect.width*.75) && (x < kinect.width) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.875, kinect.height*.15,50,50);
    //}
    
    
    //(1,2)
    //if((x > kinect.width*.18) && (x < kinect.width*.22) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.125, kinect.height*.15,50,50);
    //}
    ////(1,1)
    //if((x > kinect.width*.25) && (x < kinect.width*.5) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.375, kinect.height*.15,50,50);
    //}
    ////(3,1)
    //if((x > kinect.width*.5) && (x < kinect.width*.75) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.625, kinect.height*.15,50,50);
    //}
    
    ////(4,1)
    //if((x > kinect.width*.75) && (x < kinect.width) && (y < kinect.height*.66)){
    //  rectMode(CENTER);
    //  fill(255);
    //  rect(kinect.width*.875, kinect.height*.15,50,50);
    //}
    
    
    
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}