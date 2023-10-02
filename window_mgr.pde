// Simple popup window system to contain UI elements
// implemented in P4 by vvixi
// more bug-fixes, and new params added, additional notes and cleanup
Window window;

void setup() {

  size(900, 900);
  //set this for top or bottom windows
  //window = new Window("bottomHalf");
  //window = new Window("bottomBar");
  //window = new Window("topHalf");
  //window = new Window("topBar");
  //window = new Window("rightHalf");
  //window = new Window("leftHalf");
  window = new Window("listFull");
  
}

void draw() {
  
  background(0);
  window.display();
  window.checkMouseOver();

}

public class Window {
  
  // creates windows based on string passed in
  // params: "topHalf", "topBar","leftHalf", "rightHalf", "bottomHalf", "bottomBar", "twoColumn", "listFull"
  private PVector[][] gridPositions;
  private Boolean displayed = true;
  private Boolean showClose = true;
  private String position;
  private PVector size;
  private float vOffset;
  private int closeStartX;
  private int closeStartY;
  private int topRight;
  private PVector gridSize;
  private int divH;
  private int divV;
  private int bufferX=0, bufferY=50;
  private PVector block;
  
  Window(String _position) {

    position = _position;

  }
  
  private void drawClose(int _startX, int _startY) {
    
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
    
    // displays the window based on the string: "position"
    if (displayed) {
      rectMode(CORNER);
      fill(50);
      
      if (position == "rightHalf") {
        
        size = new PVector(width / 2, height);
        topRight = width;
        bufferX = width / 2;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(bufferX, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 5, 5);
        
      } else if (position == "leftHalf") {
        
        size = new PVector(width / 2, height);
        topRight = width / 2;
        bufferX = 0;
        closeStartX = width/2 - 50;
        closeStartY = 0;
        rect(bufferX, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 4, 4);
        
      } else if (position == "topBar") {
        
        size = new PVector(width, height / 2 - height / 4);
        topRight = width;
        bufferY = 0;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y);
        drawGrid(new PVector(size.x-50, size.y), 6, 1);

      } else if (position == "topHalf") {
        
        size = new PVector(width, height/2);
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 2, 3);
        
      } else if (position == "bottomBar") {
        
        size = new PVector(width, height / 2 + height / 4);
        vOffset = size.y;
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = height / 2 + height / 4 + bufferY;
        rect(0, size.y + bufferY, size.x, size.y);
        drawGrid(new PVector(size.x-50, height /2 + size.y), 6, 1);
        
      } else if (position == "bottomHalf") {
        
        size = new PVector(width, height/2);
        vOffset = height / 2;
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = height / 2;
        rect(0, height / 2, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 3, 3);
      
      } else if (position == "twoColumn") {
        
        size = new PVector(width, height);
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 2, 3);
      
      } else if (position == "listFull") {
        
        size = new PVector(width, height);
        topRight = width;
        bufferY = 50;
        closeStartX = width - 50;
        closeStartY = 0;
        rect(0, 0, size.x, size.y);
        drawGrid(new PVector(size.x, size.y), 1, 8);
      }
      
      if(showClose) { drawClose(closeStartX, closeStartY); }
      if(showClose) { drawClose(closeStartX, closeStartY); }
    } 
  }
  void drawGrid(PVector _gSize, int _divH, int _divV) {
    
    // draws the UI grid within the displayed window
    //GridCell gridCell;
    gridSize = _gSize;
    divH = _divH;
    divV = _divV;

    // determines block size for the below loop
    block = new PVector(gridSize.x / divH, gridSize.y / divV - (bufferY / divV));

    fill(200);
    gridPositions = new PVector[divH][divV];
    for (int i = 0; i < divH; i++) {
      for (int j = 0; j < divV; j++) {
        gridPositions[i][j] = new PVector(bufferX + i * block.x, bufferY + j * block.y + vOffset);
        
        rect(bufferX + i * block.x, bufferY + j * block.y + vOffset, gridSize.x / divH, gridSize.y / divV - (bufferY / divV));
        //gridCells.add(new GridCell(bufferX + i * block.x, bufferY + j * block.y + vOffset, gridSize.x / divH, gridSize.y / divV - (bufferY / divV)));
      }
    }
  }
  void checkClose() {

    // test for user closing a window
    if (mouseX > topRight - 50 && mouseX < topRight &&
    mouseY > closeStartY && mouseY < closeStartY+50) {
      displayed = false;
    }
  }
  void checkMouseOver() {
    // test for mouse over a cell, highlight cell to show user
    if (displayed) {
      float cellXsize = gridSize.x / divH;
      float cellYsize = gridSize.y / divV - (bufferY / divV);
      
      for (int i = 0; i < gridPositions.length; i++) {
        for (int j = 0; j < gridPositions[0].length; j++) {
          if(mouseX > gridPositions[i][j].x && mouseX < gridPositions[i][j].x + cellXsize &&
          mouseY > gridPositions[i][j].y && mouseY < gridPositions[i][j].y + cellYsize) {
            fill(0, 180, 220);
            rect(gridPositions[i][j].x, gridPositions[i][j].y, cellXsize, cellYsize);
          } 
        }
      }
    }
  }
  PVector translateMouse() {
    
    // helper function to translate the mouse into the UI grid
    // this needs to account for bufferY which is throwing the input off
    PVector cell = new PVector(0, 0);
  
    cell.x = floor(mouseX / window.block.x);
    cell.y = floor((mouseY / window.block.y)-(window.bufferY/window.block.y));
    //println(window.divV/window.block.y);
    fill(0, 100, 200);
    //rect(cell.x * window.block.x, (cell.y * window.block.y), window.block.x, window.block.y);
    if (window.position == "rightHalf") {
      
      // here we are accounting for the grid starting on the right half
      // of the screen, adjusting x to be 0 instead of 5 in the 0,0 spot
      // the right window and bottom require this distinction
      cell.x -= divH;
      
    } else if (window.position == "bottomHalf") {

      // the obvious cell.y - this.divV didn't work so this is an ugly work around
      cell.y = floor((mouseY / block.y)-(bufferY/block.y) - divV - bufferY/block.y);

    }
    return new PVector(cell.x, cell.y);
  }
  
  PVector receiveGridInput() {

    PVector pos = translateMouse();
    
    // this captures user input from the grid
    // cell select
    if (pos.x == 0 && pos.y == 0) {
      
      window = new Window("leftHalf");
      println("0 - 0");

    } else if (pos.x == 1 && pos.y == 0) {
      
      window = new Window("rightHalf");
      println("1 - 0");

    } else if (pos.x == 2 && pos.y == 0) {
      
      window = new Window("topHalf");
      println("2 - 0");

    } else if (pos.x == 3 && pos.y == 0) {
      
      window = new Window("bottomHalf");
      println("2 - 1");

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
