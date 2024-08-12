class Drawer {
  Util util;
  Preprocess preprocess;
  
  int TOP_DISPLAY = 10;
  
  HashMap<String, Entry> entries = new HashMap<String, Entry>();
  Deque<HashMap<String, Float>> savedValues = new ArrayDeque<>();
  float[] labelCoords = new float[TOP_DISPLAY];
  float[] circleCoords = new float[TOP_DISPLAY];
  Deque<Milestone> milestones = new ArrayDeque<>();
  HashMap<String, Float> prevValues = new HashMap<String, Float>();
  
  HashSet<String> recordHolders = new HashSet<>();
  ArrayList<Entry> records = new ArrayList<Entry>();
  
  int eventCounter = 0;
  Deque<Event> eventsToDraw = new ArrayDeque<>();
  Deque<Event> eventsOnDisplay = new ArrayDeque<>();
  
  // DRAWING AREA
  float MIN_Y = 150;
  float MAX_Y = 1020;
  float MIN_X = 100;
  float MAX_X = 1350;

  // CIRCLES
  int CIRCLE_RADIUS = 12;
  int CIRCLE_HMARGIN = 20;
  float CIRCLE_POS_X = 1175;
  
  // COLORS
  color BACKGROUND_COLOR = color(0, 15, 50);
  color TEXT_COLOR = color(100);
  
  // TICKS
  float TICK_SIZE = 24;
  float TICK_MARGIN = 5;
  float TICK_WIDTH = 2;
  float TICK_DISPLAY_MARGIN = 25;
  float TICK_FADE_MARGIN = 50;
  
  // TEXT
  PFont font;
  PFont alternateFont;
  int DATE_SIZE = 44;
  int SUBTITLE_SIZE = 28;
  int LABEL_SIZE = 22;
  int LABEL_MARGIN = 5;
  
  float LABEL_PIC_SIZE = 15;

  int DATE_HMARGIN = 40;
  int DATE_VMARGIN = 20;
  int START_DATE;
  
  // MILESTONE
  float MILESTONE_SIZE = 14;
  float MILESTONE_TITLE_SIZE = 28;
  float MILESTONE_VMARGIN = 450;
  float MILESTONE_HMARGIN = 75;
  float MILESTONE_SPACING = 2;
  float MILESTONE_DURATION = 25 * FRAMES_PER_DAY;
  float MILESTONE_FADE_DURATION = 1 * FRAMES_PER_DAY;
  float MILESTONE_FADE_OFFSET = 300;
  int MAX_MILESTONES = 15;
  
  // RECORDS
  int N_RECORDS = 30;
  float RECORD_SIZE = 20;
  float RECORD_MARGIN = 3;
  float RECORDS_FADE_DURATION = 50;
  float FRAMES_RECORDS_DISPLAY_1 = 1250 * FRAMES_PER_DAY;
  float FRAMES_RECORDS_DISPLAY_2 = 1800 * FRAMES_PER_DAY;
  
  // EVENTS
  float EVENT_ANIM_DURATION = 25;
  float EVENT_BAR_HEIGHT = 10;
  float EVENT_BAR_WIDTH = 14;
  float EVENT_PIC_FADE_DURATION = 45;
  float EVENT_PIC_SIZE = 75;
  float EVENT_PIC_PADDING = 3;
  
  // EVENT LOG
  float EVENT_LOG_VMARGIN = 50;
  float EVENT_LOG_HMARGIN = 75;
  float EVENT_LOG_PIC_SIZE = 96;
  float EVENT_LOG_TITLE_SIZE = 24;
  float EVENT_LOG_TITLE_MARGIN = 5;
  float EVENT_LOG_DESCRIPTION_SIZE = 18;
  float EVENT_LOG_SPACING = 3;
  float MAX_EVENT_LOG_SIZE = 4;
  float MAX_DESCRIPTION_SIZE = 3;
  
  Drawer(Util util, Preprocess preprocess) {
    font = loadFont("Impact-48.vlw");
    alternateFont = loadFont("SegoeUI-48.vlw");
    this.util = util;
    this.preprocess = preprocess;
    START_DATE = util.dateToDays("2016-11-19");
    
  }
  
  void drawBackground() {
    background(BACKGROUND_COLOR);
    fill(255);
    textAlign(RIGHT);
    textFont(font, SUBTITLE_SIZE);
    text("on", width - DATE_HMARGIN, DATE_VMARGIN + SUBTITLE_SIZE);
    fill(164, 20, 164);
    text("Twitch Channels ", width - textWidth("on") - DATE_HMARGIN, DATE_VMARGIN + SUBTITLE_SIZE);
    fill(255);
    text("Most Watched ", width - textWidth("Twitch Channels on") - DATE_HMARGIN, DATE_VMARGIN + SUBTITLE_SIZE);
    textFont(font, DATE_SIZE);
    text(util.daysToDate(currentDay, true, START_DATE), width - DATE_HMARGIN, DATE_VMARGIN + SUBTITLE_SIZE + DATE_SIZE);
    fill(TEXT_COLOR);
    textAlign(CENTER);
    
  }
  
  void drawAxes() {
    noStroke();
    fill(255);
    rect(MIN_X, MAX_Y - TICK_WIDTH / 2, MAX_X - MIN_X, TICK_WIDTH);
    rect(MIN_X - TICK_WIDTH / 2, MIN_Y, TICK_WIDTH, MAX_Y - MIN_Y);
  }
  
  void registerEntries(int frame) {
    String[] channels = preprocess.channels[frame];
    float[] values = preprocess.values[frame];
    float minScale = preprocess.mins[frame];
    float maxScale = preprocess.maxes[frame];
    
    // Update list of channels.
    for (int i = 0; i < channels.length; ++i) {
      if (!entries.containsKey(channels[i])) {
        Entry e = new Entry(channels[i]);
        if (frame > 0) milestones.addLast(new Milestone(e, frame, "has entered the Top 10."));
        entries.put(channels[i], e);
      }
    }
        
    for (int i = 0; i < TOP_DISPLAY; ++i) {
      Entry entry = entries.get(channels[i]);
      entry.lastValue = values[i];
      float y = util.valToY(values[i], MIN_Y, MAX_Y, minScale, maxScale);
      circleCoords[i] = y;
      labelCoords[i] = y + LABEL_SIZE / 2;
      
      ++entry.framesInTopTen;
      checkDaysInTopTenMilestone(entry, frame);
      if (frame > 0) {
        if (prevValues.containsKey(entry.name)) {
          ++entry.consecutiveFramesInTopTen;
          checkConsecutiveDaysInTopTenMilestone(entry, frame);
          float prevVal = prevValues.get(entry.name);
          float currVal = values[i];
          boolean isGrowing = entry.updateGrowth(currVal, prevVal);
          if (isGrowing) { 
            entry.updatePeak(currVal);
            updateRecords(entry);
          } 
        } else {
          entry.consecutiveFramesInTopTen = 1;
        }
      }
      
      if (i == 0) {
        ++entry.framesAsFirst;
        // Add milestone for days as first.
        checkDaysAsFirstMilestone(entry, frame);
        if (frame > 0 && preprocess.channels[frame - 1][0].equals(channels[i])) {
          ++entry.consecutiveFramesAsFirst;
          // Add milestone for consecutive days as first.
          checkConsecutiveDaysAsFirstMilestone(entry, frame);
        } else {
          entry.consecutiveFramesAsFirst = 1;
        }
      }
    }
  }
  
  void updatePreviousTopTen(int frame) {
    if (frame == 0) return;
    String[] channels = preprocess.channels[frame - 1];
    float[] values = preprocess.values[frame - 1];
    prevValues = new HashMap<String, Float>();
    for (int i = 0; i < TOP_DISPLAY; ++i) {
      prevValues.put(channels[i], values[i]);
    }
  }
  
  void drawDataPoints(int frame) {
    String[] channels = preprocess.channels[frame];
    noStroke(); 
    textAlign(LEFT);
    
    for (int i = 0; i < TOP_DISPLAY; ++i) {
      Entry entry = entries.get(channels[i]);
      fill(entry.isGrowing ? color(entry.r + 50, entry.g + 50, entry.b + 50) : entry.c);
      float x = min(MIN_X + frame, CIRCLE_POS_X);
      ellipse(x, circleCoords[i], CIRCLE_RADIUS, CIRCLE_RADIUS);
    }
  }
  
  void drawLabels(int frame) {
    textFont(font, LABEL_SIZE);
    util.fixOverlaps(labelCoords, LABEL_SIZE);
    
    // Draw labels.
    String[] channels = preprocess.channels[frame];
    textFont(font, LABEL_SIZE);
    textAlign(LEFT);
    float x = min(MIN_X + frame + CIRCLE_RADIUS / 2 + LABEL_MARGIN, CIRCLE_POS_X + CIRCLE_RADIUS / 2 + LABEL_MARGIN);
    for (int i = 0; i < labelCoords.length; ++i) {
        fill(BACKGROUND_COLOR);
        String targetText = channels[i];
        float y = labelCoords[i];
        image(entries.get(targetText).photo, x, y - LABEL_PIC_SIZE, LABEL_PIC_SIZE, LABEL_PIC_SIZE);
        rect(x + LABEL_PIC_SIZE + LABEL_MARGIN, y - LABEL_SIZE, textWidth(targetText), LABEL_SIZE);
        fill(entries.get(targetText).c);
        text(targetText, x + LABEL_PIC_SIZE + LABEL_MARGIN, y);
    }
    
  }
  
  void saveDataPoints(int frame) {
    String[] channels = preprocess.channels[frame];
    float[] values = preprocess.values[frame];
    
    HashMap<String, Float> savedFrame = new HashMap<String, Float>();
    for(int i = 0; i < values.length; ++i) {
      savedFrame.put(channels[i], values[i]);
    }
    
    savedValues.addLast(savedFrame);
    
    if (savedValues.size() > (CIRCLE_POS_X - MIN_X)) {
      savedValues.removeFirst();
    }
  }
  
  void drawLines(int frame) {
    float minScale = preprocess.mins[frame];
    float maxScale = preprocess.maxes[frame];
    
    Iterator<HashMap<String, Float>> currIt = savedValues.iterator();
    Iterator<HashMap<String, Float>> nextIt = savedValues.iterator();
    nextIt.next();
    
    int counter = 0;
    while (nextIt.hasNext()) {
      HashMap<String, Float> currFrame = currIt.next();
      HashMap<String, Float> nextFrame = nextIt.next();
      
      if (counter > savedValues.size() - CIRCLE_RADIUS / 4) {
        break;
      }
      
      for (String channel : currFrame.keySet()) { 
        if (nextFrame.containsKey(channel)) {
          Entry entry = entries.get(channel);
          float currY = util.valToY(currFrame.get(channel), MIN_Y, MAX_Y, minScale, maxScale);
          float nextY = util.valToY(nextFrame.get(channel), MIN_Y, MAX_Y, minScale, maxScale);
          float currX = MIN_X + counter;
          float nextX = MIN_X + counter;
          stroke(entry.c);
          line(currX, currY, nextX, nextY);
        }
      }
      counter++;
    }
  }
  
  void drawTicks(int frame, boolean axes) {   
    // Draw foreground.
    noStroke();
    fill(BACKGROUND_COLOR);
    rect(0, 0, MIN_X - .5, 1080);
    
    float maxScale = preprocess.maxes[frame];
    float minScale = preprocess.mins[frame];
    
    float preferredUnit = util.WAIndex(preprocess.unitChoices, currentDay, 3);
    float unitRem = preferredUnit % 1.0;
    
    if (unitRem < 0.001){
      unitRem = 0;
    } else if (unitRem >= 0.999){
      unitRem = 0;
      preferredUnit = ceil(preferredUnit);
    }
    int thisUnit = unitPresets[(int)preferredUnit];
    int nextUnit = unitPresets[(int)preferredUnit + 1];
    
    drawTickMarksOfUnit(thisUnit, 255 - unitRem * 255, minScale, maxScale, axes);
    if (unitRem >= 0.001){
      drawTickMarksOfUnit(nextUnit, unitRem * 255, minScale, maxScale, axes);
    }
    
    // Draw foreground.
    fill(BACKGROUND_COLOR);
    rect(0, MAX_Y + .5, 1920, 1080);
    
  }
  
  void drawTickMarksOfUnit(int u, float alpha, float minScale, float maxScale, boolean axes) {
    for (int v = 0; v < maxScale; v += u) {
      float y = util.valToY(v, MIN_Y, MAX_Y, minScale, maxScale);
      if (axes) {
        fill(100, 100, 100, alpha);
        rect(MIN_X, y - TICK_WIDTH / 2, MAX_X - MIN_X, TICK_WIDTH);
      } else {
        textAlign(RIGHT);
        fill(255, 255, 255, alpha);
        rect(MIN_X - TICK_MARGIN, y - TICK_WIDTH, TICK_MARGIN, TICK_WIDTH * 2);
        textFont(font, TICK_SIZE);
        text(util.keyify(v), MIN_X - 2 * TICK_MARGIN, y + TICK_SIZE / 2);
      }
    }
  }
  
  void drawDates(int frame, boolean axes) {
    textAlign(CENTER);
    float y = MAX_Y + TICK_MARGIN + TICK_SIZE;
    noStroke();
    if (frame < CIRCLE_POS_X - MIN_X) {
      for (int i = 1; i * 7 * 30 < MAX_X - MIN_X; ++i) {
        float x = MIN_X + i * 7 * 30;
        float day = i * 7;
        if (axes) {
          fill(100, 100, 100);
          rect(x - TICK_WIDTH / 2, MIN_Y, TICK_WIDTH, MAX_Y - MIN_Y);
        } else {
          fill(255, 255, 255);
          text(util.daysToDate(day, true, START_DATE), x, y);
          rect(x - TICK_WIDTH, MAX_Y, 2 * TICK_WIDTH, TICK_MARGIN);
        }
      }
    } else {
      int day = int((frame - CIRCLE_POS_X) / (7 * 30));
      day = day - day % 7;
      float x = CIRCLE_POS_X + (day - currentDay) * (30);
      if (axes) {
        fill(100, 100, 100, computeOpacity(x));
        rect(x - TICK_WIDTH, MAX_Y, 2 * TICK_WIDTH, TICK_MARGIN);
      } else {
        fill(255, 255, 255, computeOpacity(x));
        text(util.daysToDate(day, true, START_DATE), x, y);
        rect(x - TICK_WIDTH / 2, MIN_Y, TICK_WIDTH, MAX_Y - MIN_Y);
      }
      while (x < MAX_X) {
        day += 7;
        x = CIRCLE_POS_X + (day - currentDay) * (30);
        if (axes) {
          fill(100, 100, 100, computeOpacity(x));
          rect(x - TICK_WIDTH / 2, MIN_Y, TICK_WIDTH, MAX_Y - MIN_Y);
        } else {
          fill(255, 255, 255, computeOpacity(x));
          text(util.daysToDate(day, true, START_DATE), x, y);
          rect(x - TICK_WIDTH, MAX_Y, 2 * TICK_WIDTH, TICK_MARGIN);
        }
      }
    }
  }
  
  float computeOpacity(float x) {
    if (x < MIN_X + TICK_DISPLAY_MARGIN || x > MAX_X - TICK_DISPLAY_MARGIN) {
      return 0;
    } else if (x < MIN_X + TICK_FADE_MARGIN) {
      return (x - MIN_X - TICK_DISPLAY_MARGIN) / (TICK_FADE_MARGIN - TICK_DISPLAY_MARGIN) * 255;
    } else if (x > MAX_X - TICK_FADE_MARGIN) {
      return (MAX_X - x - TICK_DISPLAY_MARGIN) / (TICK_FADE_MARGIN - TICK_DISPLAY_MARGIN) * 255;
    } else {
      return 255;
    }
  }
  
  void drawProfile(int frame) {
    String channel = preprocess.channels[frame][0];
    float hours = preprocess.values[frame][0];
    Entry entry = entries.get(channel);
    float pictureSize = MIN_Y - 2 * DATE_VMARGIN;
    image(entry.photo, DATE_VMARGIN, DATE_VMARGIN, pictureSize, pictureSize);
    
    String daysAsFirst = String.format("%,d", int(entry.framesAsFirst / FRAMES_PER_DAY));
    String consecutiveDaysAsFirst = String.format("%,d", int(entry.consecutiveFramesAsFirst / FRAMES_PER_DAY));
    String daysInTopTen = String.format("%,d", int(entry.framesInTopTen / FRAMES_PER_DAY));
    String consecutiveDaysInTopTen = String.format("%,d", int(entry.consecutiveFramesInTopTen / FRAMES_PER_DAY));
    
    float fontSize = pictureSize / 5;
    textFont(font, fontSize);
    textAlign(LEFT);
    
    fill(BACKGROUND_COLOR, 50);
    rect(0, 0, pictureSize + 3 * DATE_VMARGIN + textWidth("In the Top 10 for: " + daysInTopTen + " days (" + consecutiveDaysInTopTen + " consecutive days)"), MIN_Y);
    
    fill(entry.c);
    text(channel, pictureSize + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize);
    fill(255);
    text("Hours watched (last 3 days): ", pictureSize + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize * 2);
    text(" hours", pictureSize + 2 * DATE_VMARGIN + textWidth("Hours watched (last 3 days): " + String.format("%,d", int(hours))), DATE_VMARGIN + fontSize * 2);
    text("Most watched for: ", pictureSize + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize * 3);
    text(" days (", pictureSize + 2 * DATE_VMARGIN + textWidth("Most watched for: " + daysAsFirst), DATE_VMARGIN + fontSize * 3);
    text(" consecutive days)", pictureSize + 2 * DATE_VMARGIN + textWidth("Most watched for: " + daysAsFirst + " days (" + consecutiveDaysAsFirst), DATE_VMARGIN + fontSize * 3);
    text("In the Top 10 for: ", pictureSize + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize * 4);
    text(" days (", pictureSize + 2 * DATE_VMARGIN + textWidth("In the Top 10 for: " + daysInTopTen), DATE_VMARGIN + fontSize * 4);
    text(" consecutive days)", pictureSize + 2 * DATE_VMARGIN + textWidth("In the Top 10 for: " + daysInTopTen + " days (" + consecutiveDaysInTopTen), DATE_VMARGIN + fontSize * 4);
    text("Peak: ", pictureSize + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize * 5);
    text(" hours", pictureSize + textWidth("Peak: " + String.format("%,d", int(entry.peak))) + 2 * DATE_VMARGIN, DATE_VMARGIN + fontSize * 5);
    color hoursColor = entry.isGrowing ? color(50, 200, 50) : color(200, 50, 50);
    fill(hoursColor);
    text(String.format("%,d", int(hours)), pictureSize + 2 * DATE_VMARGIN + textWidth("Hours watched (last 3 days): "), DATE_VMARGIN + fontSize * 2);
    color peakColor = entry.isPeaking ? color(50, 200, 50) : color(250, 250, 210);
    fill(peakColor);
    text(String.format("%,d", int(entry.peak)), pictureSize + 2 * DATE_VMARGIN + textWidth("Peak: "), DATE_VMARGIN + fontSize * 5);
    fill(250, 250, 210);
    text(daysAsFirst, pictureSize + 2 * DATE_VMARGIN + textWidth("Most watched for: "), DATE_VMARGIN + fontSize * 3);
    text(consecutiveDaysAsFirst, pictureSize + 2 * DATE_VMARGIN + textWidth("Most watched for: " + daysAsFirst + " days ("), DATE_VMARGIN + fontSize * 3);
    text(daysInTopTen, pictureSize + 2 * DATE_VMARGIN + textWidth("In the Top 10 for: "), DATE_VMARGIN + fontSize * 4);
    text(consecutiveDaysInTopTen, pictureSize + 2 * DATE_VMARGIN + textWidth("In the Top 10 for: " + daysInTopTen + " days ("), DATE_VMARGIN + fontSize * 4);
  }
  
  void checkConsecutiveDaysInTopTenMilestone(Entry entry, int frame) {
    if (entry.consecutiveFramesInTopTen == 25 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 25 consecutive days."));
    } else if (entry.consecutiveFramesInTopTen == 50 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 50 consecutive days."));
    } else if (entry.consecutiveFramesInTopTen == 100 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 100 consecutive days!"));
    } else if (entry.consecutiveFramesInTopTen == 250 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 250 consecutive days!"));
    } else if (entry.consecutiveFramesInTopTen == 500 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 500 consecutive days!"));
    } 
  }
  
  void checkConsecutiveDaysAsFirstMilestone(Entry entry, int frame) {
    if (entry.consecutiveFramesAsFirst == 10 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 10 consecutive days."));
    } else if (entry.consecutiveFramesAsFirst == 25 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 25 consecutive days."));
    } else if (entry.consecutiveFramesAsFirst == 50 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 50 consecutive days!"));
    } else if (entry.consecutiveFramesAsFirst == 75 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 75 consecutive days!"));
    } else if (entry.consecutiveFramesAsFirst == 100 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 100 consecutive days!"));
    } 
  }
  
  void checkDaysAsFirstMilestone(Entry entry, int frame) {
    if (entry.framesAsFirst == 50 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 50 days."));
    } else if (entry.framesAsFirst == 100 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 100 days."));
    } else if (entry.framesAsFirst == 250 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 250 days!"));
    } else if (entry.framesAsFirst == 500 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 500 days!"));
    } else if (entry.framesAsFirst == 1000 * FRAMES_PER_DAY) {
        milestones.addLast(new Milestone(entry, frame, "has been the most watched channel for 1000 days!"));
    }
  }
  
  void checkDaysInTopTenMilestone(Entry entry, int frame) {
    if (entry.framesInTopTen == 100 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 100 days."));
    } else if (entry.framesInTopTen == 250 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 250 days."));
    } else if (entry.framesInTopTen == 500 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 500 days!"));
    } else if (entry.framesInTopTen == 1000 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 1000 days!"));
    } else if (entry.framesInTopTen == 2000 * FRAMES_PER_DAY) {
      milestones.addLast(new Milestone(entry, frame, "has been in the Top 10 for 2000 days!"));
    } 
  }
  
  void drawMilestones(int frame) {
    fill(255);
    textFont(font, MILESTONE_TITLE_SIZE);
    textAlign(CENTER);
    text("Log", MAX_X + (width - MAX_X) / 2, MIN_Y + MILESTONE_VMARGIN + MILESTONE_TITLE_SIZE);
    rect(MAX_X + (width - MAX_X) / 2 - textWidth("Log") / 2, MILESTONE_SPACING + MIN_Y + MILESTONE_VMARGIN + MILESTONE_TITLE_SIZE, textWidth("Log"), MILESTONE_SPACING);
    
    // Remove expired milestones.
    if (milestones.size() > 0) {
      boolean isValid = false;
      while (!isValid) {
        Milestone m = milestones.peek();
        isValid = milestones.size() == 0 || (frame - m.frame < MILESTONE_DURATION && !m.isExpired);
        if (!isValid) {
          milestones.removeFirst();
        }
      }
    }
    
    textAlign(LEFT);
    textFont(alternateFont, MILESTONE_SIZE);
    float x = MAX_X + MILESTONE_HMARGIN;
    Iterator<Milestone> it = milestones.iterator();
    int counter = 0;
    while (it.hasNext()) {
      ++counter;
      Milestone milestone = it.next();
      float y = 3 * MILESTONE_SPACING + MIN_Y + MILESTONE_VMARGIN + MILESTONE_TITLE_SIZE + counter * (MILESTONE_SPACING + MILESTONE_SIZE);
      Entry entry = milestone.entry;
      
      float opacity = 255;
      float offset = 0;
      if (frame - milestone.frame < MILESTONE_FADE_DURATION) {
        opacity = (frame - milestone.frame) / MILESTONE_FADE_DURATION * 255;
        int[] range = {0, 1};
        offset = MILESTONE_FADE_OFFSET - util.WAIndex(range, (frame - milestone.frame) / MILESTONE_FADE_DURATION, .8) * MILESTONE_FADE_OFFSET;
      } else if (frame - milestone.frame > MILESTONE_DURATION - MILESTONE_FADE_DURATION) {
        ++milestone.fadingFrame;
      }
      
      if (counter == milestones.size() - MAX_MILESTONES && milestone.fadingFrame == 0) {
        ++milestone.fadingFrame;
      }
      
      if (milestone.fadingFrame > 0) {
        if (milestone.fadingFrame >= MILESTONE_FADE_DURATION) {
          milestone.isExpired = true;
          continue;
        }
        opacity = 255 - milestone.fadingFrame / MILESTONE_FADE_DURATION * 255;
        int[] range = {0, 1};
        offset = util.WAIndex(range, milestone.fadingFrame / MILESTONE_FADE_DURATION, .8) * MILESTONE_FADE_OFFSET;
        ++milestone.fadingFrame;
    }
      tint(255, opacity);
      image(entry.photo, x + offset, y - MILESTONE_SIZE, MILESTONE_SIZE, MILESTONE_SIZE);
      tint(255);
      fill(entry.c, opacity);
      text(entry.name, offset + x + MILESTONE_SIZE + 2 * MILESTONE_SPACING, y);
      fill(255, opacity);
      text(" " + milestone.message, offset + x + MILESTONE_SIZE + 2 * MILESTONE_SPACING + textWidth(entry.name), y);
    }
  }
  
  void drawEventLog(int frame) {
    fill(255);
    textFont(font, MILESTONE_TITLE_SIZE);
    textAlign(CENTER);
    text("Events", MAX_X + (width - MAX_X) / 2, MIN_Y + EVENT_LOG_VMARGIN + MILESTONE_TITLE_SIZE);
    rect(MAX_X + (width - MAX_X) / 2 - textWidth("Events") / 2, MILESTONE_SPACING + MIN_Y + EVENT_LOG_VMARGIN + MILESTONE_TITLE_SIZE, textWidth("Events"), MILESTONE_SPACING);

    textAlign(LEFT);
    float x = MAX_X + MILESTONE_HMARGIN;
    // Most recent event: the third one after.
    Iterator<Event> it = eventsOnDisplay.iterator();
    Iterator<Event> nextIt = eventsOnDisplay.iterator();
    int counter = 0;
    while (counter < MAX_EVENT_LOG_SIZE - 1 && nextIt.hasNext()) {
      nextIt.next();
      ++counter;
    }
    Event recentEvent = eventsOnDisplay.size() > MAX_EVENT_LOG_SIZE ? nextIt.next() : eventsOnDisplay.peekLast();
    int index = 0;
    
    while (it.hasNext()) {
      Event targetEvent = it.next();

      float eventHeight = EVENT_LOG_SPACING + EVENT_LOG_PIC_SIZE + EVENT_LOG_TITLE_MARGIN;
      float y = 3 * EVENT_LOG_SPACING + MIN_Y + EVENT_LOG_VMARGIN + MILESTONE_TITLE_SIZE + (eventsOnDisplay.size() - index - 1) * eventHeight;
      
      float opacity = 255;
      float xOffset = 0;
      if (frame - recentEvent.savedFrame < EVENT_PIC_FADE_DURATION) {
        y -= eventHeight;
        int[] yRange = {0, int(eventHeight)};
        float progress = min(1, (frame - recentEvent.savedFrame) / EVENT_PIC_FADE_DURATION);
        y += util.WAIndex(yRange, progress, .8);
        if (index >= eventsOnDisplay.size() - 1) {
          opacity = (frame - recentEvent.savedFrame) / EVENT_PIC_FADE_DURATION * 255;
          int[] xRange = {0, 1};
          xOffset = MILESTONE_FADE_OFFSET - util.WAIndex(xRange, (frame - recentEvent.savedFrame) / EVENT_PIC_FADE_DURATION, 1) * MILESTONE_FADE_OFFSET;
        } else if (index == 0 && eventsOnDisplay.size() == MAX_EVENT_LOG_SIZE) {
          int[] xRange = {0, 1};
          xOffset = util.WAIndex(xRange, (frame - recentEvent.savedFrame) / EVENT_PIC_FADE_DURATION, 1) * MILESTONE_FADE_OFFSET;
          opacity = 255 - (frame - recentEvent.savedFrame) / EVENT_PIC_FADE_DURATION * 255;
        }
      } else if (index == 0 && eventsOnDisplay.size() >= MAX_EVENT_LOG_SIZE) {
        it.remove();
        continue;
      }
      
      tint(255, opacity);
      image(targetEvent.photo, x + xOffset, y, EVENT_LOG_PIC_SIZE, EVENT_LOG_PIC_SIZE);
      image(entries.get(targetEvent.channel).photo, xOffset + x + EVENT_LOG_PIC_SIZE + 2 * EVENT_LOG_SPACING, y + EVENT_LOG_SPACING, EVENT_LOG_TITLE_SIZE, EVENT_LOG_TITLE_SIZE);
      tint(255);
      
      fill(255, opacity);
      textFont(font, EVENT_LOG_TITLE_SIZE);
      text(targetEvent.eventDate, xOffset + x + EVENT_LOG_PIC_SIZE + 4 * EVENT_LOG_SPACING + EVENT_LOG_TITLE_SIZE, y + EVENT_LOG_TITLE_SIZE + EVENT_LOG_SPACING);
      textFont(alternateFont, EVENT_LOG_DESCRIPTION_SIZE);
      text(targetEvent.l1, xOffset + x + EVENT_LOG_PIC_SIZE + 2 * EVENT_LOG_SPACING, y + EVENT_LOG_TITLE_SIZE + 2 * EVENT_LOG_SPACING + EVENT_LOG_DESCRIPTION_SIZE);
      if (!targetEvent.l2.equals("")) text(targetEvent.l2, xOffset + x + EVENT_LOG_PIC_SIZE + 2 * EVENT_LOG_SPACING, y + EVENT_LOG_TITLE_SIZE + 3 * EVENT_LOG_SPACING + 2 * EVENT_LOG_DESCRIPTION_SIZE);
      if (!targetEvent.l3.equals("")) text(targetEvent.l3, xOffset + x + EVENT_LOG_PIC_SIZE + 2 * EVENT_LOG_SPACING, y + EVENT_LOG_TITLE_SIZE + 4 * EVENT_LOG_SPACING + 3 * EVENT_LOG_DESCRIPTION_SIZE);
      fill(255, opacity);
      
      if (nextIt.hasNext()) {recentEvent = nextIt.next();}
      
      ++index;
    }
    
  }
  
  void updateRecords(Entry e) {    
    if (records.size() == 0) {
      recordHolders.add(e.name);
      records.add(e);
    } else if (recordHolders.contains(e.name)) {
      bubbleSortRecords();
    } else if (records.size() < N_RECORDS) {
      records.add(e);
      recordHolders.add(e.name);
      bubbleSortRecords();
    } else if (e.peak > records.get(0).peak) {
      records.add(e);
      recordHolders.add(e.name);
      bubbleSortRecords();
      Entry removedEntry = records.remove(0);
      recordHolders.remove(removedEntry.name);
    }
  }
  
  void bubbleSortRecords() {
    boolean isSorted = false;
    while (!isSorted) {
      isSorted = true;
      for (int i = 0; i < records.size() - 1; ++i) {
        Entry e1 = records.get(i);
        Entry e2 = records.get(i + 1);
        // Swap if e2 > e1.
        if (e2.peak < e1.peak) {
          isSorted = false;
          records.set(i, entries.get(e2.name));
          records.set(i + 1, entries.get(e1.name));
        }
      }
    }
  }

  void drawRecords(int frame) {
    float minScale = preprocess.mins[frame];
    float maxScale = preprocess.maxes[frame];
    textFont(font, RECORD_SIZE);
    textAlign(LEFT);
    noStroke();
    
    int nRecords = records.size() < 10 ? records.size() : frame < FRAMES_RECORDS_DISPLAY_1 ? 10 : frame < FRAMES_RECORDS_DISPLAY_2 ? 20 : records.size();
    float[] recordCoords = new float[nRecords];
    
    for (int i = 0; i < records.size(); ++i) {
      Entry e = records.get(records.size() - i - 1);
      float y = util.valToY(e.peak, MIN_Y, MAX_Y, minScale, maxScale);
      if (i >= 10 && frame < FRAMES_RECORDS_DISPLAY_1) continue;
      if (i >= 20 && frame < FRAMES_RECORDS_DISPLAY_2) continue;
      recordCoords[i] = y;
      float opacity = e.isPeaking ? 255 : 100;
      if (i >= 10 && frame < FRAMES_RECORDS_DISPLAY_1 + RECORDS_FADE_DURATION) opacity = 100 * (frame - FRAMES_RECORDS_DISPLAY_1) / RECORDS_FADE_DURATION;
      if (i >= 20 && frame < FRAMES_RECORDS_DISPLAY_2 + RECORDS_FADE_DURATION) opacity = 100 * (frame - FRAMES_RECORDS_DISPLAY_2) / RECORDS_FADE_DURATION;
      fill(e.c, opacity);
      rect(MIN_X, y, MAX_X - MIN_X, 1);
    }
    
    util.fixOverlaps(recordCoords, RECORD_SIZE);
    
    for (int i = 0; i < records.size(); ++i) {
      if (i >= 10 && frame < FRAMES_RECORDS_DISPLAY_1) continue;
      if (i >= 20 && frame < FRAMES_RECORDS_DISPLAY_2) continue;
      Entry e = records.get(records.size() - i - 1);
      float opacity = e.isPeaking ? 255 : 100;
      if (i >= 10 && frame < FRAMES_RECORDS_DISPLAY_1 + RECORDS_FADE_DURATION) opacity = 100 * (frame - FRAMES_RECORDS_DISPLAY_1) / RECORDS_FADE_DURATION;
      if (i >= 20 && frame < FRAMES_RECORDS_DISPLAY_2 + RECORDS_FADE_DURATION) opacity = 100 * (frame - FRAMES_RECORDS_DISPLAY_2) / RECORDS_FADE_DURATION;
      float y = recordCoords[i];
      fill(e.c, opacity);
      image(e.photo, MAX_X, y - RECORD_SIZE / 2, RECORD_SIZE, RECORD_SIZE);
      text(rankNames[i], MAX_X + RECORD_SIZE + RECORD_MARGIN, y + RECORD_SIZE / 2);
    }
  }
  
  void triggerEvent(int frame) {
    if (eventCounter >= preprocess.events.length) {
      return;
    }
    
    Event targetEvent = preprocess.events[eventCounter];
    
    if (frame >= targetEvent.frame) {
      Entry entry = entries.get(targetEvent.channel);
      if (!entry.isGrowing) {
        targetEvent.savedFrame = frame - 1;
        targetEvent.savedVal = entry.lastValue;
        targetEvent.trigger();
        eventsOnDisplay.addLast(targetEvent);
        ++eventCounter;
        eventsToDraw.add(targetEvent);
      }
     
    }
  }
  
  void drawEvents(int frame) {
    noStroke();
    Iterator<Event> it = eventsToDraw.iterator();
    float maxScale = preprocess.maxes[frame];
    float minScale = preprocess.mins[frame];
    while (it.hasNext()) {
      Event event = it.next();
      Entry entry = entries.get(event.channel);

      float x = frame > CIRCLE_POS_X - MIN_X ? CIRCLE_POS_X - (frame - event.savedFrame) : MIN_X + event.savedFrame;
      float y = util.valToY(event.savedVal, MIN_Y, MAX_Y, minScale, maxScale);
      fill(entry.c);
      
      float x1 = x;
      float x2 = x - EVENT_BAR_WIDTH / 2;
      float x3 = x + EVENT_BAR_WIDTH / 2;
      float y1 = y;
      float y2 = y - EVENT_BAR_HEIGHT - 1;
      float y3 = y2;
      
      // Draw event on graph.
      if (frame - event.savedFrame < EVENT_ANIM_DURATION) {
        float progress = (frame - event.savedFrame) / EVENT_ANIM_DURATION;
        int[] range = {0, int(EVENT_BAR_HEIGHT + EVENT_PIC_SIZE + 2 * EVENT_PIC_PADDING)};
        float elHeight = util.WAIndex(range, progress, .8);
        
        if (elHeight <= EVENT_BAR_HEIGHT) {
          triangle(x1, y1, x2, y - elHeight, x3, y - elHeight);
          // rect(x - EVENT_BAR_WIDTH / 2, y - elHeight, EVENT_BAR_WIDTH, elHeight);
        } else {
          triangle(x1, y1, x2, y2, x3, y3);
          rect(x - EVENT_PIC_SIZE / 2 - EVENT_PIC_PADDING, y - elHeight, EVENT_PIC_SIZE + 2 * EVENT_PIC_PADDING, elHeight - EVENT_BAR_HEIGHT);
        }
      } else {
        triangle(x1, y1, x2, y2, x3, y3);
        rect(x - EVENT_PIC_PADDING - EVENT_PIC_SIZE / 2, y - EVENT_BAR_HEIGHT - EVENT_PIC_SIZE - EVENT_PIC_PADDING * 2, EVENT_PIC_SIZE + 2 * EVENT_PIC_PADDING, EVENT_PIC_SIZE + 2 * EVENT_PIC_PADDING);
        if (frame - event.savedFrame - EVENT_ANIM_DURATION < EVENT_PIC_FADE_DURATION) {
          tint(255, 255 * ((frame - event.savedFrame - EVENT_ANIM_DURATION) / EVENT_PIC_FADE_DURATION));
        } else {
          tint(255, 255);
        }
        image(event.photo, x - EVENT_PIC_SIZE / 2, y - EVENT_BAR_HEIGHT - EVENT_PIC_SIZE - EVENT_PIC_PADDING, EVENT_PIC_SIZE, EVENT_PIC_SIZE);
        tint(255, 255);
      } 
      
      // Remove if no longer in frame.
      if (frame > CIRCLE_POS_X - MIN_X && CIRCLE_POS_X - frame + event.savedFrame + EVENT_PIC_SIZE < MIN_X) {
        it.remove();
      }
    }
  }
  
}
