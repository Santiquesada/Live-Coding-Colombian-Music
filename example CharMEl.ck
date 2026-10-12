// --- ChAR jazz: ii-V-I ---
// load the class first: Machine.add(me.dir() + "ChARMel.ck");

160 => float bpm;
60.0 / bpm => float Beat;

genDrummer perc;

ChARMel m;
[9555,0,0,8555,6555,0,
8153,0,0,3153,0,0]@=>int Notes[];
m.setProgresion("Dm,G7,Cmaj7,Cmaj7");

// play(Beat, swing %, swing type, beats)
// type 1 = binary, 33% ~ triplet feel on eighths
spork ~ m.play(Beat, 33, 1, 16);
perc.play(Beat,8,2,Notes);
