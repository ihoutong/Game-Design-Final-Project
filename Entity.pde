//super class for all the classes

class Entity {
  PVector location;
  int move;
  Animation picture;
  int health;
  
  //move is default for 1 for obstacles
  Entity(Animation picture, int health, int move) {
    this.picture = picture;
    this.health = health;
    this.move = move;
  }
  
  //bounding box collision
  boolean isCollide(Entity entity) {
  if ((( entity.location.x <= this.location.x + this.picture.images[0].width ) && ( this.location.x + this.picture.images[0].width <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.y <= this.location.y + this.picture.images[0].height ) && ( this.location.y + this.picture.images[0].height <= entity.location.y + entity.picture.images[0].height )) || // is lower right corner of p1 inside p2?
      (( entity.location.x <= this.location.x )       && ( this.location.x       <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.y <= this.location.y + this.picture.images[0].height ) && ( this.location.y + this.picture.images[0].height <= entity.location.y + entity.picture.images[0].height )) || // is lower left corner of p1 inside p2?
      (( entity.location.x <= this.location.x + this.picture.images[0].width ) && ( this.location.x + this.picture.images[0].width <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.y <= this.location.y )       && ( this.location.y       <= entity.location.y + entity.picture.images[0].height )) || // is upper right corner of p1 inside p2?
      (( entity.location.x <= this.location.x )       && ( this.location.x       <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.y <= this.location.y )       && ( this.location.y       <= entity.location.y + entity.picture.images[0].height )) || // is upper left corner of p1 inside p2?
      (( this.location.x <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.x + entity.picture.images[0].width <= this.location.x + this.picture.images[0].width ) && ( this.location.y <= entity.location.y + entity.picture.images[0].height ) && ( entity.location.y + entity.picture.images[0].height <= this.location.y + this.picture.images[0].height )) || // is upper left corner of p2 inside p1?
      (( this.location.x <= entity.location.x )       && ( entity.location.x       <= this.location.x + this.picture.images[0].width ) && ( this.location.y <= entity.location.y + entity.picture.images[0].height ) && ( entity.location.y + entity.picture.images[0].height <= this.location.y + this.picture.images[0].height )) || // is upper right corner of p2 inside p1?
      (( this.location.x <= entity.location.x + entity.picture.images[0].width ) && ( entity.location.x + entity.picture.images[0].width <= this.location.x + this.picture.images[0].width ) && ( this.location.y <= entity.location.y )       && ( entity.location.y       <= this.location.y + this.picture.images[0].height )) || // is lower left corner of p2 inside p1?
      (( this.location.x <= entity.location.x )       && ( entity.location.x       <= this.location.x + this.picture.images[0].width ) && ( this.location.y <= entity.location.y )       && ( entity.location.y       <= this.location.y + this.picture.images[0].height ))) { // is lower right corner of p2 inside p1?
    return( true );
  }
  else {
    return( false );
  }
 }
 
  PVector getrandomlocation(){
    int picwidth = picture.images[0].width;
    return (new PVector ( ((int)random(picwidth, width - picwidth) / picwidth) * picwidth , 30 ));
 }  
 
  boolean outofscreen(){
    if (this.location.y > height)
      return true;
    else
      return false;
  }
  
  boolean percieve(Entity entity) {
   float hght = this.picture.images[0].height;
//if the x positions of the two entities are equal, AND if the lower corner of the top sprite is 50 pixels
//above the y position of the second sprite return true.
   if (this.location.x == entity.location.x && (this.location.y + hght) <= (entity.location.y) 
       && (this.location.y + hght) >= entity.location.y - 50) {
       return true;
   } 
  else return false; 
  }//end of percieve function

}
