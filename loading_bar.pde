// Simple loading bar in P4 by vvixi
LoadingBar loadingbar;

void setup() {
  
  size(600, 600);
  loadingbar = new LoadingBar();
}


void draw() {
  
  loadingbar.renderBar(width/2, height/2);
  
}

class LoadingBar {
  
  int outerHeight = 30;
  int innerHeight = outerHeight-2;
  int outerWidth = 100;
  int innerWidth = outerWidth-2;
  int pct = 0;
  
  void renderBar(int _posX, int _posY) {
    
    int posX = _posX;
    int posY = _posY;
    
    if (pct < innerWidth) {
      rectMode(CENTER);
      fill(255, 0, 0);
      rect(posX, posY, outerWidth, outerHeight);
      fill(0);
      rect(posX, posY, innerWidth, innerHeight);
      
      rectMode(CORNER);
      fill(255, 0, 0);
      rect(posX+1 - (outerWidth / 2), posY - (innerHeight/2), pct, innerHeight);
      pct++;
    } else {
      // set state here
      println("done");
    }
  }
}
