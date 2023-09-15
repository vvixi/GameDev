// Simple popup window system for use as message boxes
// or to contain UI elements
// implemented in P4 by vvixi
// note: needs further testing and refactoring

Window window;

void setup() {
  
  size(600, 600);
  //PVector winSize = new PVector(width, height);
  PVector winSize = new PVector(width / 2, height);
  window = new Window("rightHalf", winSize);
  //window = new Window("leftHalf", winSize);
  //window = new Window("bottomHalf", winSize);
  //window = new Window("topHalf", winSize);
}

void draw() {
  
  background(0);
  window.display();
  //for (Listener lis : window.listeners) {
  //  lis.listen();
  //}
}

public class Window {
  
  // length, size, closestartx & y, displayed, 
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
    
    int startX = _startX;
    int endX = startX + 50;
    int startY = _startY;
    int endY = _startY + 50;
    
    fill(200, 0, 0);
    rect(startX, 0, 50, 50);
    stroke(0);
    line(startX, 0, endX, 50);
    line(startX, 50, endX, 0);
  }
        
  void display() {
    
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
        
        bufferY = 50;
        xSize = width;
        ySize = height / 2;
        topLeft = 0;
        topRight = width;
        closeStartX = width - 50;
        closeStartY = 0;
        //noStroke();
        println(size.x);
        rect(0, 0, size.x, size.y/2);
        drawGrid(new PVector(xSize, ySize), 3, 3);
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
        //fill(200, 0, 0);
        //rect(topRight-50, ySize-50, 50, 50);
        //stroke(0);
        //line(topRight-50, ySize, topRight, ySize - 50);
        //line(topRight-50, ySize-50, topRight, ySize);
      }
    } 
  }
  void drawGrid(PVector _size, int _divH, int _divV) {
    
    //Listener listener;
    //println(_size);
    //bufferX = 0;
    //bufferY = 50;
    gridSize = _size;
    divH = _divH;
    divV = _divV;
    if (position == "rightHalf") {
      bufferX = int(width-gridSize.x);
      block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
      //println("buffer x increased");
    } else if (position == "leftHalf") {
      bufferX = 0;
      block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
    }else if (position == "topHalf") {
      bufferY = 50;
      block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
    } else if (position == "bottomHalf") {
      block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
    }
    //print(block);
    fill(200);
    for (int i = 0; i < divH; i++) {
      for (int j = 0; j < divV; j++) {
        //listener = new Listener(bufferX + i * block.x, j * block.y + bufferY, gridSize.x / divH, gridSize.y / divV);
        rect(bufferX + i * block.x, 0 + j * block.y + bufferY, gridSize.x / divH, gridSize.y / divV);
        
        //listeners.add(new Listener(bufferX + i * block.x, j * block.y + bufferY, gridSize.x / divH, gridSize.y / divV));
      }
    }
  }
}


void checkClose() {

  // checkClose would be a better name
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
  //cell.x = floor(mouseX / window.block.x)-5;
  //cell.y = floor(mouseY / window.block.y);
  cell.x = floor(mouseX / window.block.x);
  cell.y = floor(mouseY / window.block.y);
  
  if (window.position == "rightHalf") {
    
    cell.x = floor(mouseX / window.block.x)-window.divH;
    //println(window.block.y * .1);
    cell.y = floor(mouseY / window.block.y - .49);
    //println(cell.y);
    //println("mouseY: ", mouseY, "windowBlockY: ", window.block.y, "windowBufferY: ", window.bufferY);
    //println(cell.y);
  } else if (window.position == "bottomHalf") {
    
    cell.x = floor(mouseX / window.block.x);
    cell.y = floor(mouseY / window.block.y)-window.divV;
  }
  
  
  //try {
    
  //  assert(cell.x > -1 && cell.x < width);
  //  assert(cell.y > -1 && cell.y < height);
    
  //} catch (AssertionError e) {
  //  println("X and Y must be within the screen size's range of 0 to maxWidth.");
  //}

  return new PVector(cell.x, cell.y);
}
//PVector gridSize = new PVector(width/2, height);

PVector receiveGridInput() {

  PVector pos = translateMouse();
  //  // this captures user input from the grid

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
//public class Listener {
  
//  float posX, posY, sizeX, sizeY, id;
  
//  Listener(float _posX, float _posY, float _sizeX, float _sizeY) {
    
//    this.id = random(999);
//    this.posX = _posX;
//    this.posY = _posY;
//    this.sizeX = _sizeX;
//    this.sizeY = _sizeY;
    
//  }
//  void listen() {
//    if(mouseX > posX && mouseX < posX + sizeX &&
//    mouseY > posY && mouseY < posY + sizeY) {
//      if (mousePressed) {
//        println("mouse over: ", this.id, this.posX);
//      }
//    }
//  }
//}
  
void mousePressed() {
  
  checkClose();
  receiveGridInput();
  
}
