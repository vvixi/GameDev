// basic spritesheet animations in P4 by vvixi
Player player;

public enum playerState {
  
  IDLE,
  JUMP,
  DRIFT
  
}

void setup() {

  frameRate(60);
  size(600, 600);
  player = new Player();
}

class Sprite {
  
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

class Player {
  playerState _state = playerState.IDLE;
  PVector loc = new PVector(width/2, height/2);
  PImage playerSprite;
  int cooldown = 10;
  Sprite sprite;

  
  Player() {

    //loc.x = constrain(loc.x, 0, width);
    //loc.y = constrain(loc.y, 0, height);
    playerSprite = loadImage("assets/frog.png");
    sprite = new Sprite(new PVector(0, 0));

  }
  void display() {

    copy(playerSprite, sprite.sx+sprite.offsX, sprite.sy+sprite.offsY, sprite.w, sprite.h, int(loc.x), int(loc.y), sprite.w*2, sprite.h*2);
    
}
  void keyPressed() {

    if(key == CODED) {

      if(keyCode == UP) {

        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 3;
        loc.y -= sprite.w*2;
        sprite.lastDir = 1;
        
      } else if(keyCode == DOWN) {
        
        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 2;
        loc.y += sprite.w*2;
        sprite.lastDir = 0;

      } else if(keyCode == RIGHT) {
        
        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 6;
        loc.x += sprite.w*2;
        sprite.lastDir = 4;
        
      } else if(keyCode == LEFT) {
        
        sprite.loop = false;
        sprite.curFrame = 0;
        sprite.row = 7;
        loc.x -= sprite.w*2;
        sprite.lastDir = 5;
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
  float rows = width / 32;
  float cols = height / 32;
  float blk = width / 10;

  fill(0, 60, 0);
  stroke(0, 150, 0);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      rect(i * blk, j * blk, blk, blk);
    }
  }
}
  
void draw() {
  background(0);
  drawGrid();
  player.sprite.update();  
  player.display();
}
