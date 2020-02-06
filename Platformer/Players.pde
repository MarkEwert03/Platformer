void player1() {
  player1 = new FBox(PS*.95, PS*.95);
  player1.setPosition(PS/2 + PS, PS*2);

  //Visuals
  player1.setFillColor(red);
  player1.setNoStroke();

  //Properties
  player1.setStatic(false);
  player1.setRestitution(0);
  player1.setGrabbable(false);
  player1.setRotatable(false);
  player1.setFriction(0);

  world.add(player1);
}//-------------------------------------------------------------------------------------

void player2() {
  player2 = new FBox(PS*.975, PS*.975);
  player2.setPosition(PS/2 + PS*20, PS*19);

  //Visuals
  player2.setFillColor(green);
  player2.setNoStroke();

  //Properties
  player2.setStatic(false);
  player2.setRestitution(0);
  player2.setGrabbable(false);
  player2.setRotatable(false);
  player2.setFriction(0);

  world.add(player2);
}//-------------------------------------------------------------------------------------
