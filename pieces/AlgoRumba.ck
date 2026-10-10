//AlgoRumba
Marimba marimba=>dac;
RonModes mode=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac;
SenDrummer drum=>dac;
eBass bass=>dac;
HarmonySynth FH=>dac;
HarmonySynth FH2=>dac;
0.15=>float Beat;
[7462,0,0,1462,0,0,4462,0,
0,2462,0,4462,0,0,3462,0]@=>int Notes[];
[3160,0,0,0,0,0,0,0]@=>int Notes2[];
[458,562,0,465,0,862,758,0,
363,0,467,0,463,0,0,0,
660,563,0,667,0,563,560,0,
768,0,0,0,767,0,0,0]@=>int NotesG[];
[108,0,909,908,0,0,910,0]@=>int NotesD[];
[0,0,917,0,109,0,909,0]@=>int NotesD2[];
[700,902,903,802,700,902,903,802]@=>int NotesDrum[];

[174,174,0,174,0,179,177,180]@=>int NotesFH[];

[962,962,0,962,0,0,0,0]@=>int NotesMarimba[];
[168,168,0,168,0,174,174,174]@=>int NotesFH2[];
[660,160,0,160,0,0,0,0]@=>int NotesB2[];
[563,0,0,0,563,0,0,0,560,0,0,0,560,0,0,0]@=>int NotesB[];
[968,868,0,568,0,0,865,0,963,0,0,463,0,0,163,0,
965,0,0,968,0,0,767,0,0,0,0,0,0,0,0,0,
468,968,0,168,0,0,565,0,863,0,0,763,0,0,362,0,
763,0,0,362,0,0,560,0,0,0,0,0,0,0,0,0]@=>int NotesMel[];
synch s;
s.cycle(16,Beat);
s.hush();
spork ~drum.play(Beat,30,1,NotesDrum);
spork ~perc.play(Beat,10,1,NotesD2);
spork ~perc2.play(Beat,10,1,NotesD);
spork ~bass.play(Beat,10,1,NotesB);
spork ~FH.play(Beat,10,1,NotesFH);

spork ~FH2.play(Beat,10,1,NotesFH2);
//spork ~marimba.play(Beat,36,1,NotesMel);

//spork ~mode.play(Beat,10,1,Notes);
MidiInDist MD;