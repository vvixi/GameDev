// Simple popup window system for use as message boxes
// or to contain UI elements
// implemented in P4 by vvixi
// note: many bugs fixed
// receive grid input needs replaced with a cell class

Window window;

void setup() {

  size(600, 600);
   //set this for top or bottom windows
  //PVector winSize = new PVector(width, height/2);
  //window = new Window("bottomHalf", winSize);
  //window = new Window("topHalf", winSize);
  
  //set this for left or right windows
  PVector winSize = new PVector(width / 2, height);
  window = new Window("rightHalf", winSize);
  //window = new Window("leftHalf", winSize);
  
}

void draw() {
  
  background(0);
  window.display();
  if (window.displayed) {
    for (GridCell gridCell : window.gridCells) {
      gridCell.listen();
    }
  }
}

public class Window {
  
  // creates windows
  ArrayList<GridCell> gridCells = new ArrayList<GridCell>();
  Boolean displayed = true;
  String position;
  PVector size;
  float xSize;
  float ySize;
  float vOffset;
  int closeStartX;
  int closeStartY;
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
        
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 3, 3);
        drawClose(closeStartX, closeStartY);
        
      } else if (position == "bottomHalf") {
        
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = height / 2;
        rect(0, height/2, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 3, 3);
        drawClose(closeStartX, closeStartY);
        
      }
    } 
  }
  void drawGrid(PVector _size, int _divH, int _divV) {
    
    // draws the UI grid within the displayed window
    GridCell gridCell;
    this.gridSize = _size;
    this.divH = _divH;
    this.divV = _divV;
    this.vOffset = 0;
    // determines block size for the below loop
    this.block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));

    if (position == "bottomHalf") {

      this.vOffset = height/2;
    }

    fill(200);
    for (int i = 0; i < divH; i++) {
      for (int j = 0; j < divV; j++) {

        rect(bufferX + i * block.x, bufferY + j * block.y + vOffset, gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
        gridCells.add(new GridCell(bufferX + i * block.x, bufferY + j * block.y + vOffset, gridSize.x / divH, gridSize.y / divV - (bufferY / divV)));
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
    //rect(cell.x * window.block.x, (cell.y * window.block.y), window.block.x, window.block.y);
    if (window.position == "rightHalf") {
      
      // here we are accounting for the grid starting on the right half
      // of the screen, adjusting x to be 0 instead of 5 in the 0,0 spot
      // the right window and bottom require this distinction
      cell.x = cell.x - this.divH;
      
    } else if (window.position == "bottomHalf") {
      // needs further debugging
      cell.y = floor((mouseY / window.block.y)-3);

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

public class GridCell {
  
  float posX, posY, sizeX, sizeY, id;
  
  GridCell(float _posX, float _posY, float _sizeX, float _sizeY) {
    
    this.posX = _posX;
    this.posY = _posY;
    this.sizeX = _sizeX;
    this.sizeY = _sizeY;
    
  }
  void listen() {
    if(mouseX > this.posX && mouseX < this.posX + this.sizeX &&
    mouseY > this.posY && mouseY < this.posY + this.sizeY) {
      fill(0, 180, 220);
      rect(this.posX, this.posY, this.sizeX, this.sizeY);
      
    }
  }
}
  
void mousePressed() {
  
  window.checkClose();
  window.receiveGridInput();
  
}
