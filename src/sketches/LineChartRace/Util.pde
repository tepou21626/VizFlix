String[] monthNames = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
int[] unitPresets = {1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000, 10000000, 20000000, 50000000, 1000000000};
String[] rankNames = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"};

class Util {
  int N_DAYS;
  
  Util(int nDays) {
    N_DAYS = nDays;
  }
  
  public float valToY(float val, float min_y, float max_y, float min_val, float max_val) {
    return min_y + (max_y - min_y) * ((val - max_val) / (min_val - max_val));
  }
  
  float stepIndex(float[] a, float index) {
    return a[(int) index];
  }
  
  float WAIndex(float[] a, float index, float WINDOW_WIDTH) {
    int startIndex = max(0, ceil(index - WINDOW_WIDTH));
    int endIndex = min(N_DAYS - 1, floor(index + WINDOW_WIDTH));
    float counter = 0;
    float summer = 0;
    for(int d = startIndex; d <= endIndex; d++) {
      float val = a[d];
      float weight = 0.5 + 0.5 * cos((d-index) / WINDOW_WIDTH * PI);
      counter += weight;
      summer += val * weight;
    }
    float finalResult = summer / counter;
    return finalResult;
  }

  float WAIndex(int[] a, float index, float WINDOW_WIDTH){
    float[] aFloat = new float[a.length];
    for(int i = 0; i < a.length; i++){
      aFloat[i] = a[i];
    }
    return WAIndex(aFloat, index, WINDOW_WIDTH);
  }
  
  float getDayFromFrameCount(int frame){
    return (frame / float(FRAMES_PER_DAY)) + START_DAY;
  }
  
  String daysToDate(float daysF, boolean longForm, int start_date){
    int days = (int)daysF + start_date + 1;
    Date d1 = new Date();
    d1.setTime(days * 86400000l);
    int year = d1.getYear() + 1900;
    int month = d1.getMonth() + 1;
    int date = d1.getDate();
    if (longForm) {
      return year + " " + monthNames[month - 1] + " " + date;
    } else{
      return year+ "-" + nf(month, 2, 0) + "-" + nf(date, 2, 0);
    }
  }
  
  void fixOverlaps(float[] coords, float h) {
    boolean hasOverlaps = true;
    
    while (hasOverlaps) {
      hasOverlaps = false;
      boolean[] isOverlapping = new boolean[coords.length];
      for (int i = 0; i < isOverlapping.length; ++i) {
        isOverlapping[i] = false;
      }
      
      // Check for overlaps.
      for (int i = 0; i < coords.length - 1; ++i) {
        float topCoord = coords[i];
        float bottomCoord = coords[i + 1];
        
        if (bottomCoord - topCoord < h) {
          hasOverlaps = true;
          isOverlapping[i] = true;
          isOverlapping[i + 1] = true;
        }
      }
      
      // Correct overlaps.
      for (int i = 0; i < coords.length - 1; ++i) {
        if (isOverlapping[i] && isOverlapping[i + 1]) {
          coords[i] -= .1;
          coords[i + 1] += .1;
        }
      }
    }
  }
  
  int dateToDays(String s) {
    int year = Integer.parseInt(s.substring(0, 4)) - 1900;
    int month = Integer.parseInt(s.substring(5, 7)) - 1;
    int date = Integer.parseInt(s.substring(8, 10));
    Date d1 = new Date(year, month, date, 6, 6, 6);
    int days = (int)(d1.getTime() / 86400000L);
    return days;
  }
  
  String keyify(int n) {
    if (n < 1000) {
      return n + "";
    } else if (n < 1000000) {
      if (n % 1000 == 0) {
        return (n / 1000) + "K";
      } else {
        return nf(n / 1000f, 0, 1) + "K";
      }
    } 
    
    if (n % 1000000 == 0) {
      return (n / 1000000) + "M";
    } else {
      return nf(n / 1000000f, 0, 1) + "M";
    }
  }
  
  String[] splitToLines(String text, float maxLineWidth, int maxDescSize) {
    String[] words = text.split(" ");
    String[] lines = new String[maxDescSize];
    int index = 0;
    String textLine = "";
    
    // Init lines.
    for (int i = 0; i < lines.length; ++i) {
      lines[i] = "";
    }
    
    for (int i = 0; i < words.length; ++i) {
      // Add word.
      textLine += words[i];
      if (i < words.length - 1) {
        // Skip line if exceeding.
        String previewText = textLine + words[i + 1];
        if (textWidth(previewText) >= maxLineWidth) {
          lines[index++] = textLine;
          textLine = "";
        } else {
          // Add space.
          textLine += " ";
        }
      } else {
        // Register last line.
        lines[index] = textLine;
      }
    }
    return lines;
  }
}
