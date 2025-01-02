// Chalupa
genDrummer perc;
genDrummer perc2;

genDrummer perc3;
HarmonySynth FH;
Bass bass;
RonModes mode;
0.23=>float Beat;

[615,715,0,415,0,515,415,0,415,0,515,615,814,0,814,0]@=>int NotesD[];
[702,602,0,600,0,702,803,0,0,303,0,0,0,502,0,0]@=>int NotesD2[];
[0,0,717,0]@=>int NotesD3[];
[5462,5158,0,5462,0,0,4462,0,
0,0,5158,0,0,0,5460,0,
5462,5158,0,5462,0,0,4462,0,
0,0,5158,0,0,0,5460,0]@=>int Notes[];
[672,772,0,872,770,0,867,0,
970,0,972,0,0,0,0,0,
975,0,0,770,0,0,972,972,
872,772,0,0,0,0,0,0]@=>int NotesG[];
[965,565,0,568,0,568,0,0,0,0,462,0,0,0,268,0]@=>int NotesB[];

synch s;
s.cycle(16,Beat);
s.hush();
//spork ~ FH.play(Beat,10,1,NotesG);
//spork ~ perc.play(Beat,10,1,NotesD2);
spork ~ perc3.play(Beat,3,1,NotesD3);
//spork ~ mode.play(Beat,10,1,Notes);
//spork ~ bass.play(Beat,10,1,NotesB);

 perc2.play(Beat,10,1,NotesD);