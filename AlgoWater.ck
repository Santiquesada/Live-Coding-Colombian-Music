RonModes mode=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac;
SenDrummer perc3=>dac;
HarmonySynth FH=>dac;
Bass bass=> dac;
Marimba marimba=>dac;
[9555,0,0,8555,6555,0,
8153,0,0,3153,0,0]@=>int Notes[];
[912,0,911,912,0,911,
912,0,911,912,0,911]@=>int NotesD[];
[910,0,508,710,608,0,
509,608,0,509,608,0]@=>int NotesD2[];
[1202,0,1203,1202,0,1202,
1202,0,1202,1202,2303,1202]@=>int NotesD3[];
[867,855,0,0,0,0,
-1,0,967,-1,0,956,0,0,855]@=>int NotesBass[];
[960,0,563,867,762,0,
960,0,563,868,763,767]@=>int NotesBordon[];//Inspirado en Bordon Santos(2022)
[867,868,0,0,974,0,
865,867,0,0,972,0]@=>int NotesFH[];

0.20=>float Beat;
synch s;
s.cycle(12,Beat);
s.hush();
spork~ FH.play(Beat,8,2,NotesFH);

spork~ bass.play(Beat,8,2,NotesBass);
spork~ marimba.play(Beat,8,2,NotesBordon);
spork~perc.play(Beat,8,2,NotesD);
spork~ perc2.play(Beat,8,2,NotesD2);
spork~ perc3.play(Beat,8,2,NotesD3);

spork~ mode.play(Beat,8,2,Notes);
//MidiInMar MD;
MidiInDist MD2;