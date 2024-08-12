import java.util.*;


class Preprocess {
  Util util;
  
  PFont alternateFont;
  float EVENT_LOG_DESCRIPTION_SIZE = 18;
  float MAX_X = 1350;
  float MILESTONE_HMARGIN = 75;
  float EVENT_LOG_PIC_SIZE = 96;
  float EVENT_LOG_SPACING = 3;
  
  int N_ROWS;
  int N_COLUMNS;
  int HISTORY_LENGTH = 150;
  int TOP_DISPLAY = 10;
  
  String[][] channels;
  float[][] values;
  
  float[] maxes;
  float[] mins;
  
  float[] unitChoices;
  
  Event[] events;
  
  Preprocess() {
    alternateFont = loadFont("SegoeUI-48.vlw");
    String channelsFileName = "C:/Users/Tommy/Documents/project/Vizzard/top_10_watched_channels.csv";
    String valuesFileName = "C:/Users/Tommy/Documents/project/Vizzard/top_10_watched_values.csv";
    String eventsFileName = "C:/Users/Tommy/Documents/project/Vizzard/events.csv";
    
    init(channelsFileName, valuesFileName);
    computeMaxes();
    computeMins();
    getUnits();
    processEvents(eventsFileName);
    
  }
  
  void init(String channelsFileName, String valuesFileName) {
    String[] topChannelsFile = loadStrings(channelsFileName);
    String[] topValuesFile = loadStrings(valuesFileName);
    N_ROWS = topChannelsFile.length;
    N_COLUMNS = topChannelsFile[0].split(",").length;
    
    util = new Util(N_ROWS / 30);

    channels = new String[N_ROWS][N_COLUMNS];
    for (int i = 0; i < N_ROWS; ++i) {
      channels[i] = topChannelsFile[i].split(",");
    }
    
    values = new float[N_ROWS][N_COLUMNS];
    for (int i = 0; i < N_ROWS; ++i) {
      String[] valuesList = topValuesFile[i].split(",");
      for (int j = 0; j < N_COLUMNS; ++j) {
        values[i][j] = Float.parseFloat(valuesList[j]);
      }
    }
  }
  
  void computeMaxes() {
    maxes = new float[N_ROWS];
    Deque<Float> maxHistory = new ArrayDeque<>();
    for (int i = 0; i < N_ROWS; ++i) {
      float val = values[i][0] * 1.1;
      maxHistory.addLast(val);
      
      // Control history size.
      if (maxHistory.size() > HISTORY_LENGTH) {
        maxHistory.removeFirst();
      }
      
      // Find max.
      float maxVal = -1;
      for (float v : maxHistory) {
        if (v > maxVal) {
          maxVal = v;
        }
      }
      
      maxes[i] = maxVal;
    }
  }
  
  void computeMins() {
    mins = new float[N_ROWS];
    Deque<Float> minHistory = new ArrayDeque<>();
    for (int i = 0; i < N_ROWS; ++i) {
      float val = values[i][TOP_DISPLAY - 1] * 0.7;
      minHistory.addLast(val);
      
      // Control history size.
      if (minHistory.size() > HISTORY_LENGTH) {
        minHistory.removeFirst();
      }
      
      // Find min.
      float minVal = -1;
      for (float v : minHistory) {
        if (minVal == -1 || v < minVal) {
          minVal = v;
        }
      }
      
      mins[i] = minVal;
    }
  }
  
  void getUnits(){
    unitChoices = new float[N_ROWS / 30 + 1];
    
    for(int i = 0; i < N_ROWS; i += 30){
      float maxVal = maxes[i];
      for(int u = 0; u < unitPresets.length; u++) {
        if(unitPresets[u] >= maxVal / 2){ // That unit was too large for that scaling!
          unitChoices[i / 30] = u - 1; // Fidn the largest unit that WASN'T too large (i.e., the last one.)
          break;
        }
      }
    }
  }
  
  void processEvents(String eventsFileName) {
    String[] eventsFile = loadStrings(eventsFileName);
    int N_EVENTS = eventsFile.length;
    events = new Event[N_EVENTS];
    
    textFont(alternateFont, EVENT_LOG_DESCRIPTION_SIZE);
    float x = MAX_X + MILESTONE_HMARGIN;
    float maxWidth = width - EVENT_LOG_PIC_SIZE - 4 * EVENT_LOG_SPACING - x;
    
    for (int i = 0; i < N_EVENTS; ++i) {
      String[] eventValues = eventsFile[i].split(";");
      String eventDate = eventValues[0];
      String eventFrame = eventValues[1];
      String eventDescription = eventValues[2];
      String eventChannel = eventValues[3];
      String photoName = "event" + eventValues[4];
      Event newEvent = new Event(eventDate, Integer.parseInt(eventFrame), eventDescription, eventChannel, photoName);
      
      String[] lines = util.splitToLines(eventDescription, maxWidth, 3);
      newEvent.l1 = lines[0];
      newEvent.l2 = lines[1];
      newEvent.l3 = lines[2];
      
      events[i] = newEvent;
    }
  }
}
