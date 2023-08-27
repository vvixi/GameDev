// isometric tile map in P3 by vvixi

PVector x = new PVector(0.5, 0.25);
PVector y = new PVector(-0.5, 0.25);
PImage t0, t1, t2, t3, t4, t5, t6, t7;
int gridSz = 10;
float tileH = 142, time;
float tileW = 116, y_off = 10;
PImage[] tiles = new PImage[19];
isoMap map;

void setup() {
  
  surface.setTitle("Isometric Tilemap");
  // load tiles from 10 on 
  for (int i = 18; i < tiles.length; i++) { tiles[i] = loadImage("assets/platformerTile_"+i+".png"); }
  size(800, 800);
  frameRate(32);
  stroke(200);
  map = new isoMap();
}

class isoMap {
  
  float a, b, c, d, cap;
  
  void make_isoMap() {
    background(40);
    translate(width/2-tileW/2, 50);
    for (int i = 0; i < gridSz; i++) {
      for (int j = 0; j < gridSz; j++) {
        time++;
        y_off+=1;
        a = i * x.x; 
        b = j * y.x;
        c = i * x.y; 
        d = j * y.y;
        
        // formula for converting tilemap locations into isometric locations
        PVector newV = new PVector((a) + (b), (c) + (d));
        // add a nice wavy effect and draw tiles
        image(tiles[18], (newV.x*tileW)+sin(y_off*.5), ((newV.y)*tileH)+sin(y_off*.5));
      }
    }
  }

void draw() {
  map.make_isoMap();
  map.captureMouse();
}
