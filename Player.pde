/*
player - needs collision detection
needs power up - make this using a class
*/

class Player extends Entity {
  Score score;
  Powerup powerup;
  Player(Animation picture, int health, int move){
    super (picture, health, move);
    location = new PVector( ((width/2)/55)*55 + 5, height-picture.images[0].height);
    score = new Score();
    powerup = new Powerup();
  }
  
  void removepowerup(){
    this.picture = new Animation("start", 3);
    this.powerup.powerup = false;
  }
  
  void obtainscorepowerup(){
    this.picture = new Animation("shield", 3);
    this.powerup.duration += 300;
    this.powerup.newscorebonus();
    this.powerup.powerup = true;
    println("Score Activate");
  }
  
  void obtaindodgepowerup(){
    this.picture = new Animation("power", 3);
    this.powerup.duration += 300;
    this.powerup.newdodgebonus();
    this.powerup.powerup = true;
    println("Dodge Activate");
  }
  
  void powerupchecker(){
    if (powerup.scoretoreceivebonus == score.score)
      obtainscorepowerup();
    if (powerup.dodgetoreceivebonus == score.monsterskilled_bydodging)
      obtaindodgepowerup();
  }
  
  //draws the players score and health
  void drawplayerinfo(){
    stroke( #000000 );  
    fill(255);
    //displays player health as hearts
    for (int i = 0; i < player.health; i++){
      image(heart, 24*i, 0);
    }
    text("Score: "+player.score.score,0,35);
    text("Duration: "+player.powerup.duration,0,53);
  }
  
  

}
