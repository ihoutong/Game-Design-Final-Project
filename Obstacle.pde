/*
obstacles - collision detection
*/

class Obstacle extends Entity {
  
  
  //leaving empty for later
  //for the most part this is all the constructor should need
  //health is set to 999 incase of collision with monster although monster should avoid collision
  Obstacle(Animation picture){
    super(picture, 999, 3); //move is set to 3 since it is same as yvelocity of scrolling background
    location = getrandomlocation();
  }
  
  void scrollObst(){
    location.y += this.move;
  }

}
