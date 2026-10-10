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
/*[0,769,0,267,262,467,0,769,0,0,0,0,
0,769,0,267,362,263,0,0,0,0,0,0,
0,469,0,767,762,767,0,769,0,0,0,0,
0,469,0,767,762,763,0,0,0,0,0,0,
0,569,0,272,769,772,0,774,0,0,0,0,
0,769,0,272,769,770,0,0,0,0,0,0,
0,769,0,272,769,772,0,774,0,0,0,0,
0,769,0,272,769,770,0,0,0,0,0,0]@=>int NotesG[];*/
[512,0,611]@=>int NotesD[];
[399,0,499,0,599,0]@=>int NotesD2[];
[509,0,510,509,610,0]@=>int NotesD3[];
[660,0,657,963,963,0,763,760,0,763,762,0]@=>int NotesFH[];

[960,0,960,0,960,0,268,467,0,0,0,0]@=>int NotesB[];

// Lets make the B
[5753,0,0,4748,0,3751,0,5750,0,0,4753,0,
0,3753,0,4748,0,4751,0,5750,0,0,3753,0]@=>int Notes2[];

[460,0,0,460,0,460,0,660,0,0,760,0,
0,460,0,460,0,460,0,460,0,0,760,0]@=>int NotesB2[];
[460,0,0,460,0,460,0,660,0,0,760,0,
0,460,0,460,0,460,0,460,0,0,760,0]@=>int NotesFH2[];

synch s;
s.cycle(12,Beat);
s.hush();

spork~bass.play(Beat,6,2,NotesB);
//spork~marimba.play(Beat,6,2,NotesG);
spork~perc3.play(Beat,6,2,NotesD3);
spork~marimba.play(Beat,10,2,NotesFH);

spork~perc2.play(Beat,6,2,NotesD2);

spork~mode.play(Beat,6,2,Notes);
spork ~perc.play(Beat,6,2,NotesD);
 MidiInMar MD;
