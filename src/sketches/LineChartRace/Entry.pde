class Entry {
  String name;
  color c;
  PImage photo;
  
  float lastValue;
  
  int framesAsFirst;
  int framesInTopTen;
  
  int consecutiveFramesAsFirst;
  int consecutiveFramesInTopTen;
  
  boolean isGrowing;
  boolean isPeaking;
  float peak;
  
  float r = random(75, 200);
  float g = random(75, 200);
  float b = random(75, 200);
  
  Entry(String name) {
    this.name = name;
    this.c = color(r, g, b);
    this.photo = loadImage(name + ".png");
    
    this.framesAsFirst = 0;
    this.framesInTopTen = 0;
    this.consecutiveFramesAsFirst = 0;
    this.consecutiveFramesInTopTen = 0;
    
    this.isGrowing = true;
    this.isPeaking = false;
    this.peak = 0;
  }
  
  boolean updateGrowth(float currVal, float prevVal) {
    isGrowing = currVal > prevVal;
    if (!isGrowing) isPeaking = false;
    return isGrowing;
  }
  
  void updatePeak(float val) {
    if (val > peak) {
      isPeaking = true;
      peak = val;
    } else {
      isPeaking = false;
    }
  }
}
