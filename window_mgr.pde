// Simple popup window system for use as message boxes
// or to contain UI elements
// implemented in P4 by vvixi
// note: needs further testing, expansion, and refactoring
Window window;

void setup() {
  
  size(600, 600);
  PVector gridSize = new PVector(width, height);
  window = new Window("rightHalf", gridSize);
  //window = new Window("lefttHalf", gridSize);
  //window = new Window("bottomHalf", size);
  //window = new Window("topHalf", size);
}

void draw() {
  
  background(0);
  window.display();
}

public class Window {
  
  Boolean displayed = true;
  String position;
  PVector size;
  int closeStartX = width - 50;
  int closeStartY;
  int topLeft = 0;
  int topRight = width;
  
  PVector gridSize;
  int divH;
  int divV;
  int bufferX, bufferY=50;
  PVector block;
  
  Window(String _position, PVector _size) {

    position = _position;
    size = _size;
  }
  
  void display() {
    
    if (displayed) {
      rectMode(CORNER);
      fill(50);
      
      if (position == "rightHalf") {
        
        topLeft = width / 2;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(topLeft, 0, width, height);
        drawGrid(new PVector(topLeft, height), 5, 5);
        fill(200, 0, 0);
        rect(closeStartX, 0, 50, 50);
        stroke(0);
        line(closeStartX, 0, width, 50);
        line(closeStartX, 50, width, 0);
        
      } else if (position == "leftHalf") {
        
        topLeft = 0;
        topRight = width / 2;
        closeStartX = width/2 - 50;
        closeStartY = 0;
        //noStroke();
        fill(50);
        rect(0, 50, width/2, height);
        drawGrid(new PVector(topLeft, height), 5, 5);
        fill(200, 0, 0);
        rect(topRight-50, 0, 50, 50);
        stroke(0);
        line(closeStartX, 0, topRight, 50);
        line(closeStartX, 50, topRight, 0);
        
      } else if (position == "topHalf") {

        topLeft = 0;
        topRight = width;
        closeStartX = width - 50;
        closeStartY = 0;
        noStroke();
        rect(0, 0, size.x, size.y/2);
        fill(200, 0, 0);
        rect(topRight-50, 0, 50, 50);
        stroke(0);
        line(topRight-50, 0, topRight, 50);
        line(topRight-50, 50, topRight, 0);
        
      } else if (position == "bottomHalf") {
        
        noStroke();
        rect(0, height/2, size.x, size.y/2);
        fill(200, 0, 0);
        rect(size.x-50, height/2, 50, 50);
      }
    } 
  }
  void drawGrid(PVector _size, int _divH, int _divV) {
    
    bufferX = 0;
    gridSize = _size;
    divH = _divH;
    divV = _divV;
    if (position == "rightHalf") {
      bufferX = int(width-gridSize.x);
    } 
    block = new PVector(gridSize.x / divH, gridSize.y / divV);
    fill(200);
    for (int i = 0; i < divH; i++) {
      for (int j = 0; j < divV; j++) {
        
        rect(bufferX + i * block.x, 0 + j * block.y + bufferY, gridSize.x / divH, gridSize.y / divV);
      }
    }
  }
}

void testInput() {

  // test for closing a window
  // needs further functionality and testing
  if (mouseX > window.topRight-50 && mouseX < window.topRight &&
  mouseY > window.closeStartY && mouseY < window.closeStartY+50) {
    window.displayed = false;
  }
}

//void testInput(PVector _cellStart, PVector _cellSize) {
  
//  PVector cellStart = _cellStart;
//  PVector cellSize = _cellSize;

//  // parameters: a cell defined as a starting PVector
//  // and a size to determine where the cells ending boundaries are
//  if (mouseX > cellStart.x && mouseX < cellStart.x + cellSize.x &&
//  mouseY > cellStart.y && mouseY < cellStart.y + cellSize.y) {
//    println("working!");
//  }
//}
  
PVector translateMouse() {
  
  // helper function to translate the mouse into the UI grid
  PVector cell = new PVector(0, 0);
  cell.x = floor(mouseX / window.block.x)-5;
  cell.y = floor(mouseY / window.block.y);
  //if (window.position == "rightHalf") {
  //  cell.x = floor(mouseX / window.block.x)-5;
  //} else {
  //  cell.x = floor(mouseX / window.block.x);
  //}
  //cell.y = floor(mouseY / window.block.y);
  try {
    
    assert(cell.x > -1 && cell.x < width);
    assert(cell.y > -1 && cell.y < height);
    
  } catch (AssertionError e) {
    println("X and Y must be within the screen size's range of 0 to maxWidth.");
  }

  return new PVector(cell.x, cell.y);
}
PVector gridSize = new PVector(width/2, height);

PVector receiveGridInput() {

  PVector pos = translateMouse();
  //  // this captures user input from the grid

  // cell select
  if (pos.x == 0 && pos.y == 0) {
    
    window = new Window("rightHalf", gridSize);
    println("new win");
    //return pos;
  } else if (pos.x == 1 && pos.y == 0) {

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
void mousePressed() {
  
  testInput();

  //println(receiveGridInput());
  receiveGridInput();
}
