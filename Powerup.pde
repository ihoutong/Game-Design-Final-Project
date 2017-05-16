class Powerup {
  int scoretoreceivebonus;
  int dodgetoreceivebonus;
  boolean powerup;
  int duration;
  
  Powerup (){
    this.scoretoreceivebonus = (int)random(1000, 5000);
    this.dodgetoreceivebonus = 3;//(int)random(5, 10);
    powerup = false;
    duration = 0;
    println(scoretoreceivebonus);
    println(dodgetoreceivebonus);
  }
  
  void newscorebonus (){
    this.scoretoreceivebonus = (int)random(this.scoretoreceivebonus * 1.2, this.scoretoreceivebonus * 1.8);
    println(scoretoreceivebonus);
  }
  
  void newdodgebonus(){
    this.dodgetoreceivebonus = (int)random(this.dodgetoreceivebonus * 1.5, this.dodgetoreceivebonus * 2);
    println(dodgetoreceivebonus);
  }
}
