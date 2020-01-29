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
final int PS = 36; //pixel size

//Players
FBox player1, player2;
float vx1, vy1, vx2, vy2;

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

  //Initialize world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);

  //Adds objects
  player1();
  player2();

  //map
  map = loadImage("Map.png");
  rectMode(CENTER);

  //loads world
  while (y < map.height) {
    color c = map.get(x, y);
    if (c == black) {
      FBox b = new FBox(PS, PS);
      b.setFillColor(black);
      b.setPosition(x*PS+PS/2, y*PS+PS/2);
      b.setStatic(true);
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
  background(#799fec);

  world.step();
  world.draw();

  //player1 left-right movement
  vx1 = 0;
  if (aKey)  vx1 = -250;
  if (dKey)  vx1 = 250;
  player1.setVelocity(vx1, player1.getVelocityY());
  //player1 up-down movement
  ArrayList<FContact> contactList1 = player1.getContacts();
  if (wKey && contactList1.size() > 0) player1.setVelocity(player1.getVelocityX(), -250);
  
  //player2 left-right movement
  vx2 = 0;
  if (leftKey) vx2 = -250;
  if (rightKey) vx2 = 250;
  player2.setVelocity(vx2, player2.getVelocityY());
  //player2 up-down movement
  ArrayList<FContact> contactList2 = player2.getContacts();
  if (upKey && contactList2.size() > 0) player2.setVelocity(player2.getVelocityX(), -250);
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
