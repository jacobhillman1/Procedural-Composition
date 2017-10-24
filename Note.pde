class Note {
  String name;
  Oscil tone;
  float hz, freq;
  
  Note(String name, float hz, float freq) {
    this.name = name;
    this.hz = hz;
    this.freq = freq;
    tone = new Oscil(hz, freq, Waves.SINE);
  }
  
  void play() {
    out.playNote(0.0, 0.75, "G3");
  }
  
}