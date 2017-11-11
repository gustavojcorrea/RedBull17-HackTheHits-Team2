// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

class KinectTracker {

  // Depth threshold
  int threshold = 990;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;

  // What we'll show the user
  PImage display;

  //offset from each tile's center to subtract
  int boxSize = 10;

  //tiles center x coord given width of kinect
  float[] tileCenterX = {kinect.width*.125, kinect.width*.375, kinect.width*.625, kinect.width*.875, 
    kinect.width*.125, kinect.width*.375, kinect.width*.625, kinect.width*.875, 
    kinect.width*.125, kinect.width*.375, kinect.width*.625, kinect.width*.875};

  //tiles center y coord given width of kinect
  float[] tileCenterY = {kinect.height*.15, kinect.height*.15, kinect.height*.15, kinect.height*.15, 
    kinect.height*.50, kinect.height*.50, kinect.height*.50, kinect.height*.50, 
    kinect.height*.83, kinect.height*.83, kinect.height*.83, kinect.height*.83};

  //num columns
  int numTiles = 12;

  //grid display array
  int[] tileStatus = new int[numTiles];
  int[] tileStatusPos = new int[numTiles];
  int numActiveTiles = 0;
  
  
  char[] tilesPreOutput = new char[16];
  String tileStatusOutput = "";
  
  //int ch1,ch2,ch3,ch4;
  
  


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
     for (int i = 0; i < 12; i++) {
          
              tileStatus[i] = 0;
              
        } 

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


          for (int i = 0; i < 12; i++) {
            if ((x > tileCenterX[i]-boxSize) && (x < tileCenterX[i]+boxSize) && 
              (y > tileCenterY[i]-boxSize) && (y < tileCenterY[i]+boxSize)) {
              rectMode(CENTER);
              fill(255);
              rect(tileCenterX[i], tileCenterY[i], 50, 50);
              tileStatus[i] = 1;
              
              //updateOutputString();
              updateGlobalOutput();
              //print(i);
            }
          }
        } else {
          display.pixels[pix] = img.pixels[offset];
          display.pixels[pix] = color(255, 255, 255);
        }
      }
    }


    display.updatePixels();

    // Draw the image
    image(display, 0, 0);
  }

  void updateGlobalOutput(){
    //char[] tilesPreOutput = new char[8];
    
    //int ch1 = getActiveCh(1);
    //int ch2 = getActiveCh(2);
    //int ch3 = getActiveCh(3);
    //int ch4 = getActiveCh(4);
    
    ////println("active chs: " + ch1 + " " + ch2 + " " + ch3 + " " + ch4);
    
    //char ch1x = getXval(ch1);
    //char ch1y = getYval(ch1);
    ////println("ch1 xy is: " + ch1x + " " + ch1y);
    
    //char ch2x = getXval(ch2);
    //char ch2y = getYval(ch2);
    ////println("ch2 xy is: " + ch2x + " " + ch2y);
    
    //char ch3x = getXval(ch3);
    //char ch3y = getYval(ch3);
    ////println("ch3 xy is: " + ch3x + " " + ch3y);
    //char ch4x = getXval(ch4);
    //char ch4y = getYval(ch4);
    ////println("ch4 xy is: " + ch4x + " " + ch4y);
    
    //tilesPreOutput[0] = ch1x;
    //tilesPreOutput[1] = ',';
    //tilesPreOutput[2] = ch1y;
    //tilesPreOutput[3] = ',';
    ////println(tilesPreOutput[0] + tilesPreOutput[1]); 
    
    
    //tilesPreOutput[4] = ch2x;
    //tilesPreOutput[5] = ',';
    //tilesPreOutput[6] = ch2y;
    //tilesPreOutput[7] = ',';
    
    //////println("ch2 is: " + tilesPreOutput[4] + " " + tilesPreOutput[6]);
    
    //tilesPreOutput[8] = ch3x;
    //tilesPreOutput[9] = ',';
    //tilesPreOutput[10] = ch3y;
    //tilesPreOutput[11] = ',';
    
    //tilesPreOutput[12] = ch4x;
    //tilesPreOutput[13] = ',';
    //tilesPreOutput[14] = ch4y;
    //tilesPreOutput[15] = ',';
    String response = "";
    for(int i = 0; i < 12; i++) {
      //response += tileStatus[i];
      if(tileStatus[i] == 1){
        response += (i % 4) + 1;
        response += ",";
        response += (i / 4)  + 1;
        response += ",";
      }
    }
    
    tileStatusOutput = response;
    //Output = new String(tilesPreOutput);
    println(response);
    
  }
  
  int getActiveCh(int ch){
    int output = 0;
    
    if( ch == 1){
       if( tileStatus[0] == 1)
         output= 0;
       else if( tileStatus[4] == 1)
         output= 4;
       else if( tileStatus[8] == 1)
         output= 8;
    }
    else if( ch == 2){
       if( tileStatus[1] == 1)
         output= 1;
       else if( tileStatus[5] == 1)
         output= 5;
       else if( tileStatus[9] == 1)
         output= 9;
    }
    else if( ch == 3){
       if( tileStatus[2] == 1)
         output= 2;
       else if( tileStatus[6] == 1)
         output= 6;
       else if( tileStatus[10] == 1)
         output= 10;
    }
    else if( ch == 4){
       if( tileStatus[3] == 1)
         output= 3;
       else if( tileStatus[7] == 1)
         output= 7;
       else if( tileStatus[11] == 1)
         output= 11;
    }
    
    
    return output;
  }
  //void updateOutputString(){
    
  //  int ctr = 0;
  //  numActiveTiles = 0;
    
  //  for(int i = 0; i < numTiles; ++i){
  //    if(tileStatus[i] == 1){
  //     //tileStatusPos[ctr] = i;
  //     //++numActiveTiles;

  //     int pos = i;
  //     int xCoord = getXval(i);
  //     int yCoord = getYval(i);
  //     tilesPreOutput[pos + 1] = char(getXval(i));
  //     tilesPreOutput[i + 1] = char(getXval(i));
       
  //     print(i);
  //     ctr = ctr + 4;;
  //    }
  //    else{
        
  //    }
  //  }
   
    
  //}
  
  char getXval(int pos){
    char output = 0;
    if(pos == 0 || pos == 4 || pos == 8){
      output = '1';
    }
    else if(pos == 1 || pos == 5 || pos == 9){
      output = '2';
    }
    else if(pos == 2 || pos == 6 || pos == 10){
      output = '3';
    }
    else if(pos == 3 || pos == 7 || pos == 11){
      output = '4';
    }
    
    return output;
  }
  
  char getYval(int pos){
    char output = 0;
    
    if(pos == 0 || pos == 1 || pos == 2 || pos == 3){
      output = '1';
    }
    else if(pos == 4 || pos == 5 || pos == 6 || pos == 7){
      output = '2';
    }
    else if(pos == 8 || pos == 9 || pos == 10 || pos == 11){
      output = '3';
    }
    
    return output;
  }
  
  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}