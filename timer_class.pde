// basic timer class in P4 by vvixi
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
