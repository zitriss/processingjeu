class Reine {
  PImage reine;
  PImage explosion;
  int xPos=0;
  int yPos=0;
  int timerExplosion=0;
  int pv=1;
  Reine() {
    reine = loadImage("Assets/Images/Ennemis/reine.png");
    explosion = loadImage("Assets/Images/Ennemis/explosion.png");
    explosion.resize(150, 150);
  }
  void showReine() {
    image(reine, xPos, yPos);
  }
  void showExplosion() {
    image(explosion, xPos, yPos);
  }
}

class Biden {
  PImage biden;
  PImage explosion;
  int xPos=0;
  int yPos=0;
  int timerExplosion=0;
  int pv=2;
  Biden() {
    biden = loadImage("Assets/Images/Ennemis/biden.png");
    explosion = loadImage("Assets/Images/Ennemis/explosion.png");
    explosion.resize(150, 150);
  }
  void showBiden() {
    image(biden, xPos, yPos);
  }
  void showExplosion() {
    image(explosion, xPos, yPos);
  }
}
