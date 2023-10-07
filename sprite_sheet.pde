// basic spritesheet animations in P4 by vvixi
Player player;
Water water;
Log log;
int[][] map = new int[18][18];

public enum playerState {
  
  IDLE,
  JUMP,
  LAND,
  SINK,
  DRIFT
  
}

void setup() {

  surface.setTitle("Spritesheet");
  frameRate(32);
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
    
    sx = curFrame * w;
    sy = row * h;
    hold = (hold +1)% delay;
    
    switch(player._state) {
  
      case IDLE:
        //println("idle state");
        delay=5;
        
        if (hold == 0) {
          curFrame = (curFrame+1) % totalFrames;
  
        }
        break;
         
      case JUMP:
        //println("jump state");
        delay=2;
        
        if (curFrame < totalFrames) {
          if (hold == 0) {
            curFrame = (curFrame+1);
          }
        }
        if (curFrame == totalFrames) {
          
          row = lastDir;
          curFrame = 0;
          player._state = playerState.IDLE;
        }

        break;
        
      case SINK:
        //println("sink state");
        hold = (hold +1)% delay;
        row = 8;
        lastDir = 1;

        if (curFrame < totalFrames) {
          
          if (hold == 0) {
            curFrame = (curFrame+1);
            
          }
        } 
        if (curFrame == totalFrames) {

          row = lastDir;
          visible = false;

        }

        break;
        
      case DRIFT:
      
        println("drift state");
        player.loc.x -= 1;
        break;
        
    }
  }
}
class Water {
  
  int rowStart = 0;
  int rowEnd = 0;
  int colStart = 0;
  int colEnd = 0;
  int rows;
  int cols;
  float blk = width / 10;

  Water(int _cols, int _rows) {
    rows = _rows;
    cols = _cols;
    
  }
  
  void start() {
    
    rowEnd = rows;
    colEnd = cols;
    
    fill(0, 0, 160);
    for (int i = colStart; i < colEnd; i++) {
      for (int j = rowStart; j < rowEnd; j++) {
        map[i][j] = 1;
        rect(i * blk, j * blk, blk, blk);
        
      }
    }
  }
  
}
class Log {
  
  int rowStart = 0;
  int rowEnd = 0;
  int colStart = 0;
  int colEnd = 0;
  int rows;
  int cols;
  int posX = 5;
  int posY = 4;
  int offsetY = 10;
  float blk = width / 10;

  Log(int _cols, int _rows) {
    rowEnd = _rows;
    colEnd = _cols;
    
  }
  
  void start() {
    
    fill(60, 60, 0);
    for (int i = colStart; i < colEnd; i++) {

      map[posX + i][posY] = 0;
      rect(blk * posX + i*blk, blk * posY+ offsetY, blk, blk- offsetY * 2);

    }
  }
  void update() {
    
    
  }
  
}
class Player {
  
  float blk = width / 10;
  playerState _state = playerState.IDLE;
  PVector loc = new PVector(5*blk,5*blk);
  PImage playerSprite;
  int cooldown = 10;
  Boolean visible = true;
  Sprite sprite;

  
  Player() {

    playerSprite = loadImage("assets/frog.png");
    sprite = new Sprite(loc);

  }
  int testTile(int _locX, int _locY) {
    
    // test a tile passed in to check its type
    int nextX = int(_locX/blk);
    int nextY = int(_locY/blk);
    
    if (map[nextX][nextY] == 1) {

      sprite.loop = false;
      sprite.curFrame = 0;
      sprite.row = 3;
      //loc.y -= blk;
      sprite.lastDir = 1;
      player._state = playerState.SINK;
      return 1;
      
    } else if (map[nextX][nextY] == 2) {
      // obstacle
      return 2;
    } else if (map[nextX][nextY] == 3) {
      // vehicle
      splat();
      return 3;
    }
    return 0;
    
  }
  
  int checkCollision(int _x, int _y) {
    println(loc.x/blk, loc.y/blk, 4);
    if (dist(loc.x/blk, loc.y/blk, _x, _y) < 1) {
      println(1);
      return 1;
    }
    println(0);
    return 0;
  }
  
  void sink() {

   // play death animation
   sprite.delay = 15;
   sprite.loop = false;
   sprite.curFrame = 0;
   sprite.row = 8;
   sprite.lastDir = 1;

  }
  
  void splat() {
   // play death animation
   sprite.loop = false;
   sprite.curFrame = 0;
   //sprite.row =
   sprite.lastDir = 1;
  }
  
  void move(String _dir) {

    if (_dir == "up") {
      if (player.testTile(int(loc.x), int(loc.y - 1))==0) {
        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 3;
        loc.y -= blk;
        sprite.lastDir = 1;
        player._state = playerState.JUMP;

      } else if (player.testTile(int(loc.x), int(loc.y - 1))==1) {

        loc.y -= blk;

      }
      
    } else if (_dir == "right") {
        if (player.testTile(int(loc.x + 1), int(loc.y))==0) {
          sprite.loop = false;
          sprite.curFrame = 0;
          sprite.row = 6;
          loc.x += blk;
          sprite.lastDir = 4;
          player._state = playerState.JUMP;
        }
      
    } else if (_dir == "down") {
        if (player.testTile(int(loc.x), int(loc.y + 1))==0) {
          sprite.loop = false;
          sprite.curFrame = 0;
          sprite.row = 2;
          loc.y += blk;
          sprite.lastDir = 0;
          player._state = playerState.JUMP;
        }
        
    } else if (_dir == "left") {
        if (player.testTile(int(loc.x - 1), int(loc.y))==0) {
          sprite.loop = false;
          sprite.curFrame = 0;
          sprite.row = 7;
          loc.x -= blk;
          sprite.lastDir = 5;
          player._state = playerState.JUMP;
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
  //Water water;
  // setup the game's board
  int rows = int(width / 32);
  int cols = int(height / 32);
  float blk = width / 10;
  //print(rows);
  // half
  water = new Water(int(cols), 5);
  log = new Log(int(5), 4);
  // full
  //water = new Water(int(rows), int(cols));
  fill(0, 60, 0);
  stroke(0, 150, 0);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      map[i][j] = 0; 
      rect(i * blk, j * blk, blk, blk);
    }
  }
  water.start();
  log.start();

}
  
void draw() {
  background(0);
  drawGrid();

  player.sprite.update();  
  player.display();
}
