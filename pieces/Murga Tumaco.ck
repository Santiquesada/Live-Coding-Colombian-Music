//Pieza inspirada el el ritmo de Murga tuumaqueña
eBass bass;
genDrummer perc;
genDrummer perc2;
genDrummer perc3;
Marimba marimba;
Marimba marimba2;
HarmonySynth FH;
RonModes mode;
Guitar guit;
1=>int kind;

0.17=>float Beat;
[3459,0,6459,0,0,0,0,0,
0,7459,6459,0,0,0,0,0]@=>int Notes[];
[0]@=>int NotesG[];
[509,0,509,0,509,509,808,810,0,509,609,508,509,509,908,509]@=>int NotesD[];
[899,0]@=>int NotesD2[];
[0,513,511,811]@=>int NotesD3[];
[769,0,0,769,0,0,869,0,569,0,467,0,564,0,867,0]@=>int NotesMarimba[];
[757,0,0,757,0,0,857,0,557,0,455,0,552,0,855,0]@=>int NotesMarimba2[];
[0]@=>int NotesFH[];

[660,0,764,769,0,664,667,0,
560,0,564,567,0,0,862,0]@=>int NotesB[];

// Lets make the B
[0]@=>int Notes2[];

[0]@=>int NotesB2[];
[0]@=>int NotesFH2[];

synch s;
s.cycle(8,Beat);
s.hush();

spork~bass.play(Beat,6,kind,NotesB);
spork~guit.play(Beat,6,kind,NotesG);
spork~perc3.play(Beat,6,kind,NotesD3);
spork~FH.play(Beat,10,kind,NotesFH);
spork~marimba.play(Beat,10,kind,NotesMarimba);
spork~marimba2.play(Beat,10,kind,NotesMarimba2);

spork~perc2.play(Beat,6,kind,NotesD2);

spork~mode.play(Beat,6,kind,Notes);
perc.play(Beat,6,kind,NotesD);

