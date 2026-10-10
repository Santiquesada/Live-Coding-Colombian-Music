Bass bass=>dac;
genDrummer perc;
[367,0,365,0,367,0,365,0,369,0,360,0,357,0,360,0]@=>int NotesB[];
[1702,0,1702,1602]@=>int NotesD[];
cubanDrummer perc2;
[422,324,322,325,423,424,323,221]@=>int NotesD2[];
ChARMel  jazz;

jazz.setProgresion("Em7b5,A7, Dm7, Fm7");
0.19   =>float Beat;
synch s;
s.cycle(32 ,Beat);
s.hush();
spork~perc2.play(Beat,30,1,NotesD2);
spork~bass.play(Beat,30,1,NotesB);
spork~jazz.play(Beat, 30,1,32);

perc.play(Beat,30,1,NotesD);