// Jacob Hillman
// Procedural Composition

import java.util.concurrent.ThreadLocalRandom;
import ddf.minim.*;
import ddf.minim.ugens.*;

// Use the Minim library for audio generation and output
Minim minim;
AudioOutput out;
Chord[] chords = new Chord[7];

void setup() {
  noLoop();
  
  minim = new Minim(this);
  out = minim.getLineOut();
  out.setNoteOffset( 0.0 );
  
  // set up each chord, in C Major for now
  initializeChordsForCMajorScale(chords);
  addVoiceLeading(chords);
  
  //chords[0].playMajorChord();

}

void draw() {
  
  out.pauseNotes();
  boolean firstChord = true;
  Chord currentChord = chords[0];
  currentChord.printRoot();
  //currentChord.play();
  firstChord = false;

  for(float i = 0.0; i < 100; i++) {
    currentChord = currentChord.nextChord();
    currentChord.printRoot();
    out.pauseNotes();

    currentChord.play(i);
    //for(int j = 0; j < 4; j++) {
    //  out.playNote(i + (0.25 * j), .25, "C2");
    //}
  }
  out.resumeNotes();
  
}

void initializeChordsForCMajorScale(Chord[] chords) {
  chords[0] = new Chord(0, "major");
  chords[1] = new Chord(2, "minor");
  chords[2] = new Chord(4, "minor");
  chords[3] = new Chord(5, "major");
  chords[4] = new Chord(7, "major");
  chords[5] = new Chord(9, "minor");
  chords[6] = new Chord(11, "half-diminished");
}

// Inefficiently add the voice leading tendencies of each chord (in major)
void addVoiceLeading(Chord[] chords) {
  // The I chord can go anywhere
  chords[0].addVoiceLeading(new Chord[]{chords[1], chords[2], chords[3], chords[4], chords[5], chords[6]});
  
  // The ii chord can go to V or vii
  chords[1].addVoiceLeading(new Chord[]{chords[4], chords[6]});
  
  // The iii chord can go to IV or vi
  chords[2].addVoiceLeading(new Chord[]{chords[3], chords[5]});
  
  // The IV chord can go to I, ii, V, or vii
  chords[3].addVoiceLeading(new Chord[]{chords[0], chords[1], chords[4], chords[6]});
  
  // The V chord can go to I or vi
  chords[4].addVoiceLeading(new Chord[]{chords[0], chords[5]});
  
  // The vi chord can go to ii IV or V
  chords[5].addVoiceLeading(new Chord[]{chords[1], chords[3], chords[4]});
  
  //The vii chord can go to i or V
  chords[6].addVoiceLeading(new Chord[]{chords[0], chords[4]});
}