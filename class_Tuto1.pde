class Tuto1 {
  PImage fond;
  PImage dial1;
  PImage dial2;
  PImage dial3;
  PImage dial4;
  PImage dial5;

  int phase=0;
  Tuto1() {
    fond= loadImage("Assets/Images/Tuto1/fondhangar.png");
    dial1 = loadImage("Assets/Images/Tuto1/poutouDial1.png");
    dial2 = loadImage("Assets/Images/Tuto1/poutouDial2.png");
    dial3 = loadImage("Assets/Images/Tuto1/poutouDial3.png");
    dial4 = loadImage("Assets/Images/Tuto1/poutouDial4.png");
    dial5 = loadImage("Assets/Images/Tuto1/poutouDial5.png");
  }
  void play() {
    image(fond, 0, 0);
    if (phase==0) {
      image(dial1, 0, 650);
    } else if (phase==1) {
      image(dial2, 0, 650);
    } else if (phase==2) {
      image(dial3, 0, 650);
    } else if (phase==3) {
      image(dial4, 0, 650);
    } else if (phase==4) {
      image(dial5, 0, 650);
    }
  }
}

class Tuto2 {
  PImage fond;
  PImage dial1;
  PImage dial2;
  PImage dial3;
  int phase=0;
  Tuto2() {
    fond= loadImage("Assets/Images/Tuto1/fondhangar.png");
    dial1 = loadImage("Assets/Images/Tuto2/poutouDial1.png");
    dial2 = loadImage("Assets/Images/Tuto2/poutouDial2.png");
    dial3 = loadImage("Assets/Images/Tuto2/poutouDial3.png");
  }
  void play() {
    image(fond, 0, 0);
    if (phase==0) {
      image(dial1, 0, 650);
    } else if (phase==1) {
      image(dial2, 0, 650);
    } else if (phase==2) {
      image(dial3, 0, 650);
    }
  }
}

class Tuto3 {
  PImage fond;
  PImage dial1;
  PImage dial2;
  int phase=0;
  Tuto3() {
    fond= loadImage("Assets/Images/Tuto1/fondhangar.png");
    dial1 = loadImage("Assets/Images/Tuto3/poutouDial1.png");
    dial2 = loadImage("Assets/Images/Tuto3/poutouDial2.png");
  }
  void play() {
    image(fond, 0, 0);
    if (phase==0) {
      image(dial1, 0, 650);
    } else if (phase==1) {
      image(dial2, 0, 650);
    }
  }
}
