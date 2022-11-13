// basic timer class in P3 by vvixi
Timer timer;
void setup() {
  timer = new Timer();
  timer.timeStart = millis();
}
void draw() {
  timer.run();
}

void keyPressed() {
  timer.timeStart = millis();
}
class Timer {
  int timeStart;
  int timeElapsed;
  Timer() {
  }
  void run() {
    timeElapsed = millis() - timeStart;
    println(timeElapsed);
    if (timeElapsed > 2000) {
      timeStart = millis();
    }
  }
}
