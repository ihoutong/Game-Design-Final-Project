//enemy - collision detection, pathfinding to avoid obstacles, ai to prevent enemy from "grouping up" into one line
class Enemy extends Entity {
  
  //created basic constructor, more will be added to it when necessary
  //For now I created it to verify that it works with creating a monster.
  Enemy(Animation picture, int health, int move){
    super(picture, health, move);
    location = getrandomlocation();
  }
  
  //makes monster go straight down
  void straightdown(){
    location.y += this.move;
  }
}
