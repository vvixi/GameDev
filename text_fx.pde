// Text FX class in P4 by vvixi
TextFx textfx;

void setup() {

  frameRate(32);
  size(600, 600);
  textfx = new TextFx(new String[]{"FEED  THE  WHITE  RABBIT ...",});
  
}

void draw() {
  
  //println(PFont.list());
  background(0);
  //textfx.bounce();
  //textfx.wavy();
  textfx.jittery();
  
}

class TextFx {
  
  private PFont f;
  private float theta = 0.0;
  private float x = 100;
  private float y = height/4;
  private String[] messages;
  private String msg;

  // params: you must pass in a String array
  TextFx(String[] _messages){
    
    messages = _messages;
    msg = _messages[0];
    f = createFont("NotoSerif NFP SemCond Med", 20, true);
    textFont(f);
    textAlign(CENTER);
  }
  
  void bounce() {
    
    // bouncing text
    fill(200);
    y += cos(y) * 4;
    for (int i = 0; i < msg.length(); i++) {
      text(msg.charAt(i), i * 22 + textWidth(msg.charAt(i)), height/4+y);
    }
  }
  
  void wavy() {

    // wavy text
    theta += 0.2;
    x = theta;
    for (int i = 0; i < msg.length(); i++) {
      y += cos(y) * 3.6;
      text(msg.charAt(i), i * 22 + textWidth(msg.charAt(i)), height/4+y);
      x += 0.02;
    }
  }
  
  void jittery() {
    
    // shaking jittery text
    for (int i = 0; i < msg.length(); i++) {
      textSize(random(18, 24));
      text(msg.charAt(i), i * 22 + textWidth(msg.charAt(i)), height/4+y);
      y += random(-1, 1);
    
    }
  }
}
