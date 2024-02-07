class phaseGameplay {
  PImage fond;
  phaseGameplay() {
    fond= loadImage("Assets/Images/Menu/homeScreen.png");
  }
  void show() {
    image(fond, 0, 0);
  }
}

class looseScreen {
  PImage fond;
  PImage perdu;
  PImage reco1;
  PImage reco2;
  int phase=0;
  int phaseScreen=0;
  looseScreen() {
    fond= loadImage("Assets/Images/Menu/looseScreen.png");
    perdu= loadImage("Assets/Images/Menu/Perdu.png");
    perdu.resize(600, 200);
    reco1= loadImage("Assets/Images/Menu/Reco1.png");
    reco2= loadImage("Assets/Images/Menu/Reco2.png");
    reco1.resize(400, 100);
    reco2.resize(400, 100);
  }
  void show() {
    image(fond, 0, 0);
    image(perdu, 100, 200);
    if (phaseScreen==1) {
      image(reco2, 200, 425);
    } else {
      image(reco1, 200, 425);
    }
  }
}
