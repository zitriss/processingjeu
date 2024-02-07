//Tristan Lizé

//Nécessité d'importer la libraire "Sound"
import processing.sound.*;


PFont pixel;

//Création des variables liées à l'état de jeu
int phaseGlobale=0;
int compteurTemps=0;
int compteurAutre=0;
int vieRestante = 5;
int ennemisRestants=0;

///Variables assignation touches
float leftKey = 81;
float rightKey = 68;
float dodgeKey = 32;
float circleKey = 69;
float ultimateKey = 65;

///Variables activation touches
Boolean leftActivation = false;
Boolean rightActivation = false;
Boolean dodgeActivation = false;
Boolean circleActivation = false;
Boolean ultimateActivation = false;

//Variables cooldown capacités
int dodgeCooldown=12;

//Chargement de l'objet nounours
Ours nounours = new Ours(100, 600, 255, 0, 0, 15, 110);

///Listes gestion des tirs
float[] tirsY = new float[5];
float[] tirsX = new float[5];

//Initialisation des autres objets
Cine1 C1;
Poutou P1;
ReineCutscene R1;
Grenade G1;
Explosion E1;
Menu M1;
Tuto1 T1;
Tuto2 T2;
Tuto3 T3;
phaseGameplay P2;
reineBoss R3;
Dodge D1;
looseScreen L1;
Aureole A1;
bidenBoss B2;
Menu1 M2;

//Listes d'objets
Reine[]  R2= new Reine[3];
Biden[]  B1= new Biden[5];

//Classes avec Musiques
SoundFile musiqueIntro;
float musiqueIntroAmp=0.1;

SoundFile sonExplosion;

SoundFile musiquePoutou;
float musiquePoutouAmp=0.1;

SoundFile sonPetiteExplosion;

SoundFile clicSouris;

SoundFile tirLaser;

SoundFile themeFreeplay;

SoundFile themeReineBoss;
float reineBossAmp=0.1;

SoundFile themeBidenBoss;
float bidenBossAmp=0.1;

SoundFile coupSubis;


void setup() {
  //Le jeu est prévu pour une taille de 800*800, mais peut être changé car le mode freeplay est accessible peut importe la taille
  size(800, 800);
  //Le jeu est prévu pour un frameRate de 60 fps, il ne faut pas le changer
  frameRate(60);

  //Chargement de la police d'écriture
  pixel = createFont("Assets/Font/Pixel Sans Serif.ttf", 12);
  textFont(pixel);

  //Chargement des classes.
  C1 = new Cine1();
  P1 = new Poutou();
  R1 = new ReineCutscene();
  G1 = new Grenade();
  E1 = new Explosion();
  M1 = new Menu();
  T1 = new Tuto1();
  T2 = new Tuto2();
  T3 = new Tuto3();
  P2 = new phaseGameplay();
  R3 = new reineBoss();
  D1 = new Dodge();
  L1 = new looseScreen();
  A1 = new Aureole();
  B2 = new bidenBoss();
  M2 = new Menu1();

  //Chargement des listes d'ennemis
  for (int i=0; i<3; i++) {
    R2[i] = new Reine();
    R2[i].xPos=int(random(0, 650));
  }
  for (int i=0; i<5; i++) {
    B1[i] = new Biden();
    B1[i].xPos=int(random(0, 650));
  }

  //Classes SoundFile
  musiqueIntro = new SoundFile(this, "Assets/Musiques/Start a Cult.mp3" );
  musiqueIntro.amp(0.1);

  sonExplosion = new SoundFile(this, "Assets/Sons/grosseExplosion.mp3");
  sonExplosion.amp(0.3);

  musiquePoutou = new SoundFile(this, "Assets/Musiques/Poutou.mp3");
  musiquePoutou.amp(0.1);

  themeFreeplay = new SoundFile(this, "Assets/Musiques/themeFreeplay.mp3");
  themeFreeplay.amp(0.1);

  themeReineBoss = new SoundFile(this, "Assets/Musiques/Hail To The King.mp3");
  themeReineBoss.amp(0.1);

  sonPetiteExplosion = new SoundFile(this, "Assets/Sons/petiteExplosion.mp3");
  sonPetiteExplosion.amp(0.7);

  clicSouris = new SoundFile(this, "Assets/Sons/clicSouris.mp3");
  clicSouris.amp(0.3);

  tirLaser = new SoundFile(this, "Assets/Sons/tirLaser.mp3");
  tirLaser.amp(0.1);

  coupSubis = new SoundFile(this, "Assets/Sons/coupSubis.mp3");

  themeBidenBoss = new SoundFile(this, "Assets/Musiques/The Only Thing I Know For Real.mp3");
  themeBidenBoss.amp(0.1);

  //Chargement des liste des tirs de nounours.
  for (int i=0; i<5; i++) {
    tirsY[i] =0;
    tirsX[i] =0;

    //Si la taille de la fenêtre est changée, passage à la phase freePlay
    if (height!=800 ||width!=800) {
      phaseGlobale=40;
      nounours.yPos=height-100;
      nounours.xPos=width/2;
      P2.fond.resize(width, height);
      L1.fond.resize(width, height);
      L1.perdu.resize(int(width/1.33), height/4);
      L1.reco1.resize(width/4, height/8);
      L1.reco2.resize(width/4, height/8);
    }
  }
}

