RonModes mode=>dac;
SenDrummer Perc;
0.20=>float Beat;

[5160,0,7162,0,0,4358,9358,0]@=>int Notes[];
[900,0,800,0,500,0,500,0]@=>int NotesD[];
synch s;
s.cycle(8,Beat);
spork ~Perc.play(Beat,10,1,NotesD);
mode.play(Beat,10,1,Notes);