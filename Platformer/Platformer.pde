//Mark Ewert
//Jan 27

import fisica.*;
FWorld world;

//Pallette
color red             = #df2020;
color orange          = #df8020;
color yellow          = #dfdf20;
color lime            = #80df20;
color green           = #50df20;
color mint            = #20df50;
color cyan            = #20dfdf;
color blue            = #2080df;
color navy            = #2020df;
color purple          = #8020df;
color violet          = #df20df;
color pink            = #df2080;
color black           = #000000;
color grey            = #808080;
color white           = #ffffff;

//Game
final int PS = 80; //pixel size

//Players
FBox player1, player2;
float vx1, vy1, vx2, vy2;

//FBomb
FBomb bomb = null;

//Character Animation
PImage[] allSprites;
PImage[] runRight;
PImage[] runLeft;
PImage[] idle;
PImage[] jump;
PImage[] currentAction;
int frame;

ArrayList<FBox> boxList = new ArrayList<FBox>();

//Map
PImage map;
int x, y = 0;

boolean wKey, aKey, sKey, dKey; //keys for player1
boolean upKey, downKey, leftKey, rightKey; //keys for player2
boolean spaceKey;
//--------------------------------------------------------------------------------------------------------------------------
void setup() {
  //Basic
  fullScreen();
  textAlign(CENTER);
  textSize(28);

  //Initialize world
  Fisica.init(this);
  world = new FWorld(0, 0, 10000, 10000);
  world.setGravity(0, 1250);

  //map
  map = loadImage("Map.png");
  rectMode(CENTER);

  //Adds objects
  player1();
  player2();
  
  //Animation Arrays
  allSprites = new PImage[100];
  runRight   = new PImage[3];
  runLeft    = new PImage[3];
  idle       = new PImage[1];
  jump       = new PImage[1];

  //loads world
  while (y < map.height) {
    color c = map.get(x, y);
    if (c == black) {
      FBox b = new FBox(PS, PS);
      b.setName("ground");
      b.setFillColor(black);
      b.setPosition(x*PS+PS/2, y*PS+PS/2);
      b.setStatic(true);
      b.setGrabbable(false);
      b.setRestitution(0);
      b.setFriction(0);
      boxList.add(b);
      world.add(b);
    }
    x++;
    if (x == map.width) {
      x = 0;
      y++;
    }
  }
}//-------------------------------------------------------------------------------------------------------------------------

void draw() {
  //int tileX, tileY;
  //fill(white); 
  //text("(" + x + "," + y + ")", x*PS, y*PS);

  background(#799fec);

  pushMatrix();
  translate(-player1.getX() + width/2, -player1.getY() + height/2);
  world.step();
  world.draw();
  popMatrix();

  //player1 left-right movement
  vx1 = 0;
  if (aKey)  vx1 = -500;
  if (dKey)  vx1 = 500;
  player1.setVelocity(vx1, player1.getVelocityY());
  //player1 up-down movement
  ArrayList<FContact> contactList1 = player1.getContacts();
  for (FContact tempContact : contactList1) {
    if (wKey && player1.getVelocityY() == 0) {
      if (tempContact.contains("ground") || tempContact.contains(player2)) {
        player1.setVelocity(player1.getVelocityX(), -775);
      }
    }
  }
  //Drops down
  if (spaceKey && bomb == null){
    bomb = new FBomb();
   
  }
  if (bomb != null) bomb.act();


  //player2 left-right movement
  vx2 = 0;
  if (leftKey) vx2 = -500;
  if (rightKey) vx2 = 500;
  player2.setVelocity(vx2, player2.getVelocityY());
  //player2 up-down movement
  ArrayList<FContact> contactList2 = player2.getContacts();
  for (FContact tempContact : contactList2) {
    if (upKey && tempContact.contains("ground") && player2.getVelocityY() == 0) player2.setVelocity(player2.getVelocityX(), -775);
  }
}//-------------------------------------------------------------------------------------------------------------------------

void keyPressed() {
  if (key == 'w' || key == 'W') wKey = true;
  if (key == 'a' || key == 'A') aKey = true;
  if (key == 's' || key == 'S') sKey = true;
  if (key == 'd' || key == 'D') dKey = true;
  if (key == ' ' )          spaceKey = true;
  if (keyCode == UP)        upKey    = true;
  if (keyCode == LEFT)      leftKey  = true;
  if (keyCode == DOWN)      downKey  = true;
  if (keyCode == RIGHT)     rightKey = true;
}//----------------------------------------------------------------------------

void keyReleased() {
  if (key == 'w' || key == 'W') wKey = false;
  if (key == 'a' || key == 'A') aKey = false;
  if (key == 's' || key == 'S') sKey = false;
  if (key == 'd' || key == 'D') dKey = false;
  if (key == ' ' )          spaceKey = false;
  if (keyCode == UP)        upKey    = false;
  if (keyCode == LEFT)      leftKey  = false;
  if (keyCode == DOWN)      downKey  = false;
  if (keyCode == RIGHT)     rightKey = false;
}//----------------------------------------------------------------------------
