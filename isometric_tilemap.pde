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
  PVector p = new PVector(mouseX * tileH, (mouseY + tileH / 2) * tileW); 
  
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
  
  public PVector screen2map() {
    // formula for capturing the mouse or entity location
    // cap = 1 / (a*d) - (b*c);
    // println(cap);
    float tileArea = tileH * tileW;
    float constX = -height / 2 * tileW + width/2 * tileH;
    float constY = -height / 2 * tileW - width/2 * tileH;
    // tiles anchored by center, not bottom
 
    if (frameCount % 120 == 0) {
      println(new PVector(((p.y - p.x + constX) / tileArea), ((p.y + p.x + constY) / tileArea)));
    }
    return new PVector(int((p.y - p.x + constX) / tileArea), int((p.y + p.x + constY) / tileArea));
  }
  public PVector map2screen() {
    PVector screenCen = new PVector(int(width/2), int(height/2));
    PVector screenPoint = new PVector(floor((p.y - p.x) * tileW / 2), floor((p.y + p.x) * tileH /2));
    PVector result = screenCen.add(screenPoint);
    result = new PVector(floor(result.x), floor(result.y));
    
    if (frameCount % 120 == 0) {
      
      println(result);
      
    }
    return result;
  }
}

void draw() {
  map.make_isoMap();
  
  map.screen2map();
}
