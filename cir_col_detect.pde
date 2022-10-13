// basic circle collision detection by vvixi
float c1x, c1y, cirRad, c2x, c2y = height+100, cRad2;

void setup() {
  size(600, 600);
  c1x = width/2;
  c1y = height/2;
  cirRad = 100;
  c2x = width/2;
  c2y = height;
  cRad2 = 50;
}

void draw() {
  background(0);
  if(dist(c2x, c2y, c1x, c1y) < cirRad) {
    fill(255, 0, 0);
  }
  else { fill(0, 0, 255); }
  ellipse(c1x, c1y, cirRad*2, cirRad*2);
  ellipse(c2x, c2y, cRad2, cRad2);
  c2y-=10;
  if (c2y < 0) {
    c2y = height;
  }
}
