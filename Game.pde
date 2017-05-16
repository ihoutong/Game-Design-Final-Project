/*
CISC 3665 - Term Project
Ihou Tong
Anny Ng

*/
import java.util.Stack;
import java.util.Timer;
import java.util.TimerTask;

Player player;

int gamestate = 0;

ArrayList<Enemy> monsters = new ArrayList<Enemy>();
ArrayList<Obstacle> rocks = new ArrayList<Obstacle>();
Timer montimer;
Timer obstimer;

PImage heart;
PFont f;
PFont h1_Font;
PFont h2_Font;

//for drawing background with scrolling
PImage back1;
PImage back2;
PImage menu;
int xpos;
int ypos;
int ypos2;
float yvel = 3;
int move = 5;

void setup() {
  //originally size was (640, 360)
  size(660, 500);
  initGame();
}

void draw() {
  switch(gamestate){
    case 0:
      menu();
    break;
    case 1:
    //game over screen still displays because the gameover screen is never cleared
    //a new instance of the game is never created.
      strokeWeight(1); //if you start game, make stroke weight 0 so you can't see rectangle box outlines and lanes
      drawBack();
      //creates lines based on monster
      //keep this for now, use it as a guideline for how big each sprite should be
      for (int x = 0; x < width; x += 55)
        line ( x, 80, x, height);
      noFill();
      stroke( #000000 );
      
      //draws players
      player.picture.display(player.location.x, player.location.y);
      rect( player.location.x, player.location.y, player.picture.images[0].width, player.picture.images[0].height );
        
      drawandcheckcollision();
      
      outofscreenchecker();
      player.score.score += 1;
      
      player.powerupchecker();
      
      //duration is set to 300, -- removes one
      //since the frame rate is 60, 300/6 = 5, giving the powerup as 5 seconds
      if(player.powerup.powerup == true){
        player.powerup.duration--;
        if (player.powerup.duration == 0)
          player.removepowerup();
      }
      textAlign(LEFT); //----------------modify text modes here so that score text font is different from menu's text font
      textFont(f);
      player.drawplayerinfo();
      
      if (player.health <= 0)
        gamestate = 2;
      break;
    case 2:
      GameOver();
      break; 
  } // end of switch statement
  
  
} //end of draw

//draws the monsters and rocks
//checks for collision with player
//********************************** need to make it so it checks collisions with monsters and obstacles **********************
void drawandcheckcollision(){  
  //draw obstacles using showObst()
  for (int i = 0; i < rocks.size(); i++) {
    Obstacle temprock = rocks.get(i);
    temprock.picture.showObst(temprock.location.x, temprock.location.y);
    temprock.scrollObst();
    
    if(player.isCollide(temprock)){
      if (player.powerup.powerup == false)
        player.health -= 1;
      rocks.remove(i);
    }
 
  }
    //draws each monster
  for (int i = 0; i < monsters.size(); i++){
    Enemy tempmonster = monsters.get(i);
    tempmonster.picture.display(tempmonster.location.x, tempmonster.location.y);
    rect( tempmonster.location.x, tempmonster.location.y, tempmonster.picture.images[0].width, tempmonster.picture.images[0].height );
    tempmonster.straightdown();
    
    if(player.isCollide(tempmonster)) {
      if (player.powerup.powerup == true)
        player.score.monsterskilled_bypowerup = player.score.monsterskilled_bypowerup + 1;
      else
        player.health-=1;
      monsters.remove(i);
    }
    
    //checks for collision between monsters and rocks
    //if monster senses rocks, pick a random direction and move to that direction to avoid rock
    if(rocks.size() > 0){
      for (int j = 0; j < rocks.size(); j++) {
        if (tempmonster.percieve(rocks.get(j)))
          if ( (int)random(1, 100) % 5 == 0)
            tempmonster.location.x += tempmonster.picture.images[0].width;
          else
            tempmonster.location.x -= tempmonster.picture.images[0].width;
      }
    } //end of if(rocks.size())
  }
}

//crates first monster within 3 seconds
//afterwards, waits 2 seconds to create second monster
void createmonsters(){
  montimer.scheduleAtFixedRate(
    new TimerTask(){
      public void run(){
        if (monsters.size() != 5){
          int selection = (int)random(0,4);
          if (selection == 0)
            monsters.add(new Enemy (new Animation("mon", 3), 1, move));
          else if (selection == 1)
            monsters.add(new Enemy (new Animation("monB", 3), 2, move+1));
          else if (selection == 2)
            monsters.add(new Enemy (new Animation("monC", 3), 3, move+2));
          else if (selection == 3)
            monsters.add(new Enemy (new Animation("monD", 3), 4, move+3));
          else if (selection == 4)
            monsters.add(new Enemy (new Animation("monE", 3), 5, move+4));
          println("Create monster "+selection);
        }
      } 
    }, 3000, 2000);
}

//similar to createmonsters(). creates obstacle in first 2 seconds then creates 
//second obstacle 2 seconds later
void createObst(){
  obstimer.scheduleAtFixedRate(
    new TimerTask(){
      public void run(){
        if(rocks.size() != 5){
          Obstacle rocksTemp = new Obstacle (new Animation("rock", 1));
          rocks.add(rocksTemp);
        }
      } 
    }, 2000, 2000);
}


//checks the entire monsters arraylist for outofscreen
//also check if rock obstacle is out of screen. if obstacle is off screen, remove it
void outofscreenchecker(){
  //if the monsters health is not 0, then it won't be moved out of the screen.
  for (int i = 0; i < monsters.size(); i++){
    if(monsters.get(i).outofscreen()){
      monsters.get(i).health = monsters.get(i).health - 1;
      healthchecker(i);
    }
  }
  
  //rocks are removed by default.
  for (int j = 0; j < rocks.size(); j++) {
    Obstacle temp = rocks.get(j);
    if(temp.outofscreen()){
      rocks.remove(j);
    }
  }
}

//called by outofscreen checker ONLY
//checks for health of monster, if the health is > 0, then it will get recycled
//if the health is 0 or less than 0, then it will be removed from index
void healthchecker(int index){
  if( (monsters.get(index)).health > 0)
    reusemonster(index);
  else{
    monsters.remove(index);
    player.score.monsterskilled_bydodging = player.score.monsterskilled_bydodging + 1;
  }
}

//gives the monster a random x location
void reusemonster(int index){
  (monsters.get(index)).location.set(monsters.get(index).getrandomlocation());
}

//------------------------------------------------RESET()------------------------------
//reset positions of sprites and make the move variable back to 10
//will remove all the monsters
void reset() {
  if (monsters.size() != 0)
    monsters.clear();
  if (rocks.size() != 0)
    rocks.clear();
}

//------------KEYPRESSED()-----------------------------------------------
void keyPressed() {
  if ( key == CODED ) {
    switch ( keyCode ) {
    case LEFT: 
      {
        if ( player.location.x - player.move <= 0 )
          player.location.x -= 0;
        else  
          player.location.x = player.location.x - player.move;
        break;
      }
    case RIGHT: 
      {
       if ( player.location.x + player.move >= width)    
          player.location.x += 0;    
       else
           player.location.x = player.location.x + player.move;
        break;
      }
    }//end of switch
  }
  if ( key == 'r' || key == 'R' ) {
    reset();
  }
  
  if(key == 's' && gamestate >1) { //if you press 's' while gamestate = 2 which means game over
    gamestate = 0;                 //then go back to menu and reset everything
    reset();
    menu();
  }
  if(key == ' ' && gamestate < 1) { //if you press space while gamestate = 0 which means game have 
    reset();               //not started yet, start the game and initialize everything. first clear away anything extra such as old arraylist
    player = new Player (new Animation("start", 3), 1, 55);
    montimer = new Timer();
    obstimer = new Timer();
    createmonsters();
    createObst();
    gamestate = 1;
  }
}

//-------------------LOADBACKGROUND()-------------------------------------
void loadBackground() {
  back1 = loadImage("./grass0000.jpg");
  back2 = loadImage("./grass0001.jpg");
  
  xpos = 0;
  ypos = 0;
  ypos2 = 0 - (back1.height/2);
}

//----------------------------------DRAWBACK()------draws scrolling background-----------------
void drawBack() {
  
//draw the first image scrolling
  image(back1,xpos, ypos);
  ypos+=yvel;
    
//if the ypos of the first image is greater than height, draw second image
//NOTE: keep in mind that image mode is center, which means the center of the sprite is the x and y coordinate
//so if the line divinding the sprite in half is > screen height, draw second image from position [-100 - (back1.height/2);]
//ypos2 is the y coordinate of the 2nd image and it is drawn so that the second image is directly on top of 1st image
  if (ypos > 0) {
    image(back2, xpos, ypos2);
    ypos2+=yvel;
  }
  
//if second image's y position is > 0 ...which means if the center of the 2nd image 
//passes thru y=0, get ready to draw first image off screen on top of the corner of the 2nd image. 
  if (ypos2 > 0 ) {
    ypos2 = 0 - (back1.height);
    ypos = 0;
  } 
}

//------------------------MENU AND OUT OF SCREEN FUNCTIONS------------------
void menu()
{
  background(255);
  menu = loadImage("menu.jpg");
  image(menu, 0, 0);
  
  //set text settings
  textFont(h1_Font);
  textAlign(CENTER);
  strokeWeight(4);
  
  //draw the shadow of the text to make text stand out against background
  fill(80, 80, 80, 80);
  text("Dodge the Monsters!", (width/2)+3, 103); 
  textFont(h2_Font);
  text("Press space to start", (width/2)+3, 153); 
  text("Use Left and Right arrow keys to dodge", (width/2)+3, 223); 
  
  //draw the text
  stroke(255);
  fill(255);
  textFont(h1_Font);
  text("Dodge the Monsters!", width/2, 100); 
  

  textFont(h2_Font);
  text("Press space to start", width/2, 150); 
  text("Use Left and Right arrow keys to dodge", width/2, 220); 
}

void GameOver() {
  montimer.cancel();
  obstimer.cancel();
  textFont(h2_Font);
  fill(102, 152, 255);
  rect (0, height/4, 660, 300);
  fill(255);
  stroke(#FFFFFF);
  text ("Your score is: "+player.score.score, 150, 170);
  text ("You dodged: "+player.score.monsterskilled_bydodging+" monsters", 150, 210);
  text ("You killed: "+player.score.monsterskilled_bypowerup+" monsters with your powerup", 150, 250);
  text ("Your final score is: "+player.score.calculatefinalscore(), 150, 290);
  text ("Hit 's' to return to menu", 150, 400);
}


//Initialize the game. Easier to call in the case switch for game states
//Usefull for restarting the game after hitting space.
void initGame() {
  String[] fontList = PFont.list();
  
  h1_Font = createFont("GulimChe Bold", 40, true);   // A big size font for the title
  h2_Font = createFont("GulimChe Bold", 25, true);  // A medium size font.
  
  
  //loads the heart image, does not allow this when declaring the variable
  heart = loadImage("heart.jpg");
  loadBackground();
  
  //create font
  f = createFont("Arial", 18, true);
}
