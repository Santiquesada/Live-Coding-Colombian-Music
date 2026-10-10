Marimba marimba;
Marimba marimba2;
genDrummer drum;
genDrummer drum2;
0.25=>float Beat;
synch s;
s.cycle(16,Beat);
[964,0,557,560,557,560,557,560,
964,0,559,662,559,662,559,662,
964,0,559,662,559,662,559,662,
964,0,557,560,557,560,557,560]@=>int Notes[];
[952,0,0,0,0,0,0,0,
952,0,0,0,0,0,0,0]@=>int Notes2[];
s.hush();
[810,0,709,708,410,0,709,0]@=>int NotesD[];
[399,0,399,0]@=>int NotesD2[];
spork~ drum.play(Beat,20,1,NotesD);
spork~drum2.play(Beat,35,1,NotesD2);

spork~ marimba.play(Beat,20,1,Notes);
marimba2.play(Beat,20,1,Notes2);