void draw() {
  //Le jeu est découpé en plusieurs phases globales
  //Phase globale 0
  if (phaseGlobale==0) {
    //Joue la musique de l'intro si elle n'est pas déja jouée et si la sous-phase de l'intro est en dessous de 5
    if (!musiqueIntro.isPlaying() & C1.phase<=5) {
      musiqueIntro.play();
    }
    //La méthode show(). de la classe C1 permet d'afficher tout les éléments de décors en fonction de la sous-phase
    C1.show();

    //Pour les sous-phases après la phase 0, nounours est affiché grâce à sa méthode show().
    //En général, toutes les méthodes show() permettent d'afficher les éléments de l'objet à qui appartient la méthode
    if (C1.phase>0) {
      nounours.show();
    }
    //La sous-phase changera toute les 5 secondes
    if (C1.phase<5) {
      compteurTemps++;
      if (compteurTemps==300) {
        compteurTemps=0;
        C1.phase++;
      }
    }
    //Comme les mouvements de nounours ne sont pas libres, il sont gérés indépendamment du reste de ses mouvements.
    if (C1.phase==5) {
      //Change la position en fonction de l'activation des touches de déplacement.
      if (leftActivation==true) {
        if (nounours.xPos>0) {
          nounours.xPos-= 5;
        }
      }
      if (rightActivation==true) {
        if (nounours.xPos<700) {
          nounours.xPos+= 5;
        }
      }
      //Passe à la sous-phase suivante quand la position horizontale dépasse un point.
      if (nounours.xPos>=700) {
        C1.phase=6;
      }
    } else if (C1.phase==6) {
      //Le nounours se déplace tout seul hors de la fenêtre à droite.
      if (nounours.xPos<=850) {
        nounours.xPos+= 5;
      } else {
        //Une fois hors de la fenêtre, on passe à la sous-phase suivante.
        C1.phase=7;
        nounours.xPos= -50;
        nounours.yPos= 700;
      }
    } else if (C1.phase==7) {
      //Le nounours revient seul dans la fenêtre et descend à la bonne hauteur.
      if (nounours.xPos<=250) {
        nounours.xPos+= 5;
        if (nounours.yPos>=605) {
          nounours.yPos-= 5;
        }
      } else {
        //Quand le nounours est presque à la bonne position, on passe à la sous-phase suivante et on le met à la position exacte.
        C1.phase=8;
        nounours.xPos=255;
      }
    } else if (C1.phase==8) {
      //Attends 7 secondes avant de passer à la sous-phase suivante
      compteurTemps++;
      if (compteurTemps==420) {
        compteurTemps=0;
        C1.phase++;
        //Arrête la musique et joue le son de la grosse explosion
        musiqueIntro.stop();
        sonExplosion.play();
        //Joue la musique de Phillipe poutou
        musiquePoutou.play();
      }
    } else if (C1.phase==9) {
      //affiche les objets : phillipe poutou la reine
      P1.show();
      R1.show();
      compteurTemps++;
      if (compteurTemps==0) {
        //Augmente la taille de l'image de la reine et met les objets aux bonnes coordonées
        R1.reine.resize(250, 250);
        R1.yPos=-150;
        R1.xPos=150;
        P1.xPos=950;
        P1.yPos=500;
      }
      //Fait bouger la reine et poutou aux bonnes coordonées
      if (R1.yPos<=200) {
        R1.yPos+=2;
      }
      if (P1.xPos>=500) {
        P1.xPos-=2;
      }
      //Quand les bonnes coordonées sont atteintes, passe à la sous-phase suivante
      if (R1.yPos>200 && P1.xPos<500) {
        C1.phase=10;
        //Met la grenade aux Bonnes coordonées
        G1.xPos=700;
        G1.yPos=575;
      }
    } else if (C1.phase==10) {
      //Affiche la grenade en plus des objets précédents
      P1.show();
      R1.show();
      G1.show();
      //Fait descendre un peu le nounours pour qu'il esquive la reine.
      if (nounours.yPos<= 700) {
        nounours.yPos+=5;
      }
      //La grenade se déplace vers la reine jusqu'a la collision
      G1.xPos+=constrain((G1.xPos-(R1.xPos+75)), -1, 1)*-10;
      G1.yPos+=constrain((G1.yPos-(R1.yPos+75)), -1, 1)*-5;
      //Détection de la collision
      if (R1.xPos<=G1.xPos && R1.xPos+150>=G1.xPos && R1.yPos+150>=G1.yPos  && R1.yPos<=G1.yPos) {
        C1.phase++;
        sonPetiteExplosion.play();
        P1.phase++;
        compteurTemps=0;
        E1.xPos=R1.xPos;
        E1.yPos=R1.yPos;
      }
    } else if (C1.phase==11) {
      compteurTemps++;
      P1.show();
      if (compteurTemps<=120) {
        //Montre l'explosion pendant 3 secondes
        E1.show();
      }
      if (compteurTemps>=180) {
        P1.phase++;
        C1.phase++;
      }
    } else if (C1.phase==12) {
      P1.show();
      if (P1.xPos<=800) {
        P1.xPos+=2;
      }
      //Les mouvements sont a nouveaux gérés indépendamment du système de base
      if (leftActivation==true) {
        if (nounours.xPos>0) {
          nounours.xPos-= 5;
        }
      }
      if (rightActivation==true) {
        if (nounours.xPos<700) {
          nounours.xPos+= 5;
        }
      }
      if (nounours.xPos>=700) {
        C1.phase=13;
      }
    } else if (C1.phase==13) {
      if (nounours.xPos<=950) {
        nounours.xPos+= 5;
      } else {
        nounours.xPos= width/5;
        nounours.yPos= height/2;
        //Passe à la phase globale suivante
        phaseGlobale=1;
        compteurTemps=0;
      }
    }
  } else if (phaseGlobale==1) {
    //Phase globale de l'écran titre
    background(0);
    M1.play();
    if (M1.phase<=1) {
      //Pour les deux première sous-phases, il faut attendre.
      compteurTemps++;
      if (compteurTemps>=300) {
        M1.phase++;
        compteurTemps=0;
      }
    } else {
      nounours.show();
      //Passe à la phase globale suivante si on clique dans la zone du boutton
      if (mouseX>=400 && mouseX<=750 && mouseY>=300 && mouseY<=400 && mousePressed == true) {
        clicSouris.play();
        phaseGlobale=2;
        nounours.xPos= 100;
        nounours.yPos= 600;
      }
    }
  } else if (phaseGlobale==2) {
    //Le fonctionnement de la phase est le même que celui de la phase 0 ( introduction )
    //Diminue progressivement le vollume de la musique Phillipe Poutou
    if (musiquePoutouAmp>=0.001) {
      musiquePoutouAmp-=0.0005;
      musiquePoutou.amp(musiquePoutouAmp);
    } else {
      musiquePoutou.stop();
    }
    if (!musiquePoutou.isPlaying() && !musiqueIntro.isPlaying()) {
      musiqueIntro.play();
    }
    T1.play();
    nounours.show();
    if ( T1.phase<=1) {
      compteurTemps++;
      if (compteurTemps>=500) {
        T1.phase++;
        compteurTemps=0;
      }
    } else if (T1.phase==2) {
      //vérifie que le joueur à essayé de tirer au 4 fois
      if (compteurAutre>=4) {
        //remet la variable de tirs a 0
        for (int i=0; i<5; i++) {
          tirsY[i] =0;
          tirsX[i] =0;
        }
        T1.phase++;
        R1.yPos=-150;
        R1.xPos=350;
      }
    } else if (T1.phase==3) {
      R1.show();
      if (R1.yPos<=100) {
        R1.yPos+=2;
      }
      for (int i=0; i<5; i++) {
        if (R1.xPos<=tirsX[i] && R1.xPos+150>=tirsX[i] && R1.yPos+150>=tirsY[i]-50  && R1.yPos<=tirsY[i]) {
          tirsY[i] =0;
          tirsX[i] =0;
          T1.phase++;
          sonPetiteExplosion.play();
          compteurTemps=0;
          E1.xPos=R1.xPos;
          E1.yPos=R1.yPos;
        }
      }
    } else if (T1.phase==4) {
      //La musique diminue petit à petit
      if (musiqueIntroAmp>=0.001) {
        musiqueIntroAmp-=0.0005;
        musiqueIntro.amp(musiqueIntroAmp);
      } else {
        musiqueIntro.stop();
      }
      compteurTemps++;
      if (compteurTemps<=120) {
        E1.show();
      }
      if (compteurTemps>=300) {
        for (int i=0; i<5; i++) {
          tirsY[i] =0;
          tirsX[i] =0;
        }
        phaseGlobale=3;
        musiqueIntro.stop();
        nounours.yPos=700;
        //Défini le nombre d'énnemis de la phase suivante
        ennemisRestants=100;
      }
    }
  } else if (phaseGlobale==3) {
    if (!themeFreeplay.isPlaying()) {
      themeFreeplay.play();
    }
    P2.show();
    fill(255);
    text("Nombre de vies : "+vieRestante, 10, 780);
    text("Ennemis Restants : "+ennemisRestants, 10, 40);
    nounours.show();
    for (int i=0; i<3; i++) {
      //Si la vie de la reine est supérieure à 0, on l'affiche et vérifie qu'elle n'est pas en contact avec un tir
      if (R2[i].pv>0) {
        R2[i].showReine();
        R2[i].yPos+=1.5;
        //On regarde si la reine touche le sol, si oui on retire une vie au joueur
        if (R2[i].yPos>=650) {
          R2[i].pv=0;
          sonPetiteExplosion.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=0;
          }
        }
        //Vérification du contact Reine / Tir
        for (int y=0; y<5; y++) {
          if (R2[i].xPos<=tirsX[y] && R2[i].xPos+150>=tirsX[y] && R2[i].yPos+150>=tirsY[y]-50  && R2[i].yPos<=tirsY[y]) {
            tirsY[y]=0;
            tirsX[y]=0;
            R2[i].pv--;
            if (R2[i].pv<=0) {
              sonPetiteExplosion.play();
              ennemisRestants--;
            }
          }
        }
      } else {
        //Sinon on affiche une explosion à son emplacement
        R2[i].showExplosion();
        R2[i].timerExplosion++;
        //Après une seconde on remet la vie de la reine à 1, et la position X est donnée aléatoirement
        if (R2[i].timerExplosion>=60) {
          R2[i].yPos=-100;
          R2[i].xPos=int(random(0, 650));
          R2[i].pv=1;
          R2[i].timerExplosion=0;
        }
      }
    }
    if (ennemisRestants<=0) {
      //Quand il n'y a plus d'ennemis restants, on passe à la phase suivante
      nounours.yPos=600;
      themeFreeplay.stop();
      musiqueIntro.play();
      nounours.xPos=400;
      vieRestante=5;
      phaseGlobale=4;
      compteurTemps=0;
      R3.phase=0;
      R3.reine.resize(450, 450);
      R3.xPos=250;
      R3.yPos=80;
    }
  } else if (phaseGlobale==4) {
    //La phase se comporte exactement comme le premier tuto
    T2.play();
    nounours.show();
    if (T2.phase==0) {
      if (musiqueIntroAmp<=0.1) {
        musiqueIntroAmp+=0.0005;
        musiqueIntro.amp(musiqueIntroAmp);
      }
      compteurTemps++;
      if (compteurTemps>=500) {
        T2.phase++;
        compteurTemps=0;
      }
    } else if (T2.phase==1) {
      //Si l'esquive a été activée, alors on peut passer à la sous-phase suivante
      if (dodgeCooldown==0) {
        T2.phase=2;
      }
    } else if (T2.phase==2) {
      if (musiqueIntroAmp>=0.001) {
        musiqueIntroAmp-=0.0005;
        musiqueIntro.amp(musiqueIntroAmp);
      } else {
        musiqueIntro.stop();
      }
      compteurTemps++;
      if (compteurTemps>=500) {
        nounours.yPos=700;
        phaseGlobale++;
        compteurTemps=0;
        nounours.xPos=400;
        musiqueIntro.stop();
      }
    }
  } else if (phaseGlobale==5) {
    //La phase se comporte comme la phase 3, mais avec un ennemi supplémentaire des petits ennemis
    if (!themeReineBoss.isPlaying()) {
      themeReineBoss.play();
    }
    if (R3.phase==0) {
      //La sous-phase 0 dure 3 secondes est permet de voir le boss avant de l'affronter
      P2.show();
      R3.show();
      if (compteurTemps<=180) {
        compteurTemps++;
      }
      if (compteurTemps==180) {
        R3.reine.resize(300, 300);
        R3.phase=1;
        R3.yPos=-30;
        for (int i=0; i<3; i++) {
          R2[i] = new Reine();
          R2[i].xPos=int(random(0, 650));
        }
      }
    } else if (R3.phase<3) {
      //L'attaque de la reine à un cooldown qui augmente et qui lui permet de déclencher une capacité quand il atteint une seconde
      if (R3.phase==1 && R3.cooldown<60) {
        R3.cooldown++;
      }
      if (R3.phaseGarde==0 && R3.cooldown1<60) {
        R3.cooldown1+=6;
      }
      P2.show();
      R3.show();
      nounours.show();
      fill(255);
      text("Nombre de vies : "+vieRestante, 10, 780);
      for (int i=0; i<3; i++) {
        if (R2[i].pv>0) {
          R2[i].showReine();
          R2[i].yPos+=1.5;
          if (R2[i].yPos>=650) {
            R2[i].pv=0;
            sonPetiteExplosion.play();
            vieRestante--;
            if (vieRestante<=0) {
              phaseGlobale=-1;
              L1.phase=1;
            }
          }
          for (int y=0; y<5; y++) {
            if (tirsY[y]!=0) {
              if (R2[i].xPos<=tirsX[y] && R2[i].xPos+150>=tirsX[y] && R2[i].yPos+150>=tirsY[y]-50  && R2[i].yPos<=tirsY[y]) {
                tirsY[y]=0;
                tirsX[y]=0;
                R2[i].pv--;
                if (R2[i].pv<=0) {
                  sonPetiteExplosion.play();
                }
              }
              //La collision entre les tirs et le boss se comporte comme entre le les tirs et les reines
              if (R3.xPos<=tirsX[y] && R3.xPos+300>=tirsX[y] && R3.yPos+300>=tirsY[y]-50  && R3.yPos<=tirsY[y]) {
                tirsY[y]=0;
                tirsX[y]=0;
                R3.pv--;
                if (R3.pv==0) {
                  sonExplosion.play();
                  R3.phase=3;
                  compteurTemps=0;
                  E1.xPos=R3.xPos;
                  E1.yPos=R3.yPos;
                  for (int z=0; z<5; z++) {
                    tirsY[z] =0;
                    tirsX[z] =0;
                  }
                }
              }
            }
          }
        } else {
          R2[i].showExplosion();
          R2[i].timerExplosion++;
          if (R2[i].timerExplosion>=60) {
            R2[i].yPos=-100;
            R2[i].xPos=int(random(0, 650));
            R2[i].pv=1;
            R2[i].timerExplosion=0;
          }
        }
      }
      //Si le cooldown est de 60, la reine lance son attaque
      if (R3.cooldown==60 && int(R3.phase)==1) {
        R3.attaqueDash();
        R3.cooldown=0;
        R3.xTarget=int(nounours.xPos);
        R3.yTarget=int(nounours.yPos);
      }
      if (R3.phase==2.1) {
        //La reine enregistre la position du joueur dans xTarget et yTarget puis vas s'y diriger
        R3.xPos+=(constrain(((R3.xPos+150)-(R3.xTarget)), -1, 1)*-10);
        R3.yPos+=(constrain(((R3.yPos+300)-(R3.yTarget)), -1, 1)*-10);
        //Vérifie la collision entre la reine et sa cible
        if ((R3.xPos+100)<=R3.xTarget && R3.xPos+200>=R3.xTarget && R3.yPos<=R3.yTarget && R3.yPos+300>=R3.yTarget) {
          R3.phase=2.2;
        }
        //Si la reine touche nounours, on retire une vie au joueur
        if ((R3.xPos+100)<=nounours.xPos && R3.xPos+200>=nounours.xPos && R3.yPos<=nounours.yPos && R3.yPos+300>=nounours.yPos) {
          R3.phase=2.2;
          coupSubis.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=1;
          }
        }
      }
      if (R3.phase==2.2) {
        //Quand la reine a atteint le joueur ou sa cible, elle revient à sa position de départ et le cooldown retourne à 0
        R3.xTarget=250;
        R3.yTarget=-30;
        R3.xPos+=(constrain(((R3.xPos)-(R3.xTarget)), -1, 1)*-5);
        R3.yPos+=(constrain(((R3.yPos)-(R3.yTarget)), -1, 1)*-5);
        if (R3.xPos-25<=R3.xTarget && R3.xPos+25>=R3.xTarget && R3.yPos-25<=R3.yTarget && R3.yPos+25>=R3.yTarget) {
          R3.xPos=250;
          R3.yPos=-30;
          R3.phase=1;
        }
      }
      if (R3.cooldown1==60 && R3.phaseGarde==0) {
        //La reine possède aussi deux gardes qui attaquent le joueur
        //Ils apparaissent à un x aléatoire et montent de bas en haut
        R3.phaseGarde=1.1;
        R3.xGarde1=int(random(0, 325));
        R3.yGarde1=700;
        R3.xGarde2=int(random(426, 700));
        R3.yGarde2=700;
      }
      if (R3.phaseGarde==1.1) {
        if (R3.cooldown1>0) {
          R3.cooldown1-=2;
        }
        if (R3.cooldown1==0) {
          R3.phaseGarde=1.2;
        }
        //Si les gardes touchent le joueur, ils disparaissent et retirent une vie
      } else if (R3.phaseGarde==1.2) {
        if (R3.xGarde1<=nounours.xPos && R3.xGarde1+100>=nounours.xPos && R3.yGarde1<=nounours.yPos && R3.yGarde1+300>=nounours.yPos) {
          R3.yGarde1=-300;
          coupSubis.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=1;
          }
        }
        if (R3.xGarde2<=nounours.xPos && R3.xGarde2+100>=nounours.xPos && R3.yGarde2<=nounours.yPos && R3.yGarde2+300>=nounours.yPos) {
          R3.yGarde2=-300;
          coupSubis.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=1;
          }
        }
        //Les gardes montent de bas en haut
        if (R3.yGarde1>=-300 || R3.yGarde2>=-300) {
          R3.yGarde1-=10;
          R3.yGarde2-=10;
        } else {
          R3.phaseGarde=0;
        }
      }
    } else {
      //Quand la reine est morte, le jeu se comporte comme un tuto ou une cinématique avant de passer à la phase suivante
      if (compteurTemps<=120) {
        E1.show();
      } else if (compteurTemps>=300) {
        themeReineBoss.stop();
        nounours.yPos=600;
        phaseGlobale++;
        musiqueIntro.play();
      }
      R3.VaincuShow();
      if (reineBossAmp>=0.001) {
        reineBossAmp-=0.0005;
        themeReineBoss.amp(reineBossAmp);
      }
      compteurTemps++;
    }
  } else if (phaseGlobale==6) {
    //a nouveau une phase de tuto
    T3.play();
    nounours.show();
    if (T3.phase==0) {
      if (musiqueIntroAmp<=0.1) {
        musiqueIntroAmp+=0.0005;
        musiqueIntro.amp(musiqueIntroAmp);
      }
      compteurTemps++;
      if (compteurTemps>=500) {
        T3.phase++;
        compteurTemps=0;
      }
    } else if (T3.phase==1) {
      if (musiqueIntroAmp>=0.001) {
        musiqueIntroAmp-=0.0005;
        musiqueIntro.amp(musiqueIntroAmp);
      } else {
        musiqueIntro.stop();
      }
      compteurTemps++;
      if (compteurTemps>=500) {
        musiqueIntro.stop();
        phaseGlobale=7;
        ennemisRestants=150;
        nounours.yPos=700;
        vieRestante=5;
      }
    }
  } else if (phaseGlobale==7) {
    //Se comporte exactement comme la phase 3
    if (!themeFreeplay.isPlaying()) {
      themeFreeplay.play();
    }
    P2.show();
    fill(255);
    text("Nombre de vies : "+vieRestante, 10, 780);
    text("Ennemis Restants : "+ennemisRestants, 10, 40);
    nounours.show();
    for (int i=0; i<5; i++) {
      if (B1[i].pv>0) {
        B1[i].showBiden();
        B1[i].yPos+=1.5;
        if (B1[i].yPos>=650) {
          B1[i].pv=0;
          sonPetiteExplosion.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=3;
          }
        }
        for (int y=0; y<5; y++) {
          if (B1[i].xPos<=tirsX[y] && B1[i].xPos+150>=tirsX[y] && B1[i].yPos+150>=tirsY[y]-50  && B1[i].yPos<=tirsY[y]) {
            tirsY[y]=0;
            tirsX[y]=0;
            B1[i].pv--;
            if (B1[i].pv<=0) {
              sonPetiteExplosion.play();
              ennemisRestants--;
            }
          }
        }
      } else {
        B1[i].showExplosion();
        B1[i].timerExplosion++;
        if (B1[i].timerExplosion>=60) {
          B1[i].yPos=-100;
          B1[i].xPos=int(random(0, 650));
          B1[i].pv=2;
          B1[i].timerExplosion=0;
        }
      }
    }
    //Quand le cercle est activé, il enregistre toute les coordonées de Biden dans ses listes targetX et targetY
    if (circleActivation==true && A1.phase==0 && A1.cooldown==300) {
      A1.phase=1;
      A1.targetMax=5;
      for (int i=0; i<5; i++) {
        if (B1[i].timerExplosion==0) {
          A1.targetX[i]=B1[i].xPos;
          A1.targetY[i]=B1[i].yPos;
        }
      }
    }
    if (A1.phase==1) {
      for (int i=0; i<5; i++) {
        if (B1[i].timerExplosion==0) {
          A1.targetX[i]-=1.5;
        }
      }
    }
    if (ennemisRestants<=0) {
      nounours.yPos=600;
      themeFreeplay.stop();
      nounours.xPos=400;
      vieRestante=5;
      phaseGlobale=8;
      compteurTemps=0;
      compteurAutre=0;
      B2.xPos=80;
      B2.yPos=250;
    }
  } else if (phaseGlobale==8) {
    //Cette phase se comporte comme celle du boss avec la reine mais l'attaque des gardes est remplacée par celle de la tour de new york
    P2.show();
    B2.show();
    if (!themeBidenBoss.isPlaying()) {
      themeBidenBoss.play();
    }
    if (B2.phase==0) {
      if (compteurTemps<=180) {
        compteurTemps++;
      }
      if (compteurTemps==180) {
        B2.phase=1;

        for (int i=0; i<5; i++) {
          B1[i] = new Biden();
          B1[i].xPos=int(random(0, 650));
        }
      }
    } else if (B2.phase<3) {
      if (B2.phase==1 && R3.cooldown<60) {
        B2.cooldown++;
      }
      nounours.show();
      fill(255);
      text("Nombre de vies : "+vieRestante, 10, 780);
      for (int i=0; i<5; i++) {
        if (B1[i].pv>0) {
          B1[i].showBiden();
          B1[i].yPos+=1.5;
          if (B1[i].yPos>=650) {
            B1[i].pv=0;
            sonPetiteExplosion.play();
            vieRestante--;
            if (vieRestante<=0) {
              phaseGlobale=-1;
              L1.phase=3;
            }
          }
          for (int y=0; y<5; y++) {
            if (tirsY[y]!=0) {
              if (B1[i].xPos<=tirsX[y] && B1[i].xPos+150>=tirsX[y] && B1[i].yPos+150>=tirsY[y]-50  && B1[i].yPos<=tirsY[y]) {
                tirsY[y]=0;
                tirsX[y]=0;
                B1[i].pv--;
                if (B1[i].pv<=0) {
                  sonPetiteExplosion.play();
                }
              }
              if (B2.xPos<=tirsX[y] && B2.xPos+300>=tirsX[y] && B2.xPos+300>=tirsY[y]-50  && B2.yPos<=tirsY[y]) {
                tirsY[y]=0;
                tirsX[y]=0;
                B2.pv--;
                if (B2.pv==0) {
                  sonExplosion.play();
                  B2.phase=3;
                  compteurTemps=0;
                  E1.xPos=B2.xPos;
                  E1.yPos=B2.yPos;
                  for (int z=0; z<5; z++) {
                    tirsY[z] =0;
                    tirsX[z] =0;
                  }
                }
              }
            }
          }
        } else {
          B1[i].showExplosion();
          B1[i].timerExplosion++;
          if (B1[i].timerExplosion>=60) {
            B1[i].yPos=-100;
            B1[i].xPos=int(random(0, 650));
            B1[i].pv=2;
            B1[i].timerExplosion=0;
          }
        }
      }
      //Le cerceau ce comporte comme dans la phase précédente mais il enregistre aussi la position du boss Biden
      if (circleActivation==true && A1.phase==0 && A1.cooldown==300) {
        A1.phase=1;
        A1.targetMax=5;
        for (int i=0; i<5; i++) {
          if (B1[i].timerExplosion==0) {
            A1.targetX[i]=B1[i].xPos;
            A1.targetY[i]=B1[i].yPos;
          }
        }
        A1.targetX[5]=B2.xPos;
        A1.targetY[5]=B2.yPos;
      }
      if (A1.phase==1) {
        for (int i=0; i<5; i++) {
          if (B1[i].timerExplosion==0) {
            A1.targetX[i]-=1.5;
          }
        }
      }
      if (B2.cooldown==60 && int(B2.phase)==1) {
        //Même attaque de dash que pour la reine
        B2.phase=2.1;
        B2.cooldown=0;
        B2.xTarget=int(nounours.xPos);
        B2.yTarget=int(nounours.yPos);
      }
      if (B2.phase==2.1) {
        B2.xPos+=(constrain(((B2.xPos+150)-(B2.xTarget)), -1, 1)*-10);
        B2.yPos+=(constrain(((B2.yPos+300)-(B2.yTarget)), -1, 1)*-10);
        if ((B2.xPos+100)<=B2.xTarget && B2.xPos+200>=B2.xTarget && B2.yPos<=B2.yTarget && B2.yPos+300>=B2.yTarget) {
          B2.phase=2.2;
        }
        if ((B2.xPos+100)<=nounours.xPos && B2.xPos+200>=nounours.xPos && B2.yPos<=nounours.yPos && B2.yPos+300>=nounours.yPos) {
          B2.phase=2.2;
          coupSubis.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=3;
          }
        }
      }
      if (B2.phase==2.2) {
        B2.xTarget=250;
        B2.yTarget=80;
        B2.xPos+=(constrain(((B2.xPos)-(B2.xTarget)), -1, 1)*-5);
        B2.yPos+=(constrain(((B2.yPos)-(B2.yTarget)), -1, 1)*-5);
        if (B2.xPos-25<=B2.xTarget && B2.xPos+25>=B2.xTarget && B2.yPos-25<=B2.yTarget && B2.yPos+25>=B2.yTarget) {
          B2.xPos=250;
          B2.yPos=-30;
          B2.phase=1;
        }
      }
      //Gestion de l'attaque des tours
      if (B2.compteurAttaque==0) {
        B2.rectangleY[15]=600;
        B2.compteurAttaque=1;
      } else if (B2.compteurAttaque==1) {
        for (int i=0; i<16; i++) {
          //Parcours les tours, et si la tour est levée, regarde les collisions avec nounours avant de changer la tour levée
          if (B2.rectangleY[i+1]==600) {
            B2.rectangleY[i+1]=720;
            B2.rectangleY[i]=600;
            B2.compteurAttaque=2;
            if (B2.rectangleX[i+1]<=nounours.xPos && B2.rectangleX[i+1]+50 >= nounours.xPos) {
              coupSubis.play();
              vieRestante--;
              if (vieRestante<=0) {
                phaseGlobale=-1;
                L1.phase=3;
              }
            }
            compteurAutre=0;
          }
        }
        if (B2.rectangleY[0]==600) {
          B2.compteurAttaque=4;
          compteurAutre=0;
        }
      } else if (B2.compteurAttaque==2) {
        //Pose un délai d'un dixieme de seconde avant de changer de tour
        compteurAutre++;
        if (compteurAutre>=6) {
          B2.compteurAttaque=1;
          compteurTemps=0;
        }
      } else if (B2.compteurAttaque==3) {
        //Même principe mais sur l'autre sens de circulation des tours
        for (int i=0; i<16; i++) {
          if (B2.rectangleY[i]==600) {
            if (B2.rectangleX[i]<=nounours.xPos && B2.rectangleX[i]+50 >= nounours.xPos) {
              coupSubis.play();
              vieRestante--;
              if (vieRestante<=0) {
                phaseGlobale=-1;
                L1.phase=3;
              }
            }
            B2.rectangleY[i+1]=600;
            B2.rectangleY[i]=720;
            B2.compteurAttaque=4;
            compteurAutre=0;
            break;
          }
        }
        if (B2.rectangleY[15]==600) {
          B2.compteurAttaque=2;
        }
      } else if (B2.compteurAttaque==4) {
        compteurAutre++;
        if (compteurAutre>=6) {
          B2.compteurAttaque=3;
          compteurAutre=0;
        }
      }
    } else if (B2.phase==3) {
      if (compteurTemps<=120) {
        E1.show();
      } else if (compteurTemps>=300) {
        themeBidenBoss.stop();
        phaseGlobale=30;
      }
      B2.VaincuShow();
      if (bidenBossAmp>=0.001) {
        bidenBossAmp-=0.0005;
        themeBidenBoss.amp(reineBossAmp);
      }
      compteurTemps++;
    }
  } else if (phaseGlobale==30) {
    M2.show();
  } else if (phaseGlobale==40) {
    //Se comporte exactement comme la phase 3
    if (!themeFreeplay.isPlaying()) {
      themeFreeplay.play();
    }
    P2.show();
    fill(255);
    text("Nombre de vies : "+vieRestante, 10, height-20);
    nounours.show();
    for (int i=0; i<5; i++) {
      if (B1[i].pv>0) {
        B1[i].showBiden();
        B1[i].yPos+=1.5;
        if (B1[i].yPos>=height-150) {
          B1[i].pv=0;
          sonPetiteExplosion.play();
          vieRestante--;
          if (vieRestante<=0) {
            phaseGlobale=-1;
            L1.phase=5;
          }
        }
        for (int y=0; y<5; y++) {
          if (B1[i].xPos<=tirsX[y] && B1[i].xPos+150>=tirsX[y] && B1[i].yPos+150>=tirsY[y]-50  && B1[i].yPos<=tirsY[y]) {
            tirsY[y]=0;
            tirsX[y]=0;
            B1[i].pv--;
            if (B1[i].pv<=0) {
              sonPetiteExplosion.play();
            }
          }
        }
      } else {
        B1[i].showExplosion();
        B1[i].timerExplosion++;
        if (B1[i].timerExplosion>=60) {
          B1[i].yPos=-100;
          B1[i].xPos=int(random(0, width-150));
          B1[i].pv=2;
          B1[i].timerExplosion=0;
        }
      }
    }
    //Quand le cercle est activé, il enregistre toute les coordonées de Biden dans ses listes targetX et targetY
    if (circleActivation==true && A1.phase==0 && A1.cooldown==300) {
      A1.phase=1;
      A1.targetMax=5;
      for (int i=0; i<5; i++) {
        if (B1[i].timerExplosion==0) {
          A1.targetX[i]=B1[i].xPos;
          A1.targetY[i]=B1[i].yPos;
        }
      }
    }
    if (A1.phase==1) {
      for (int i=0; i<5; i++) {
        if (B1[i].timerExplosion==0) {
          A1.targetX[i]-=1.5;
        }
      }
    }
  } else if (phaseGlobale==-1) {
    //Cette phase correspond à l'écran de mort
    //En fonction de la sous-phase entrée lors de la mort elle renverra a une phase différente une fois le bouton cliqué
    vieRestante=5;
    L1.show();
    if (mouseX>=200 && mouseX<=600 && mouseY>=425 && mouseY<=525) {
      L1.phaseScreen=1;
    } else {
      L1.phaseScreen=0;
    }
    if (L1.phase==0) {
      fill(255);
      text("La Reine réptilienne vous a tué !!", 200, 400);
      if (mouseX>=200 && mouseX<=600 && mouseY>=425 && mouseY<=525 && mousePressed == true) {
        ennemisRestants=100;
        nounours.yPos=700;
        nounours.xPos=400;
        phaseGlobale=3;
      }
    } else if (L1.phase==1) {
      fill(255);
      text("La Reine réptilienne vous a tué !!", 200, 400);
      if (mouseX>=200 && mouseX<=600 && mouseY>=425 && mouseY<=525 && mousePressed == true) {
        R3.reine.resize(450, 450);
        R3.xPos=250;
        R3.yPos=80;
        compteurTemps=0;
        R3.phase=0;
        R3.phaseGarde=0;
        R3.cooldown=0;
        R3.cooldown1=0;
        R3.pv=150;
        nounours.yPos=700;
        nounours.xPos=400;
        phaseGlobale=5;
      }
    } else if (L1.phase==2) {
      fill(255);
      text("Joe le Réptile vous a tué!!", 200, 400);
      if (mouseX>=200 && mouseX<=600 && mouseY>=425 && mouseY<=525 && mousePressed == true) {
        ennemisRestants=150;
        nounours.yPos=700;
        nounours.xPos=400;
        phaseGlobale=7;
      }
    } else if (L1.phase==3) {
      fill(255);
      text("Joe le Réptile vous a tué!!", 200, 400);
      themeBidenBoss.stop();
      if (mouseX>=200 && mouseX<=600 && mouseY>=425 && mouseY<=525 && mousePressed == true) {
        B2.xPos=250;
        B2.yPos=80;
        compteurTemps=0;
        B2.phase=0;
        B2.cooldown=0;
        B2.pv=250;
        nounours.yPos=700;
        nounours.xPos=400;
        phaseGlobale=8;
      }
    } else if (L1.phase==4) {
      fill(255);
      text("Joe le Réptile vous a tué!!", width/4, height/2);
      if (mouseX>=width/4 && mouseX<=width/1.33 && mouseY>=height/2 && mouseY<=height/1.66 && mousePressed == true) {
        nounours.yPos=height-100;
        nounours.xPos=width/2;
        phaseGlobale=40;
      }
    }
  }



  //L'affichage des tirs se fait uniquement si leur position Y est différente de 0
  noFill();
  strokeWeight(10);
  stroke(nounours.couleurOeil1, nounours.couleurOeil2, nounours.couleurOeil3);
  //Le laser prend la couleur des yeux (pourra être changeable dans le futur)
  for (int i=0; i<5; i++) {
    if (tirsY[i]!= 0) {
      line(tirsX[i], tirsY[i], tirsX[i], tirsY[i]-50);
      //La position Y du laser diminue dès qu'il est affiché donc il remonte
      tirsY[i]-=10;
      if (tirsY[i]<0) {
        tirsY[i]=0;
        tirsX[i]=0;
      }
    }
  }

  //déplacements
  if (phaseGlobale>=2) {
    if (leftActivation==true) {
      if (nounours.xPos>0) {
        nounours.xPos-= 5;
      }
    }
    if (rightActivation==true) {
      if (nounours.xPos<width) {
        nounours.xPos+= 5;
      }
    }
  }

  //Quand le cooldown dépasse 12 frames, appuyer sur espace + une touche de déplacement effectue un grand mouvement vers la gauche ou la droite
  if (phaseGlobale==5 || T2.phase==1 && phaseGlobale==4  || phaseGlobale==8) {
    if (phaseGlobale==5 || phaseGlobale==8 ) {
      D1.show();
    }
    if (dodgeActivation==true && dodgeCooldown==12) {
      if (leftActivation==true) {
        nounours.xPos-=150;
      } else if (rightActivation==true) {
        nounours.xPos+=150;
      }
      dodgeCooldown=0;
      D1.phase=1;
      if (nounours.xPos>800) {
        nounours.xPos= 800;
      } else if (nounours.xPos<0) {
        nounours.xPos=0;
      }
    } else if (dodgeCooldown<=11) {
      dodgeCooldown+=1;
    }
    if (dodgeCooldown==12) {
      D1.phase=0;
    }
  }

  //Auréole d'ange
  if (phaseGlobale==7 || phaseGlobale==8 && B2.phase>=1 || phaseGlobale==40) {
    A1.show();
    if (A1.phase==0) {
      //Quand elle n'est pas en animation d'attaque, l'auréole est positionnée juste au dessus de nounours
      A1.xPos=nounours.xPos;
      A1.yPos=nounours.yPos-85;
      //Affiche le temps restant pour charger l'auréole
      if (A1.cooldown>=0 && A1.cooldown<300) {
        fill(255);
        text(5-(A1.cooldown/60), 730, 790);
        A1.cooldown++;
      }
    } else if (A1.phase==1) {
      //Quand l'auréole est en mode attaque, elle se dirige sur la première cible de sa liste
      A1.xPos+=constrain((A1.xPos-(A1.targetX[A1.target]+75)), -1, 1)*-15;
      A1.yPos+=constrain((A1.yPos-(A1.targetY[A1.target]+75)), -1, 1)*-15;
      if (A1.targetX[A1.target]-50<=A1.xPos && A1.targetX[A1.target]+150>=A1.xPos && A1.targetY[A1.target]+150>=A1.yPos  && A1.targetY[A1.target]-50<=A1.yPos) {
        //Quand elle arrive sur la cible, elle change de cible et inflige des dégâts en fonction de la phase
        if (phaseGlobale==7) {
          B1[A1.target].pv=B1[A1.target].pv-5;
          ennemisRestants--;
          sonPetiteExplosion.play();
        } else if (phaseGlobale==8) {
          B1[A1.target].pv=B1[A1.target].pv-5;
          B2.pv-=5;
          sonPetiteExplosion.play();
        } else if (phaseGlobale==40) {
          B1[A1.target].pv=B1[A1.target].pv-5;
          sonPetiteExplosion.play();
        }
        A1.target++;
        if (A1.target==A1.targetMax) {
          //Quand elle n'a plus de cible disponible, elle passe à la phase 2
          A1.phase=2;
        }
      }
    } else if (A1.phase==2) {
      //Durant la phase 2, l'auréole retourne vers l'ours et repasse a la phase 0 quand elle arrive à destination
      A1.xPos+=constrain((A1.xPos-(nounours.xPos)), -1, 1)*-15;
      A1.yPos+=constrain((A1.yPos-(nounours.yPos-85)), -1, 1)*-15;
      if (nounours.xPos-100<=A1.xPos && nounours.xPos+100>=A1.xPos && nounours.yPos+100>=A1.yPos  && nounours.yPos-100<=A1.yPos) {
        A1.cooldown=0;
        A1.phase=0;
        A1.target=0;
      }
    }
    noFill();
    stroke(255, 245, 0);
    strokeWeight(4);
    //affiche l'auréole à sa position
    ellipse(A1.xPos, A1.yPos, 120, 50);
  }
}

