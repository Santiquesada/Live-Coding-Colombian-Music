genDrummer perc;
genDrummer perc2;
genDrummer perc3;
Marimba marimba;
Marimba marimba2;
0.21=>float Beat;
[860,0,657,664,860,0,759,0,755,764,862,0]@=>int NotesBordon1[];
[857,0,0,0,857,0,755,0,0,0,855,0]@=>int NotesBordon2[];

[512,0,511]@=>int NotesD[];
[699,199,699,199,999,199]@=>int NotesD2[];
[709,0,708,709,910,0]@=>int NotesD3[];
synch s;
s.cycle(12,Beat);
s.hush();
spork~perc2.play(Beat,6,2,NotesD3);
spork~perc3.play(Beat,6,2,NotesD2);
spork~marimba.play(Beat,6,2,NotesBordon1);
spork~marimba2.play(Beat,6,2,NotesBordon2);

perc.play(Beat,6,2,NotesD);
