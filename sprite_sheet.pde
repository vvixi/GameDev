// basic spritesheet animations in P4 by vvixi
Player player;
Water water;

public enum playerState {
  
  IDLE,
  JUMP,
  LAND,
  DRIFT
  
}

void setup() {

  frameRate(60);
  size(600, 600);
  player = new Player();
  
  
}

class Sprite {
  
  Boolean visible = true;
  int totalFrames = 5;
  int curFrame = 0;
  int row = 1;
  int hold = 0;
  int xFrame = 0;
  int delay = 5;
  int x = int(width-32);
  int y = 0;
  int sx = 0;
  int sy = 0;
  int offsX = xFrame * sx; // replace 0 with mult of w
  int offsY = 0 * sx;
  int w = 32;
  int h = w;
  int lastDir = 0;
  Boolean playing = false;
  Boolean loop = true;
  Boolean end = false;
  Sprite(PVector _pos) {
    x = int(_pos.x);
    y = int(_pos.y);
  }
  void update() {
    //println(x, y);
    sx = curFrame * w;
    sy = row * h;
    hold = (hold +1)% delay;
    if (loop && !playing) {
      //println("idle");
      delay=10;
      if (hold == 0) {
        curFrame = (curFrame+1) % totalFrames;

      }
    } else if (!loop) {
      //println("jump");
      delay=2;
      playing = true;
      if (curFrame < totalFrames) {
        if (hold == 0) {
          curFrame = (curFrame+1);
          
        }
      }
      if (curFrame == totalFrames) {
        //println("switch");
        row = lastDir;
        curFrame = 0;
        loop = true;
        playing = false;
        return;
      }
    }
    
    if (playing) {
      
      switch(player._state) {
    
        case IDLE:

          break;
           
        case JUMP:

          break;
          

      }
    }
  }
}
class Water {
  
  //int 
  int rowStart = 0;
  int rowEnd = 0;
  int colStart = 0;
  int colEnd = 0;
  int rows;
  int cols;
  
  //PVector locStart = new PVector(rowStart, colStart);
  //PVector locEnd = new PVector(rowEnd, colEnd);
  Water(int _rows, int _cols) {
    rows = _rows;
    cols = _cols;
    
  }
  
  void start() {
    
    rowEnd = rows;
    colEnd = cols;
    float blk = width / 10;
    fill(0, 0, 160);
    for (int i = rowStart; i < rowEnd; i++) {
      for (int j = colStart; j < colEnd; j++) {
        
        rect(i * blk, j * blk, blk, blk);
        
      }
    }
  }
}
class Player {
  
  float blk = width / 10;
  playerState _state = playerState.IDLE;
  PVector loc = new PVector(5*blk,5*blk);
  int posX = int(loc.x / blk);
  int posY = int(loc.y / blk);
  PImage playerSprite;
  int cooldown = 10;
  Boolean visible = true;
  Sprite sprite;

  
  Player() {

    playerSprite = loadImage("assets/frog.png");
    sprite = new Sprite(loc);

  }
  Boolean testTile(int _locX, int _locY) {
    
    // test a tile passed in to check its type
    // needs functionality
    int nextX = _locX;
    int nextY = _locY;
    
    return true;
    
  }
  void move(String _dir) {
    
    if (_dir == "up") {
      if (player.testTile(int(loc.x), int(loc.y - 1))) {
        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 3;
        loc.y -= blk;
        sprite.lastDir = 1;
      }
      
    } else if (_dir == "right") {
        if (player.testTile(int(loc.x + 1), int(loc.y))) {
          sprite.loop = false;
          sprite.curFrame = 0;
          sprite.row = 6;
          loc.x += blk;
          sprite.lastDir = 4;
        }
      
    } else if (_dir == "down") {
        if (player.testTile(int(loc.x), int(loc.y + 1))) {
          sprite.loop = false;
          sprite.curFrame = 0;
          sprite.row = 3;
          loc.y += blk;
          sprite.lastDir = 0;
        }
        
      } else if (_dir == "left") {
          if (player.testTile(int(loc.x - 1), int(loc.y))) {
            sprite.loop = false;
            sprite.curFrame = 0;
            sprite.row = 7;
            loc.x -= blk;
            sprite.lastDir = 5;
          }
    }
  }
  
  void display() {
    
    
    if (visible) {
      copy(playerSprite, sprite.sx+sprite.offsX, sprite.sy+sprite.offsY, sprite.w, sprite.h, int(loc.x), int(loc.y), sprite.w*2, sprite.h*2);
    }
    
}
  void keyPressed() {

    if(key == CODED) {

      if(keyCode == UP) {
        
        player.move("up");
        
      } else if(keyCode == DOWN) {
        
        player.move("down");


      } else if(keyCode == RIGHT) {
        
        player.move("right");
        
      } else if(keyCode == LEFT) {
        
        player.move("left");

      }

    }
  }
}
void keyPressed() {
  
  player.keyPressed();
}


void keyReleased() {

}

void drawGrid() {
  Water water;
  // setup the game's board
  float rows = width / 32;
  float cols = height / 32;
  float blk = width / 10;
  
  // half
  water = new Water(int(rows), 5);
  // full
  //water = new Water(int(rows), int(cols));
  fill(0, 60, 0);
  stroke(0, 150, 0);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      rect(i * blk, j * blk, blk, blk);
    }
  }
  water.start();
  //entities.start();
}
  
void draw() {
  background(0);
  drawGrid();
  //player.testTile();
  player.sprite.update();  
  player.display();
}
