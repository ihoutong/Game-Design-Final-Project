class Score{
  int score;
  int monsterskilled_bypowerup;
  int monsterskilled_bydodging;
  
  Score(){
    this.score = 0;
    monsterskilled_bypowerup = 0;
    monsterskilled_bydodging = 0;
  }
  
  int displaycurrentscore(){
    return score;
  }
  
  int calculatefinalscore(){
    return (int)(score * (monsterskilled_bypowerup * .5) + score * (monsterskilled_bydodging * .2) + score);
  }
}
