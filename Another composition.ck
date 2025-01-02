genDrummer perc;
genDrummer perc2;
RonModes mode;
Bass bass;
Guitar guit;
HarmonySynth FH;
HarmonySynth FH2;
0.19=>float Beat;
synch s;
s.cycle(16,Beat);
[2560,0,0,0,
1560,0,1160,1560,
0,1560,1560,0,
1560,0,1160,0]@=>int Notes[];
[860,0,0,0,0,0,0,0,
860,0,0,963,0,0,0,0]@=>int NotesB[];
[360,860,0,760,563,763,0,563,
863,763,0,963,360,0,767,865,
967,0,767,865,967,0,767,865,
967,765,0,763,0,0,0,0
]@=>int NotesFH[];

[860,860,0,760,863,763,0,963,
863,763,0,963,960,0,0,0]@=>int NotesG[];
[511,-1,0,112,-1,112,112,-1,0,312,312,012,-1,112,-1,511,611,-1]@=>int NotesD[];
[708,0,509,509,0,509,509,-1,208,408,-1,
708,0,509,509,0,509,509,809]@=>int NotesD2[];
s.hush();

spork ~FH.play(Beat,10,1,NotesFH);
spork ~guit.play(Beat,10,1,NotesB);
spork ~bass.play(Beat,10,1,NotesG);
spork ~mode.play(Beat,10,1,Notes);
spork ~perc.play(Beat,10,1,NotesD2);
perc2.play(Beat,10,1,NotesD);