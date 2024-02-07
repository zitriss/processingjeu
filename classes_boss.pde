class reineBoss {
  PImage reine;
  PImage garde;
  PImage reine2;
  PImage viepleine;
  PImage vievide;
  PImage vaincu;

  int pv =150;
  int xPos;
  int yPos;
  float phase=0;
  float phaseGarde=0;
  int cooldown=0;
  int cooldown1=0;

  int xTarget;
  int yTarget;

  int xGarde1;
  int yGarde1;
  int xGarde2;
  int yGarde2;
  reineBoss() {
    reine = loadImage("Assets/Images/Boss/reine.png");
    garde = loadImage("Assets/Images/Boss/reinegarde.png");
    reine2 = loadImage("Assets/Images/Boss/reineSAVE.png");
    viepleine = loadImage("Assets/Images/Boss/viepleine.png");
    vievide = loadImage("Assets/Images/Boss/vievide.png");
    vaincu = loadImage("Assets/Images/Boss/bossvaincu.png");
  }
  void attaqueDash() {
    phase=2.1;
  }
  void attaqueGarde() {
    phaseGarde=1;
  }
  void show() {
    fill(255);
    text("REINE ELISABETH REPTILIENNE II", 10, 50);
    image(vievide, 0, 70);
    viepleine.resize(int((pv*5.33)), 100);
    image(viepleine, 0, 70);
    if (phase==0) {
      image(reine2, xPos, yPos);
    } else {
      if (phaseGarde>=1) {
        image(garde, xGarde1, yGarde1);
        image(garde, xGarde2, yGarde2);
      }
      image(reine, xPos, yPos);
    }
  }
  void VaincuShow() {
    image(vaincu, 0, 0);
  }
}

class bidenBoss {
  int pv =250;
  PImage biden;
  PImage tour;
  int xPos;
  int yPos;
  int[] rectangleX = new int[17];
  int[] rectangleY = new int[17];
  int compteurAttaque=0;
  float phase =0;
  int cooldown=0;
  PImage viepleine;
  PImage vievide;
  PImage vaincu;
  int xTarget;
  int yTarget;
  bidenBoss() {
    biden = loadImage("Assets/Images/Boss/biden.png");
    tour = loadImage("Assets/Images/Boss/building.png");
    viepleine = loadImage("Assets/Images/Boss/viepleine.png");
    vievide = loadImage("Assets/Images/Boss/vievide.png");
    vaincu = loadImage("Assets/Images/Boss/bossvaincu.png");
    tour.resize(50, 200);
    for (int i=0; i<17; i++) {
      rectangleX[i]=i*50;
      rectangleY[i]=720;
    }
  }
  void show() {
    fill(255);
    image(vievide, 0, 70);
    viepleine.resize(int((pv*3.2)), 100);
    image(viepleine, 0, 70);
    image(biden, xPos, yPos);
    for (int i=0; i<16; i++) {
      image(tour, rectangleX[i], rectangleY[i]);
    }
    text("VRAI HOMME (REPTILIEN), ALPHA, AMERICAIN, PATRIOTE, CAPITALISTE, BIENFAITEUR, COWBOY", 10, 50);
  }
  void VaincuShow() {
    image(vaincu, 0, 0);
  }
}