void mousePressed() {
  //La vérification des phases permet à l'ours de tirer seulement dans les phases nécessaires
  if (phaseGlobale==2 & T1.phase>=2 || phaseGlobale==3 || phaseGlobale==5 && R3.phase>=1 && R3.phase<3 || phaseGlobale==7 || phaseGlobale==8 && B2.phase>=1 || phaseGlobale==40) {
    for (int i=0; i<5; i++) {
      //Ajoute un nouvel ellément dans la liste des tirs à la position de l'ours puis arrête de cherche une place avec break
      if (tirsY[i]== 0) {
        tirLaser.play();
        tirsY[i] = nounours.yPos-100;
        tirsX[i] = nounours.xPos;
        compteurAutre++;
        break;
      }
    }
  }
}

void keyPressed() {

  if (keyCode==leftKey) {
    leftActivation=true;
  } else if (keyCode==rightKey) {
    rightActivation=true;
  } else if (keyCode==dodgeKey) {
    dodgeActivation=true;
  } else if (keyCode==circleKey) {
    circleActivation=true;
  } else if (keyCode==ultimateKey) {
    ultimateActivation=true;
  }
}

void keyReleased() {

  if (keyCode==leftKey) {
    leftActivation=false;
  } else if (keyCode==rightKey) {
    rightActivation=false;
  } else if (keyCode==dodgeKey) {
    dodgeActivation=false;
  } else if (keyCode==circleKey) {
    circleActivation=false;
  } else if (keyCode==ultimateKey) {
    ultimateActivation=false;
  }
}
