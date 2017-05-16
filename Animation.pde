// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  int imageCount;
  //double to make frames move slower
  double frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos){
    //add by .04 instead of 1
    frame = (frame+.05) % imageCount;
    //typecast frame into an int. by default, int will round down any doubles
    image(images[(int)frame], xpos, ypos);
    
  }
  
  void showObst(float xpos, float ypos) {
    image(images[0], xpos, ypos);
  }
  int getWidth() {
    return images[0].width;
  }
}


