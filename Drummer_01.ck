//----------------------------|
// on-the-fly synchronization
// adapted from Perry's ChucK Drummin' + Ge's sine poops

//--------------------------------------|

Beat::second => dur T;
T - (now % T) => now;

SndBuf buf => Gain g => dac;
me.dir() + "data/kick.wav" => buf.read;
.5 => g.gain;


    0 => buf.pos;
    Math.random2f(.8,.9) => buf.gain;

    T => now;
