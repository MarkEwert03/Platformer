class FBomb extends FBox {
  int t = 60;
  FBomb() {
    super (PS, PS); //FBomb constructor gotten from FBox(). Must go first
    this.setPosition(player1.getX()-PS, player1.getY());

    //Visuals
    this.setFillColor(yellow);
    this.setNoStroke();

    //Properties
    this.setStatic(false);
    this.setRestitution(0);
    this.setGrabbable(false);
    this.setRotatable(false);

    //Other
    t = 60;
    world.add(this);
  }

  void act() {
    t--;
    if (t == 0) { 
      explode();
      world.remove(this);
      bomb = null;
    }
  }//----------------------------------------------------------------------

  void explode() {
    for (FBox tempBox : boxList) {
      if (dist(this.getX(), this.getY(), tempBox.getX(), tempBox.getY()) < PS*4) {
        float vx = (tempBox.getX() - this.getX()) * 5;
        float vy = (tempBox.getY() - this.getY()) * 5;
        tempBox.setVelocity(vx, vy);
        tempBox.setStatic(false);
      }
    }
  }//----------------------------------------------------------------------
}
