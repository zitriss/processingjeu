class Ours {
  float xPos, yPos, couleurOeil1, couleurOeil2, couleurOeil3, tailleOeil, tailleTete;
  Ours (float x, float y, float c1, float c2, float c3, float tailleO, float tailleT) {
    xPos = x;
    yPos = y;
    couleurOeil1 = c1;
    couleurOeil2 = c2;
    couleurOeil3 = c3;
    tailleOeil = tailleO;
    tailleTete = tailleT;
  }
  void show() {

    // Extérieur oreilles
    fill(240, 149, 92);
    stroke(209, 115, 57);
    ellipse(xPos-45, yPos-45, 50, 50);
    ellipse(xPos+45, yPos-45, 50, 50);

    // Intérieur oreilles
    fill(247, 190, 237);
    stroke(222, 175, 213);
    strokeWeight(3);
    ellipse(xPos-45, yPos-45, 25, 25);
    ellipse(xPos+45, yPos-45, 25, 25);

    // Tête
    fill(240, 149, 92);
    stroke(209, 115, 57);
    strokeWeight(1);
    ellipse(xPos, yPos, tailleTete, tailleTete);

    // Oeils
    fill(couleurOeil1, couleurOeil2, couleurOeil3);
    noStroke();
    ellipse(xPos-20, yPos-10, tailleOeil, tailleOeil);
    ellipse(xPos+20, yPos-10, tailleOeil, tailleOeil);

    // Bouche
    noFill();
    stroke(209, 115, 57);
    strokeWeight(4);
    arc(xPos-10, yPos+20, 20, 15, 0, PI+QUARTER_PI);
    arc(xPos+10, yPos+20, 20, 15, 0-QUARTER_PI, PI);
    line(xPos, yPos+20, xPos, yPos+20);
  }
}

class Dodge {
  PImage dodge;
  PImage dodge1;
  int phase=0;
  Dodge() {
    dodge = loadImage("Assets/Images/Capacites/dodgeIcone1.png");
    dodge1 = loadImage("Assets/Images/Capacites/dodgeIcone2.png");
  }
  void show() {
    if (phase==0) {
      image(dodge, 760, 730);
    } else if (phase==1) {
      image(dodge1, 760, 730);
    }
  }
}

class Aureole {
  PImage aureole;
  PImage aureole1;
  int phase=0;
  int cooldown=0;
  float xPos= 0;
  float yPos = 0;
  int target =0;
  int targetMax = 0;
  float[] targetX = new float[10];
  float[] targetY = new float[10];
  Aureole() {
    aureole = loadImage("Assets/Images/Capacites/cerceauIcone1.png");
    aureole1 = loadImage("Assets/Images/Capacites/cerceauIcone2.png");
  }
  void show() {
    if (phase==0 && cooldown==300) {
      image(aureole, 720, 730);
    } else {
      image(aureole1, 720, 730);
    }
  }
}
