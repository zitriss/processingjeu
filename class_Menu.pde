class Menu {
  PImage fond;
  PImage titre;
  PImage jouer1;
  PImage jouer2;
  int phase=0;
  Menu() {
    fond = loadImage("Assets/Images/Menu/homeScreen.png");
    titre = loadImage("Assets/Images/Menu/logo.png");
    jouer1 = loadImage("Assets/Images/Menu/Jouer1.png");
    jouer2 = loadImage("Assets/Images/Menu/Jouer2.png");
    jouer1.resize(350, 100);
    jouer2.resize(350, 100);
  }
  void play() {
    if (phase==1) {
      fill(255);
      text("Nounours VS Reptiliens", 300, 380);
    } else if (phase==2) {
      image(fond, 0, 0);
      image(titre, 50, 50);
      if (mouseX>=400 && mouseX<=750 && mouseY>=300 && mouseY<=400) {
        image(jouer2, 400, 300);
      } else {
        image(jouer1, 400, 300);
      }
    }
  }
}

class Menu1 {
  PImage fond;
  Menu1() {
    fond = loadImage("Assets/Images/Menu/toBeContinued.png");
  }
  void show() {
    image(fond, 0, 0);
  }
}
