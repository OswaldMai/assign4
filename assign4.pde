PImage backgroundImg1, backgroundImg2, fighter, hp, treasure,enemy;
PImage st1, st2, end1, end2;
int bg1_x,bg2_x,tr_x,tr_y,hpLength,fighter_x,fighter_y;
int fighterW, fighterH, enemyW, enemyH;
int nbrEnemy1 = 5;
int nbrEnemy2 = 3;
float [] enemy_x = new float [nbrEnemy1];
float [] enemy_x1 = new float [nbrEnemy1];
float [] enemy_x2 = new float [nbrEnemy2];
float [] enemy_y = new float [nbrEnemy1];
float [] enemy_y1 = new float [nbrEnemy1];
float [] enemy_y2 = new float [nbrEnemy2];
float fighterSpeed = 5;
float spacing = 55;
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
final int START = 0;
final int RUN = 1;
final int LOSE = 2;
final int F_WAVE = 0;
final int S_WAVE = 1;
final int T_WAVE = 2;

int gameState;
int waveState;

void setup () {
  size(640,480) ; 
  st1 = loadImage("img/start1.png");
  st2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  backgroundImg1 = loadImage("img/bg2.png");
  backgroundImg2 = loadImage("img/bg1.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  bg1_x = 0;
  bg2_x = -640;
  tr_x = floor(random(590));
  tr_y = floor(random(390));
  hpLength = 40;
  fighter_x = 590;
  fighter_y = 220;

  for (int i=0; i<nbrEnemy1; i++){
    for (int j=0; j<nbrEnemy1; j++){
      enemy_x[i]=0;
      enemy_y[j]=0;
      enemy_y[0]=floor(random(420));
      enemy_y[1]= enemy_y[0];
      enemy_y[2]= enemy_y[0];
      enemy_y[3]= enemy_y[0];
      enemy_y[4]= enemy_y[0];
    }
  }
  for (int i=0; i<nbrEnemy1; i++){
    for (int j=0; j<nbrEnemy1; j++){
      enemy_x1[i]=0;
      enemy_y1[j]=0;
      enemy_y1[0]=floor(random(175));
      enemy_y1[1]=enemy_y1[0]+1/5*spacing;
      enemy_y1[2]=enemy_y1[1]+1/5*spacing;
      enemy_y1[3]=enemy_y1[2]+1/5*spacing;
      enemy_y1[4]=enemy_y1[3]+1/5*spacing;
    }
  }
  for (int i=0; i<nbrEnemy2; i++){
    for (int j=0; j<nbrEnemy2; j++){
      enemy_x2[i]=0;
      enemy_y2[j]=0;
      enemy_y2[0]=floor(random(110,310));
      enemy_y2[1]=enemy_y2[0]+1/5*spacing;
      enemy_y2[2]=enemy_y2[0]+1/5*spacing;
    }
  }
  fighterW = 51;
  fighterH = 51;
  enemyW = 61;
  enemyH = 61;

  gameState = START;
  waveState = F_WAVE;

}

void draw() {
  switch (gameState){
    case START:
    image(st2, 0, 0);
    if (mouseY > height*22.8/29 && mouseY < height*25/29 && mouseX > width*5/16 && mouseX < width*11.4/16){
      if (mousePressed){
        gameState = RUN;
      }else{image(st1, 0, 0);}
    }
    break;

    case RUN:
    //background
    if (bg1_x > width){
      bg1_x = -640;
    }
    if (bg2_x > width){
      bg2_x = -640;
    }
    image(backgroundImg1, bg1_x, 0);
    image(backgroundImg2, bg2_x, 0);
    bg1_x = (bg1_x+1);
    bg2_x = (bg2_x+1);
  
    //treasure
    image(treasure,tr_x,tr_y);
    switch (waveState){
      //enemy: the first wave
      case F_WAVE:
      for(int i= 0; i < nbrEnemy1; i++){ 
        image(enemy,enemy_x[i]-i*spacing,enemy_y[i]);
        enemy_x[i] = enemy_x[i]+3;
        
        if (enemy_x[i] >860){
          waveState = S_WAVE;
          enemy_x[i] = 0;
          enemy_y[i] = enemy_y[0];
          enemy_y[0]=floor(random(420));
          enemy_y[1]= enemy_y[0];
          enemy_y[2]= enemy_y[0];
          enemy_y[3]= enemy_y[0];
          enemy_y[4]= enemy_y[0];
        }
        /*hit detection
        if (fighter_x+fighterW >= enemy_x[i] && fighter_x <= enemy_x[i]+enemyW && fighter_y+fighterH >= enemy_y[i] && fighter_y <= enemy_y[i]+enemyH){
          hpLength -= 40;
        }*/
      }
      break;
      
      //enemy: the second wave
      case S_WAVE:
      for (int i = 0; i<nbrEnemy1; i++){
        image(enemy,enemy_x1[i]-i*spacing,enemy_y1[i]+i*spacing);
        enemy_x1[i] = enemy_x1[i]+3;
        if (enemy_x1[i] >860){
          waveState = T_WAVE;
          enemy_x1[i] = 0;
          enemy_y1[0]=floor(random(175));
          enemy_y1[1]=enemy_y1[0]+1/5*spacing;
          enemy_y1[2]=enemy_y1[1]+1/5*spacing;
          enemy_y1[3]=enemy_y1[2]+1/5*spacing;
          enemy_y1[4]=enemy_y1[3]+1/5*spacing;
        }
      }
      break;

      //enemy: the third wave
      case T_WAVE:
      for (int i = 0; i<nbrEnemy2; i++){
        image(enemy,enemy_x2[i]-i*spacing,enemy_y2[i]-i*spacing);
        image(enemy,enemy_x2[i]-i*spacing,enemy_y2[i]+i*spacing);
        image(enemy,enemy_x2[i]+((i-4)*spacing),enemy_y2[i]-i*spacing);
        image(enemy,enemy_x2[i]+((i-4)*spacing),enemy_y2[i]+i*spacing);
        enemy_x2[i] = enemy_x2[i]+3;
        if (enemy_x2[i] >860){
          waveState = F_WAVE;
          enemy_x2[i] = 0;
          enemy_y2[0]=floor(random(110,310));
          enemy_y2[1]=enemy_y2[0]+1/5*spacing;
          enemy_y2[2]=enemy_y2[0]+1/5*spacing;
        }
      }
      break;
    } 
  
  
  
    //fighter
    image(fighter, fighter_x, fighter_y);
  
    //fighter control 1
    if (up){
      fighter_y -= fighterSpeed;
    }
    if (down){
      fighter_y += fighterSpeed;
    }
    if (left){
      fighter_x -= fighterSpeed;
    }
    if (right){
      fighter_x += fighterSpeed;
    }
  
    //fighter boundary detection
    if (fighter_x > 590){
      fighter_x = 590;
    }
    if (fighter_x < 0){
      fighter_x = 0;
    }
    if (fighter_y > 430){
      fighter_y = 430;
    }
    if (fighter_y < 0){
      fighter_y = 0;
    }
  
    //HP
    fill(255,0,0);
    rect(5,3,hpLength,20);
    image(hp,0,0);
  
    //treasures' effects
    if (fighter_x+51 >= tr_x && fighter_x <= tr_x+41 && fighter_y+51 >= tr_y && fighter_y <= tr_y+41){
      hpLength +=20;
      tr_x = floor(random(590));
      tr_y = floor(random(390));
      }

    //hp's maximum and minimum
    if (hpLength >= 200){hpLength = 200;} 
    if (hpLength <= 0){hpLength=0;}
  
    if (hpLength <= 0){gameState = LOSE;}
    break;
  
    case LOSE:
      image(end2, 0, 0);
      if (mouseY > height*21/33 && mouseY < height*24/33 && mouseX > width*0.95/3 && mouseX < width*2.05/3){
        if (mousePressed){
          hpLength = 40;
          fighter_x = 590;
          fighter_y = 220;
          fighterSpeed = 5;
          tr_x = floor(random(590));
          tr_y = floor(random(390));
          waveState = F_WAVE;
          for (int i=0; i<nbrEnemy1; i++){
            enemy_x[i]=0;
            enemy_y[0]=floor(random(420));
            enemy_y[1]= enemy_y[0];
            enemy_y[2]= enemy_y[0];
            enemy_y[3]= enemy_y[0];
            enemy_y[4]= enemy_y[0];
          }
          gameState = RUN;
        }else{image(end1, 0, 0);}
      }
    break;
  }
}

// fighter control 2
void keyPressed(){
  if (key == CODED){
    switch (keyCode){
      case UP:
        up = true;
        break;
      case DOWN:
        down = true;
        break;
      case LEFT:
        left = true;
        break;
      case RIGHT:
        right = true;
        break;
    }
  }
}
void keyReleased(){
  if (key == CODED){
    switch (keyCode){
      case UP:
        up = false;
        break;
      case DOWN:
        down = false;
        break;
      case LEFT:
        left = false;
        break;
      case RIGHT:
        right = false;
        break;
    }
  }
}
