/*IN FIERI

  main Processing sketch
*/

//imports
  import java.util.*;
  import processing.serial.*;
  import cc.arduino.*;
//Generic global variables
  color white, black;
  PVector center;
  boolean change = false;
//Global objects
  ArrayList<Shape> shapes;
  Arduino arduino;
//Pins and Inputs
  int pot = 0; //potentiometer on pin 0
  int switch1 = 8; //first switch on pin 3
  int switch2 = 9; //second switch on pin 5
  int switch3 = 10; //third switch on pin 7
  int switch4 = 11; //fourth switch on pin 9
  int[] switches = {switch1, switch2, switch3, switch4};

  float pv; //potentiometer value
  boolean[] sw = {false, false, false, false}; //array holding switch states
//Global/Default Property values
  int shapeHue = 150;
  float radius = height/6;
  float angle = 0.0;
  float strength = 0;
  float heading = 0.0;
  PVector velocity = new PVector(0,0);
  float padding = 100;
  int sides = 6;
  int mass = 1;
  float spin = 0;
  float offset = 0;
  int arrangement = 2; //default is GRID
  boolean arranged = false;
  int number = 1;

//Global property constants
  //ARRANGEMENTS
  final int NONE = 0; //add new shapes at center
  final int LINE = 1; //add new shapes behind previous
  final int GRID = 2; //arrange shapes in grid formation
  final int RADIAL = 3; //arrange shapes around center
  final int RANDOM = 4; //new shapes added in random location


//Global limits
  float minRadius = 15;
  float maxRadius;
  int maxShapes = 9;
  int maxSides = 10;
  float maxStrength = 1;
  float maxSpeed = 10;
  float maxSpin = 0.05;

void setup() {
  //general sketch settings
    size(displayWidth/2, displayHeight/2, P2D);
    colorMode(HSB, 360, 100, 100, 100);
    white = color(0,0,100,100);
    black = color(0,0,0,100);
    center = new PVector(width/2, height/2);
    maxRadius = height/6;
    background(white);
    noStroke();
    smooth();
  //initialize arraylist of shapes
    shapes = new ArrayList<Shape>();
    shapes.add(new Shape());
  //initialize arduino
    // println(Arduino.list()); //list serial ports
    String port = Arduino.list()[5]; //on wMac: 5 is tty.usb
    arduino = new Arduino(this, port, 57600);
  //set pin modes
    for (int i = 0; i < switches.length; ++i) {
      arduino.pinMode(switches[i], Arduino.INPUT);
    }
    arduino.pinMode(pot, Arduino.INPUT);
}

void draw () {
  motionBlur(white, 60); //set color and level of motion blur
  readInputs();  //read states of switches and value of potentiometer
  changeProperties(sw);
  applyForces();
  drawHUD();
  //grab snapshot/gif
  //post/store the above
  }


void keyReleased() {
    //SIZE
    if (key == 'q') {
      sw[0] = false;
    }
    //NUMBER
    if (key == 'w') {
      sw[1] = false;
    }
    //ANGLE
    if (key == 'e') {
      sw[2] = false;
    }
    //SPEED
    if (key == 'r') {
      sw[3] = false;
    }
    //PADDING
    if (key == 'a') {
      sw[0] = false;
      sw[1] = false;
    }
    //HEADING
    if (key == 's') {
      sw[0] = false;
      sw[2] = false;
    }
    //ATTRACTION
    if (key == 'd') {
      sw[0] = false;
      sw[3] = false;
    }
    //SHAPE
    if (key == 'f') {
      sw[1] = false;
      sw[2] = false;
    }
    //BOUNCE
    if (key == 'g') {
      sw[1] = false;
      sw[3] = false;
    }
    //SPIN
    if (key == 'h') {
      sw[2] = false;
      sw[3] = false;
    }
    //ARRANGEMENT
    if (key == 'z') {
      sw[0] = true;
      sw[1] = true;
      sw[2] = true;
    }
    //MASS
    if (key == 'x') {
      sw[0] = true;
      sw[1] = true;
      sw[3] = true;
    }
    //CENTER
    if (key == 'c') {
      sw[0] = true;
      sw[2] = true;
      sw[3] = true;
    }
    //WALLS
    if (key == 'v') {
      sw[1] = true;
      sw[2] = true;
      sw[3] = true;
    }
    //RANDOM
    if (key == 'b') {
      sw[0] = true;
      sw[1] = true;
      sw[2] = true;
      sw[3] = true;
    }
}