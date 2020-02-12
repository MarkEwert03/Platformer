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
PImage[] runLeft  = new PImage[2];
PImage[] runRight = new PImage[2];
PImage[] idle     = new PImage[2];
PImage[] jump     = new PImage[2];
PImage[] currentAction  = new PImage[2];
PImage[] previousAction = new PImage[2];
int frame, costumeNumber;

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
  runLeft[0]   = loadImage("Sprites/Run Left 0.png");
  runLeft[1]   = loadImage("Sprites/Run Left 1.png");
  runRight[0]  = loadImage("Sprites/Run Right 0.png");
  runRight[1]  = loadImage("Sprites/Run Right 1.png");
  idle[0]      = loadImage("Sprites/Idle Left.png");
  idle[1]      = loadImage("Sprites/Idle Right.png");
  jump[0]      = loadImage("Sprites/Jump Left.png");
  jump[1]      = loadImage("Sprites/Jump Right.png");
  currentAction = idle;

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

  background(white);

  pushMatrix();
  translate(-player1.getX() + width/2, -player1.getY() + height/2);
  world.step();
  world.draw();
  popMatrix();

  //player1 left-right movement
  vx1 = 0;
  if (aKey) {
    vx1 = -500;
    if (player1.getVelocityY() == 0) {
      currentAction = runLeft;
      previousAction = runLeft;
    }
  }
  if (dKey) {
    vx1 = 500;
    if (player1.getVelocityY() == 0) {
      currentAction = runRight;
      previousAction = runRight;
    }
  }
  player1.setVelocity(vx1, player1.getVelocityY());

  //player1 up-down movement
  ArrayList<FContact> contactList1 = player1.getContacts();
  for (FContact tempContact : contactList1) {
    if (wKey && player1.getVelocityY() == 0) {
      if (tempContact.contains("ground") || tempContact.contains(player2)) {
        player1.setVelocity(player1.getVelocityX(), -775);
        currentAction = jump;
        if (player1.getVelocityX() < 0) costumeNumber = 0;
        else if (player1.getVelocityY() > 0) costumeNumber = 1;
      }
    }
  }

  //idle
  if (player1.getVelocityX() == 0 && player1.getVelocityY() == 0) {
    currentAction = idle;
  }

  //player1 drops bomb
  if (spaceKey && bomb == null) {
    bomb = new FBomb();
  }
  //bomb acts
  if (bomb != null) bomb.act();

  //Loops through animation
  player1.attachImage(currentAction[costumeNumber]);
  if (currentAction == runLeft || currentAction == runRight) {
    if (frameCount % 10 == 0) {
      costumeNumber++;
      if (costumeNumber >= currentAction.length) {
        costumeNumber = 0;
      }
    }
  } else if (previousAction == runLeft){
    costumeNumber = 0;
  } else if (previousAction == runRight){
   costumeNumber = 1; 
  }

  //player2 left-right movement
  vx2 = 0;
  if (leftKey) {
    vx2 = -500;
    currentAction = runLeft;
    costumeNumber = 0;
  }
  if (rightKey) {
    vx2 = 500;
    currentAction = runLeft;
    costumeNumber = 0;
  }
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
