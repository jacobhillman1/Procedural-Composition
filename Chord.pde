class Chord {
  int rootIndex;
  String quality;
  Chord[] voiceLeading;
  boolean[] noteStack; // Each index corresponds directly with a note held in the index allNotes (convert to tuple?)
  String[] allNotes;

  Chord(int rootIndex, String quality) {
    this.rootIndex = rootIndex;
    this.quality = quality;
    noteStack = new boolean[11];
    clearNotes();
    allNotes = new String[]{"C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4"};
  }
  
  void addVoiceLeading(Chord[] whereToGo) {
    voiceLeading = new Chord[whereToGo.length];
    for(int i = 0; i < whereToGo.length; i++) {
      voiceLeading[i] = whereToGo[i];
    }
  }
  
  private void clearNotes() {
    for (int i = 0; i < noteStack.length; i++) {
      noteStack[i] = false;
    }  
  }
  
  void playRoot() {
    out.playNote(0, .5, allNotes[0]);
  }
  
  void playMajorChord() {
    out.playNote(0, 1, allNotes[rootIndex]);
    out.playNote(0, 1, allNotes[rootIndex + 4]);
    out.playNote(0, 1, allNotes[rootIndex + 7]);
  }
  
  String getRoot() {
    return allNotes[rootIndex];
  }
  
  void printRoot() {
    println(allNotes[rootIndex]);
  }
  
  void printVoiceLeading() {
    for(int i = 0; i < voiceLeading.length; i++)
      println(voiceLeading[i].getRoot());
  }
  
  Chord nextChord() {
    int randomNum = ThreadLocalRandom.current().nextInt(0, voiceLeading.length);
    return voiceLeading[randomNum];
  }
  
  void play(float time) {
    //for (int i = 0; i < 12; i++) {
    //  if(noteStack[i]) {
        out.playNote(time / 2, .5, allNotes[rootIndex]);
    //  }
    //}
  }
}