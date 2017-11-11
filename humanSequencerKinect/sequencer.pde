//// Daniel Shiffman
//// Tracking the average location beyond a given depth threshold
//// Thanks to Dan O'Sullivan

//// https://github.com/shiffman/OpenKinect-for-Processing
//// http://shiffman.net/p5/kinect/

//import org.openkinect.freenect.*;
//import org.openkinect.processing.*;

////----------Start web stuff ------///
//import http.*;
//import java.util.Map;

//final int FIBONACCI = 1;
//final int SQUARE_ROOT = 2;
//final int WEBSERVICE_PORT = 8000;
//final String JSON_CONTENT_TYPE = "application/json";

//SimpleHTTPServer server;
//DynamicResponseHandler responder1, responder2;
////----------End web stuff ------///






//// The kinect stuff is happening in another class
//KinectTracker tracker;
//Kinect kinect;
//int winWidth = 800;
//int winHeight = 600;

//void setup() {
//  size(800, 600, P3D);
//  //size(kinect.width,kinect.height);
//  kinect = new Kinect(this);
//  tracker = new KinectTracker();
  
//  //-------web
//  startWebServices();
//}

//void draw() {
//  background(255);
//  //line(
//  // Run the tracking analysis
//  tracker.track();
//  // Show the image
//  tracker.display();
  
//  //drawGrid
//  drawGrid();
 
//  int t = 980;
//  tracker.setThreshold(t);
//  fill(0);
//  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
//    "UP increase threshold, DOWN decrease threshold" + "   " + "width: " + kinect.width + 
//    "   " + "height: " + kinect.height, 10, 500);
    
    
//}
//void drawGrid(){
//  //columns
//  stroke(204, 102, 0);
//  line(kinect.width/2,0,kinect.width/2,kinect.height);
//  line(kinect.width/4,0,kinect.width/4,kinect.height);
//  line(kinect.width*(.75),0,kinect.width*(.75),kinect.height);
  
//  //rows
//  line(0,kinect.height/3,kinect.width,kinect.height/3);
//  line(0,kinect.height*(.66),kinect.width,kinect.height*(.66));
//}


////------------------------------ web services  -------------------------

//void startWebServices() {
//  server.setLoggerLevel(java.util.logging.Level.INFO);
//  server = new SimpleHTTPServer(this, WEBSERVICE_PORT); //starts service on given port
//  TextResponse tr = new TextResponse(FIBONACCI);
//  responder1 = new DynamicResponseHandler(tr, JSON_CONTENT_TYPE);
 
//  responder2 = new DynamicResponseHandler(new TextResponse(SQUARE_ROOT), JSON_CONTENT_TYPE);
//  server.createContext("kinect", responder1); 
//  server.createContext("squareroot", responder2);
 
//}

//class TextResponse extends ResponseBuilder {
//  int type;

//  TextResponse(int type) {
//    this.type = type;
//  }

//  public  String getResponse(String requestBody) {
//    String output = "";
//    float start, end, value;
//    Map<String, String> queryMap = getQueryMap();    //get parameter map as string pairs
//    start = float(queryMap.getOrDefault("start", "0"));    //gets the value of the start parameter if present
//    end = float(queryMap.getOrDefault("end", "10"));
//    value = float(queryMap.getOrDefault("value", "4"));  //takes default value of 4 if not found
//    JSONObject json = new JSONObject();
//    switch (type) {
//    case FIBONACCI : 
//      //output = getFibonacciSeries(start, end);
//      output = getKinectData();
//      break;
//    case SQUARE_ROOT : 
//      output = getSquareRoot(value);
//      break;
//    default : 
//      output = "unknown type";
//    }
//    json.setString(getWebserviceName(type), output);
//    println("responded to webservice request on /" + getWebserviceName(type) + " with parameters: " + queryMap); 
//    return json.toString();  //note that javascript may require: return "callback(" + json.toString() + ")"
//  }
//}

//String getWebserviceName(int type) {
//  //returns the name of the web service
//  String serviceName;
//  switch (type) {
//  case FIBONACCI : 
//    serviceName = "kinect";
//    break;
//  case SQUARE_ROOT : 
//    serviceName = "squareroot";
//    break;
//  default : 
//    serviceName = "unknown (" + type + ")";
//  }
//  return serviceName;
//}

////--------------------- handlers ---------------------

//String getFibonacciSeries(float startOfRange, float endOfRange) {
//  //returns the Fibonacci series which occur within the set range
//  String output = "";
//  float value = 1, lastValue = 0, nextValue;
//  while (value < startOfRange) { 
//    nextValue = value + lastValue;
//    lastValue = value;
//    value = nextValue;
//  }
//  while (value <= endOfRange) {
//    output += output.length() > 0 ? ", " : ""; //comma separated list 
//    output += int(value);
//    nextValue = value + lastValue;
//    lastValue = value;
//    value = nextValue;
//  }
//  return output;
//}

//boolean sw = true;
//String getKinectData(){
  
//  return tracker.tileStatusOutput;
  
//  //if(sw == true) {
//  //    sw = false;
//  //    return "1,1,2,1,3,1,4,1";
//  //  } else {
//  //    sw = true;
//  //    return "1,2,2,3,2,3,4,2";
//  //  }
//}
//String getSquareRoot(float value) {
//  //returns the square root of the value
//  return str(sqrt(value));
//}