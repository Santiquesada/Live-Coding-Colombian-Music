//Fourth composition
//6/8 rhythm
RonModes mode=>dac;
Bass bass=>dac;
Guitar guit=>dac;
HarmonySynth FH=>dac;
HarmonySynth FH2=>dac;
Marimba marimba=>dac;
SenDrummer perc=>dac;
SenDrummer perc2=>dac;
SenDrummer perc3=>dac;
0.22=>float Beat;
[6260,0,6260,3260,3260,0,
3260,3260,0,0,0,0,
1363,0,2363,3363,3363,0,
3363,3363,0,0,0,0]@=>int Notes[];
[0,862,0,860,862,0,
0,862,0,860,862,0,
0,863,0,860,858,0,
0,863,0,860,858,0,
]@=>int NotesG[]; //in FH
[0,462,0,460,462,0,
0,462,0,460,462,0,
0,463,0,460,458,0,
0,463,0,460,458,0,
]@=>int Notesmar[]; //in FH
[0,972,0,870,865,870
,0,972,0,970,965,870,
0,869,0,869,767,969,
0,869,0,769,767,0,
872,872,0,970,965,970
,0,872,0,970,965,870,
0,972,0,970,769,0,
465,0,0,0,470,0]@=>int NotesGuit[];

//[72,72,0]@=>int NotesG[];
[699,0,699,699,0,999,699,0,999,699,0,999]@=>int NotesD3[];
[509,0,509,609,910,0,699,699,0,699,999,0]@=>int NotesD[];
[712,0,711,712,0,711,712,0,711,712,0,711]@=>int NotesD2[];
[660,0,660,0,260,0,257,0,857,0,557,0]@=>int NotesB[];

synch s;
s.cycle(12,Beat);
s.hush();


spork~perc.play(Beat,10,2,NotesD2);
spork~perc2.play(Beat,10,2,NotesD);
spork~perc3.play(Beat,10,2,NotesD3);
spork~marimba.play(Beat,10,2,Notesmar);
//spork~marimba.play(Beat,10,2,NotesGuit);

spork~bass.play(Beat,10,2,NotesB);
spork~mode.play(Beat,10,2,Notes);
MidiInDist MD;