class Milestone {
  Entry entry;
  int frame;
  String message;
  
  boolean isExpired = false;
  int fadingFrame = 0;
  
  Milestone(Entry entry, int frame, String message) {
    this.entry = entry;
    this.frame = frame;
    this.message = message;
  }
}
