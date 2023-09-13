// Simple popup window system for use as message boxes
// or to contain UI elements
// implemented in P4 by vvixi
// note: needs further testing and refactoring
Window window;

void setup() {
  
  size(600, 600);
  PVector size = new PVector(width, height);
  window = new Window("rightHalf", size);
}

void draw() {
  
  background(0);
  window.display();
}

public class Window {
  
  Boolean displayed = true;
  String position;
  PVector size;
  
  Window(String _position, PVector _size) {

    position = _position;
    size = _size;
  }
  
  void display() {
    
    if (displayed) {
      rectMode(CORNER);
      fill(50);
      if (position == "rightHalf") {
        rect(0, 0, size.x, size.y);
        fill(200, 0, 0);
        rect(width-50, 0, 50, 50);
        
      } else if (position == "leftHalf") {
        rect(0, 0, size.x/2, size.y);
        fill(200, 0, 0);
        rect(size.x/2-50, 0, 50, 50);
        
      } else if (position == "topHalf") {
        rect(0, 0, size.x, size.y/2);
        fill(200, 0, 0);
        rect(size.x-50, 0, 50, 50);
        
      } else if (position == "bottomHalf") {
        rect(0, height/2, size.x, size.y/2);
        fill(200, 0, 0);
        rect(size.x-50, height/2, 50, 50);
      }
    } 
  }
}
void mousePressed() {
  
  if (mouseX > width-50 && mouseX < width &&
      mouseY > 0 && mouseY < 50 &&
      window.position == "rightHalf") {
    window.displayed = false;
  }
}
