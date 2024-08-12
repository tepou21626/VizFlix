import com.hamoid.*;

Preprocess preprocess;
Drawer drawer;
Util util;
VideoExport videoExport;

int FRAMES_PER_DAY = 30;
int START_DAY = 0;
int frame = START_DAY * FRAMES_PER_DAY;
float currentDay = START_DAY;

int WINDOW_HEIGHT = 1080;
int WINDOW_WIDTH = 1920;

void setup() {
  preprocess = new Preprocess();
  drawer = new Drawer(preprocess.util, preprocess);
  size(1920, 1080);
  
  videoExport = new VideoExport(this, "output.mp4");
  videoExport.startMovie();
}

void draw() {
  currentDay = preprocess.util.getDayFromFrameCount(frame);
  drawer.updatePreviousTopTen(frame);
  drawer.drawBackground();
  drawer.registerEntries(frame);
  drawer.drawTicks(frame, true);
  drawer.drawDates(frame, true);
  drawer.saveDataPoints(frame);
  drawer.drawLines(frame);
  drawer.drawRecords(frame);
  drawer.drawDataPoints(frame);
  drawer.triggerEvent(frame);
  drawer.drawEvents(frame);
  drawer.drawTicks(frame, false);
  drawer.drawAxes();
  drawer.drawLabels(frame);
  drawer.drawDates(frame, false);
  drawer.drawProfile(frame);
  drawer.drawMilestones(frame);
  drawer.drawEventLog(frame);
  
  ++frame;
  
  println(currentDay);
  
  saveVideoFrame();
}

void main() {
}

void saveVideoFrame() {
  videoExport.saveFrame();
  if (frame >= preprocess.N_ROWS) { 
    videoExport.endMovie();
    exit();
  }
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
