// Text FX class in P4 by vvixi
// needs refactoring
TextFx textfx;
Timer timer, timer2;

class Timer {
  
  int timeStart;
  int timeElapsed;
  int delay;
  
  Timer(int _delay) {
    
    delay = _delay;
    
  }
  
  void start() {
    
    timeStart = millis();
    
  }
  
  Boolean timeUp() {
    
    timeElapsed = millis() - timeStart;
    if (timeElapsed > delay * 800) {

      return true;
    }
    return false;
  }
}
  
void setup() {
  
  timer = new Timer(4);
  timer2 = new Timer(4);
  timer.start();
  frameRate(32);
  size(600, 600);
  textfx = new TextFx(new String[]{"Hurry brave adventurer... ", "FEED  THE  WHITE  RABBIT ...", "Before it's too late...."});
  
}

void draw() {
  
  background(0);
  //println(PFont.list());
  //textfx.bounce();
  //textfx.wavy();
  //textfx.jittery();
  //textfx.still();
  
  if (!timer.timeUp()) {
    
      textfx.still();
      timer2.start();
      
  } else if (timer.timeUp() && !timer2.timeUp()) {

    textfx.bounce();

  } else if (timer.timeUp() && timer2.timeUp()) {
    
    textfx.wavy();

  }
}

class TextFx {
  
  private PFont f;
  private float theta = 0.0;
  private float x = 100;
  private float y = height/4;
  private String[] messages;
  private String msg;
  
  TextFx(String[] _messages){
    
    messages = _messages;
    msg = _messages[0];
    fill(200);
    f = createFont("NotoSerif NFP SemCond Med", 20, true);
    textFont(f);
    textAlign(CENTER);
  }
  
  void clearBg() {
    
    fill(0);
    rect(0, 0, width, height);
  }
  
  void still() {

    msg = messages[0];
    text(msg, width / 4, height/2);
    
  } 
  
  void bounce() {

    msg = messages[1];
    // bouncing text
    y += cos(y) * 4;
    for (int i = 0; i < msg.length(); i++) {
      text(msg.charAt(i), i * 22 + textWidth(msg.charAt(i)), height/4+y);

    }
  }
  
  void wavy() {
    
    msg = messages[2];
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
    
    msg = messages[2];
    // shaking jittery text
    for (int i = 0; i < msg.length(); i++) {
      
      textSize(random(18, 24));
      text(msg.charAt(i), i * 22 + textWidth(msg.charAt(i)), height/4+y);
      y += random(-1, 1);
    
    }
  }
}
