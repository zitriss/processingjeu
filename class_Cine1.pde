class Cine1 {
  //Toutes les classes se comportent pareil
  PImage back1;
  PImage back2;
  PImage back3;
  PImage back4;
  PImage back5;
  PImage back6;
  PImage back7;
  PImage back8;
  PImage dial1;
  PImage dial2;
  PImage dial3;
  int phase=0;
  Cine1() {
    //Elles chargent des images
    back1 = loadImage("Assets/Images/Cinematiques/1/touches.png");
    back2 = loadImage("Assets/Images/Cinematiques/1/reineDiscours1.png");
    back3 = loadImage("Assets/Images/Cinematiques/1/reineDiscours2.png");
    back4 = loadImage("Assets/Images/Cinematiques/1/reineDiscours3.png");
    back5 = loadImage("Assets/Images/Cinematiques/1/reineDiscours4.png");
    back6 = loadImage("Assets/Images/Cinematiques/1/reineDiscours5.png");
    back7 = loadImage("Assets/Images/Cinematiques/1/ville.png");
    back8 = loadImage("Assets/Images/Cinematiques/1/villeExplosion.png");
    dial1 = loadImage("Assets/Images/Cinematiques/1/Ours Dialogue.png");
    dial2 = loadImage("Assets/Images/Cinematiques/1/Ours Dialogue1.png");
    dial3 = loadImage("Assets/Images/Cinematiques/1/Ours Dialogue2.png");
  }
  void show() {
    //Et les affiches en fonction de leur phase
    //Elles contiennent parfois beaucoup d'attributs utiles pour vérifier l'êtat du jeu mais aucune méthode à expliquer
    if (phase==0) {
      image(back1, 0, 0);
    } else if (phase==1) {
      image(back2, 0, 0);
    } else if (phase==2) {
      image(back3, 0, 0);
    } else if (phase==3) {
      image(back4, 0, 0);
    } else if (phase==4) {
      image(back5, 0, 0);
    } else if (phase==5) {
      image(back6, 0, 0);
      image(dial1, 0, 650);
    } else if (phase==6) {
      image(back6, 0, 0);
    } else if (phase==7) {
      image(back7, 0, 0);
    } else if (phase==8) {
      image(back7, 0, 0);
      image(dial2, 0, 650);
    } else if (phase==9) {
      image(back8, 0, 0);
      image(dial3, 0, 650);
    } else if (phase >=10) {
      image(back8, 0, 0);
    }
  }
}

class Poutou {
  PImage poutou1;
  PImage poutou2;
  PImage poutou3;
  int phase = 0;
  int xPos = 950;
  int yPos = 500;
  Poutou() {
    poutou1 = loadImage("Assets/Images/Cinematiques/1/PoutouSoldat.png");
    poutou2 = loadImage("Assets/Images/Cinematiques/1/PoutouDial.png");
    poutou3 = loadImage("Assets/Images/Cinematiques/1/PoutouRenversé.png");
  }
  void show() {
    if (phase==0) {
      image(poutou1, xPos, yPos);
    } else if (phase==1) {
      image(poutou2, xPos, yPos);
    } else if (phase==2) {
      image(poutou3, xPos, yPos);
    }
  }
}

class ReineCutscene {
  PImage reine;
  int xPos = 0;
  int yPos = 0;
  ReineCutscene() {
    reine = loadImage("Assets/Images/Ennemis/reine.png");
  }
  void show() {
    image(reine, xPos, yPos);
  }
}

class Grenade {
  PImage grenade;
  int xPos = 0;
  int yPos = 0;
  Grenade() {
    grenade = loadImage("Assets/Images/Cinematiques/1/grenade.png");
  }
  void show() {
    image(grenade, xPos, yPos);
  }
}

class Explosion {
  PImage explosion;
  int xPos = 0;
  int yPos = 0;
  Explosion() {
    explosion = loadImage("Assets/Images/Ennemis/explosion.png");
    explosion.resize(150, 150);
  }
  void show() {
    image(explosion, xPos, yPos);
  }
}
