genDrummer Player;
rhythm ryth;
0.2=>float Beat;
// Grip 1 // Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
[1352,0,0,1352,0,1453,1350,1350,0,1352,1352,0]@=>int NotesM[];// D Mixo and E Phrigyan
//common tones D E G A C
[60,0,64,66]@=>int NotesB[];

[109,0,109,109,0,109]@=>int NotesD[];
[0,113,111,111]@=>int NotesD2[];
[100,0,102,0,102,0]@=>int NotesD3[];

[62,0,67,64,0,69,0,72,
67,67,64,0,0,0,0,0,
64,0,64,0,62,62,67,72,
0,0,-1,72,67,-1,0,69,0,72,0]@=>int NotesMS[];

synch s;
s.cycle(6,Beat);

//ryth.Aguabajo(Beat,20);
Player.play(Beat,10,2,NotesD3);