RonModes mode=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac; 
Marimba bass=>dac;
HarmonySynth FH=>dac;
[3056,8362,0,7362,0,5362,0,9050,
2362,0,8362,0,9049,0,4362,0,
3056,8159,0,7159,0,5159,0,9050,
2159,0,8159,0,9049,0,4159,0]@=>int Notes[];
[902,0,902,0,400,0,803,0]@=>int NotesD[];
[908,0,409,908,509,0,908,709]@=>int NotesD2[];

[559,0,0,859,0,0,671,0,
0,0,0,0,0,0,0,0,
556,0,0,856,0,0,668,0,
0,0,0,0,0,0,0,0,]@=>int NotesB[];
0.16=>float Beat;
synch s;
s.cycle(16,Beat);
s.hush();
spork~ bass.play(Beat,6,1,NotesB);
spork~perc.play(Beat,0,1,NotesD);
spork~ perc2.play(Beat,0,1,NotesD2);

spork~mode.play(Beat,0,1,Notes);
MidiInDist MD;