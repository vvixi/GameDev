// Raycaster in P3 by vvixi
float px=300, py=100, ps=8, pdx, pdy, pa;
int mapX = 8, mapY = 8, mapS = 64, c1;
float DR = 0.0174533;
int[] map = {
  1, 1, 1, 1, 1, 1, 1, 1,
  1, 1, 0, 0, 0, 0, 0, 1,
  1, 0, 0, 0, 0, 0, 0, 1,
  1, 0, 0, 1, 0, 0, 0, 1,
  1, 0, 0, 1, 1, 0, 0, 1,
  1, 0, 0, 0, 0, 0, 0, 1,
  1, 0, 0, 0, 0, 0, 1, 1,
  1, 1, 1, 1, 1, 1, 1, 1,
};

void setup() {
  size(1024, 512);
  pdx=cos(pa)*5; pdy=sin(pa)*5;
}
void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP) {
      px += pdx; py += pdy;
    }
    else if(keyCode == DOWN) {
      px -= pdx; py -= pdy;
    }
    else if(keyCode == LEFT) {
      pa -= 0.1; 
      if (pa < 0){pa += TWO_PI;} pdx=cos(pa)*5; pdy=sin(pa)*5;
    }
    else if(keyCode == RIGHT) {
      pa += 0.1;
      if (pa > TWO_PI){pa -= TWO_PI;} pdx=cos(pa)*5; pdy=sin(pa)*5;
    }
  }
}
float dist(float ax, float ay, float bx, float by, float ang) {
  return (sqrt((bx-ax) * (bx-ax) + (by-ay) * (by-ay)) );
}
void drawMap2D() {
  strokeWeight(1);
  stroke(200, 0, 0);
  for (int y = 0; y < mapY; y++) {
    for (int x = 0; x < mapX; x++) {
      if (map[y*mapX+x]==1) {
        fill(255);
        rect(x*mapS, y*mapS, mapS, mapS);
      } else {
        fill(50);
        rect(x*mapS, y*mapS, mapS, mapS);
      }
    }
  }
}
void drawRays2d() {
  int r, mx, my, mp, dof; float rx=0,  ry=0, ra, xo=0, yo=0, disT=0;
  ra = pa-DR*30; if(ra<0) { ra+=TWO_PI;} if(ra>TWO_PI) { ra-=TWO_PI;}
  ra = pa;
  for (r = 0; r < 60; r++) {
    // check hor lines
    dof = 0;
    float disH=1000000, hx=px, hy=py;
    float aTan=-1/tan(ra);
    if(ra > PI) {ry = (((int)py>>6)<<6)-0.0001; rx=(py-ry)*aTan+px; yo=-64; xo =-yo*aTan;}//up
    if(ra < PI) {ry = (((int)py>>6)<<6)+64; rx=(py-ry)*aTan+px; yo=64; xo =-yo*aTan;}// down
    if (ra==0 || ra==PI) { rx=px; ry=py; dof=mapX;} // looking straight left or right
    while (dof < mapX) {
      mx = int(rx)>>6; my = int(ry)>>6; mp=my*mapX+mx;
      if(mp > 0 && mp < mapX * mapY && map[mp] == 1) { hx=rx; hy=ry; disH=dist(px,py,hx,hy,ra); dof = mapX;} // hit wall
      else { rx += xo; ry += yo; dof +=1;}
    }
    //strokeWeight(4);
    //stroke(0, 200, 0);
    //line(px, py, rx, ry);
    
    // check ver lines
    dof = 0;
    float disV=1000000, vx=px, vy=py;
    float nTan=-tan(ra);
    if(ra > HALF_PI && ra < 3*HALF_PI) {rx = (((int)px>>6)<<6)-0.0001; ry=(px-rx)*nTan+py; xo=-64; yo =-xo*nTan;} // left
    if(ra < HALF_PI || ra > 3*HALF_PI) {rx = (((int)px>>6)<<6)+64; ry=(px-rx)*nTan+py; xo=64; yo =-xo*nTan;} // right
    if (ra==0 || ra==PI) { rx=px; ry=py; dof=mapX;} // looking up or down
    while (dof < mapX) {
      mx = int(rx)>>6; my = int(ry)>>6; mp=my*mapX+mx;
      if(mp > 0 && mp < mapX * mapY && map[mp] == 1) { vx=rx; vy=ry; disV=dist(px,py,vx,vy,ra);dof = mapX;} // hit wall
      else { rx += xo; ry += yo; dof +=1;}
    }
    if (disV<disH) { rx=vx; ry=vy; disT=disV; c1 = (100);}
    if (disH<disV) { rx=hx; ry=hy; disT=disH; c1 = (50);}
    strokeWeight(1);
    stroke(0, 255, 0);
    line(px, py, rx, ry);
    
    // draw 3d scene
    float ca = pa-ra; if (ca<0) { ca+=TWO_PI;} if(ca>TWO_PI) {ca-=TWO_PI;} disT*=cos(ca); // fix fisheye 
    float lineH = (mapS*530)/disT; if (lineH>530) { lineH=530;}
    float lineO=160-lineH/2;
    strokeCap(SQUARE);
    stroke(c1);
    strokeWeight(mapX); line(r*mapX+530, lineO, r*mapX+530, lineH+lineO);
    ra+=DR; if(ra<0) { ra+=TWO_PI;} if(ra>TWO_PI) { ra-=TWO_PI;}
  }
}
void drawPlayer() {
  noStroke();
  fill(200, 200, 0);
  circle(px, py, ps);
  line(px, py, px+pdx*5, py+pdy*5);
}
void draw() {
  background(0);
  drawMap2D();
  drawPlayer();
  drawRays2d();
}
