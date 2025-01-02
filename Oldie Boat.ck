eBass bass=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac;
SenDrummer perc3=>dac;
Marimba marimba=>dac;
HarmonySynth FH=>dac;
RonModes mode=>dac;


0.21=>float Beat;
[8457,0,0,5363,0,0,
7457,7457,0,0,6363,0,
6165,2167,0,0,8165,0,
4457,2363,0,0,8363,0]@=>int Notes[];
[512,0,611,512,0,611,
512,0,611,512,0,611]@=>int NotesD[];
[399,0,499,0,599,0,
399,0,499,0,599,0]@=>int NotesD2[];
[509,0,510,509,610,0,509,0,510,509,610,0]@=>int NotesD3[];
[660,0,657,963,963,0,763,760,0,763,762,0]@=>int NotesBordon[];//Inspirado en Bordon Canoita Santos (2022)

[960,0,960,0,960,0,268,467,0,0,0,0]@=>int NotesB[];



synch s;
s.cycle(12,Beat);
s.hush();

spork~bass.play(Beat,6,2,NotesB);

spork~perc3.play(Beat,6,2,NotesD3);
spork~marimba.play(Beat,10,2,NotesBordon);

spork~perc2.play(Beat,6,2,NotesD2);

spork~mode.play(Beat,6,2,Notes);
spork ~perc.play(Beat,6,2,NotesD);
 //MidiInMar MD;
MidiInDist MD2;