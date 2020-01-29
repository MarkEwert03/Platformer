void player1() {
  player1 = new FBox(PS, PS);
  player1.setPosition(PS*2, PS*2);

  //Visuals
  player1.setFillColor(red);
  player1.setNoStroke();

  //Properties
  player1.setStatic(false);
  player1.setRestitution(0.2);
  player1.setGrabbable(false);
  player1.setRotatable(false);

  world.add(player1);
}//-------------------------------------------------------------------------------------

void player2() {
  player2 = new FBox(PS, PS);
  player2.setPosition(PS*4, PS*2);

  //Visuals
  player2.setFillColor(green);
  player2.setNoStroke();

  //Properties
  player2.setStatic(false);
  player2.setRestitution(0.2);
  player2.setGrabbable(false);
  player1.setRotatable(false);

  world.add(player2);
}//-------------------------------------------------------------------------------------
