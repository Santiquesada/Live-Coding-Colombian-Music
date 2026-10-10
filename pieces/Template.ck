Marimba bass=>dac;
SenDrummer instr=>dac;
SenDrummer instr2=>dac;

RonModes mode=>dac;
0.20=>float Beat;
[654,0,0,0,0,0]@=>int NotesB[];
[3452,0,3452,0,5459,0]@=>int Notes2[];
[912,0,911]@=>int NotesD[];

[999,0,999]@=>int NotesD2[];
synch s;
s.cycle(6,Beat);
s.hush();
 spork ~bass.play(Beat,15,2,NotesB);

spork ~instr2.play(Beat,15,2,NotesD2);
spork ~mode.play(Beat,15,2,Notes2);
instr.play(Beat,15,2,NotesD);