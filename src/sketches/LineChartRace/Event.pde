class Event {
  String eventDate;
  int frame;
  String description;
  String channel;
  
  boolean isTriggered;
  float savedVal;
  float savedFrame;
  
  PImage photo;
  
  String l1 = "";
  String l2 = "";
  String l3 = "";
  
  Event(String eventDate, int frame, String description, String channel, String photoName) {
    this.eventDate = eventDate;
    this.frame = frame;
    this.description = description;
    this.channel = channel;
    
    // String[] lines = description.split("@");
    //l1 = lines[0];
    //if (lines.length >= 2) l2 = lines[1];
    //if (lines.length >= 3) l3 = lines[2];
    
    isTriggered = false;
    
    String photoFile = photoName + ".png";
    photo = loadImage(photoFile);
    if (photo == null) {
      photo = loadImage(channel + ".png");
    }
    
  }
  
  void trigger() {
    isTriggered = true;
  }
}
