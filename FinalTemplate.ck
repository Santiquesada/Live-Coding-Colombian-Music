RonModes mode=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac;
SenDrummer perc3=>dac;
HarmonySynth FH=>dac;
Bass bass=> dac;
Marimba marimba=>dac;
[0]@=>int Notes[];
[900,0,902,803]@=>int NotesD[];
[0]@=>int NotesD2[];
[0]@=>int NotesD3[];
[960,0,0,0]@=>int NotesBass[];
[0]@=>int NotesBordon[];
[0]@=>int NotesFH[];

0.20=>float Beat;
synch s;
s.cycle(4,Beat);
s.hush();
/*spork~ FH.play(Beat,16,2,NotesFH);

spork~ bass.play(Beat,16,2,NotesBass);
spork~ marimba.play(Beat,6,2,NotesBordon);
spork~perc.play(Beat,0,2,NotesD);
spork~ perc2.play(Beat,0,2,NotesD2);
spork~ perc3.play(Beat,0,2,NotesD3);*/

spork~ bass.play(Beat,16,2,NotesBass);
spork~ perc.play(Beat,0,1,NotesD);
MidiInMar MD;
MidiInDist MD2;