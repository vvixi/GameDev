// Simple popup window system for use as message boxes
// or to contain UI elements
// implemented in P4 by vvixi
// note: many bugs fixed
// receive grid input needs replaced with a cell class
// or otherwise refactored and simplified

Window window;

void setup() {
  
  size(600, 600);
  // set this for top or bottom windows
  //PVector winSize = new PVector(width, height/2);
  //window = new Window("bottomHalf", winSize);
  //window = new Window("topHalf", winSize);
  
  // set this for left or right windows
  PVector winSize = new PVector(width / 2, height);
  window = new Window("rightHalf", winSize);
  //window = new Window("leftHalf", winSize);
  
}

void draw() {
  
  background(0);
  window.display();

}

public class Window {
  
  // creates windows
  //ArrayList<Listener> listeners = new ArrayList<Listener>();
  Boolean displayed = true;
  String position;
  PVector size;
  float xSize;
  float ySize;
  int closeStartX;
  int closeStartY;
  int topLeft = 0;
  int topRight;
  PVector gridSize;
  int divH;
  int divV;
  int bufferX=0, bufferY=50;
  PVector block;
  
  Window(String _position, PVector _size) {

    position = _position;
    size = _size;
  }
  
  void drawClose(int _startX, int _startY) {
    
    // draws the click-to-close box on each window
    int startX = _startX;
    int endX = startX + 50;
    int startY = _startY;
    int endY = _startY + 50;
    
    fill(200, 0, 0);
    rect(startX, startY, 50, 50);
    stroke(0);
    line(startX, startY, endX, endY);
    line(startX, endY, endX, startY);
  }
        
  void display() {
    
    // displays the window based on its position
    if (displayed) {
      rectMode(CORNER);
      fill(50);
      
      if (position == "rightHalf") {
        
        topRight = width;
        bufferX = width / 2;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(bufferX, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 5, 5);
        drawClose(closeStartX, closeStartY);
        
      } else if (position == "leftHalf") {

        topRight = width / 2;
        bufferX = 0;
        closeStartX = width/2 - 50;
        closeStartY = 0;
        rect(bufferX, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 4, 4);
        drawClose(closeStartX, closeStartY);

      } else if (position == "topHalf") {
        
        xSize = width;
        ySize = height / 2;
        topLeft = 0;
        topRight = width;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y/2);
        drawGrid(new PVector(size.x, size.y), 3, 3);
        drawClose(closeStartX, closeStartY);
        
      } else if (position == "bottomHalf") {
        
        bufferY = height / 2;
        xSize = width;
        ySize = height / 2;
        topLeft = height / 2;
        topRight = width;
        closeStartX = width - 50;
        closeStartY = height / 2 - 50;
        rect(0, height/2, xSize, ySize);
        drawGrid(new PVector(xSize, ySize), 3, 3);
        drawClose(closeStartX, closeStartY);
        
      }
    } 
  }
  void drawGrid(PVector _size, int _divH, int _divV) {
    
    // draws the UI grid within the displayed window
    gridSize = _size;
    divH = _divH;
    divV = _divV;
    // determines block size for the below loop
    block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));

    fill(200);
    for (int i = 0; i < divH; i++) {
      for (int j = 0; j < divV; j++) {
        rect(bufferX + i * block.x, 0 + j * block.y + bufferY, gridSize.x / divH, gridSize.y / divV);

      }
    }
  }
  void checkClose() {

    // test for user closing a window
    if (mouseX > this.topRight-50 && mouseX < this.topRight &&
    mouseY > this.closeStartY && mouseY < this.closeStartY+50) {
      this.displayed = false;
    }
  }
  PVector translateMouse() {
    
    // helper function to translate the mouse into the UI grid
    // this needs to account for bufferY which is throwing the input off
    PVector cell = new PVector(0, 0);
  
    cell.x = floor(mouseX / window.block.x);
    cell.y = floor((mouseY / window.block.y)-(window.bufferY/window.block.y));

    fill(0, 100, 200);

    if (window.position == "rightHalf") {
      
      // here we are accounting for the grid starting on the right half
      // of the screen, adjusting x to be 0 instead of 5 in the 0,0 spot
      // the right window is the only one requiring this distinction
      cell.x = cell.x-window.divH;
    }
  
    return new PVector(cell.x, cell.y);
  }

  PVector receiveGridInput() {

    PVector pos = translateMouse();
    // this captures user input from the grid
  
    // cell select
    if (pos.x == 0 && pos.y == 0) {
      
      //window = new Window("rightHalf", gridSize);
      println("0 - 0");
      //return pos;
    } else if (pos.x == 1 && pos.y == 0) {
      
      //window = new Window("rightHalf", gridSize);
      println("1 - 0");
      //return pos;
    } else if (pos.x == 2 && pos.y == 0) {
      
      //window = new Window("rightHalf", gridSize);
      println("2 - 0");
      //return pos;
    } 
    
    //// col select
    //if (translateMouse().x == 0) {
    //  println("col zero");
    //}
    
    //// row select
    //if (pos.y == 0) {
    //  println("row zero");
    //}
  
    return pos;
  }
}
  
void mousePressed() {
  
  window.checkClose();
  window.receiveGridInput();
  
}
