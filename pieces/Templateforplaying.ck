eBass bass;
genDrummer perc;
genDrummer perc2;
genDrummer perc3;
Marimba marimba;
HarmonySynth FH;
RonModes mode;
Guitar guit;
1=>int kind;

0.21=>float Beat;
[0]@=>int Notes[];
[0]@=>int NotesG[];
[0]@=>int NotesD[];
[0]@=>int NotesD2[];
[0]@=>int NotesD3[];
[0]@=>int NotesFH[];

[0]@=>int NotesB[];

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

spork~perc2.play(Beat,6,kind,NotesD2);

spork~mode.play(Beat,6,kind,Notes);
perc.play(Beat,6,kind,NotesD);

