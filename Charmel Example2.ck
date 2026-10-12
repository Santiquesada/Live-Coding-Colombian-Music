Marimba marimba=>dac;
genDrummer perc;

ChARMel m;

m.setProgresion("Em,A7,A7,Dmaj7");
0.17=>float Beat;
synch s;
s.cycle(12,Beat);
s.hush();
[1902,0,603,1802,1902,0,603,1802]@=>int NotesD[];
[264,0,0,0,257,461,0,0,762,0,0,0,362,0,0,465]@=>int NotesBordon[];
spork~perc.play(Beat,33,1,NotesD);
spork ~ m.play(Beat, 33, 1, 16);
marimba.play(Beat,33,1,NotesBordon);