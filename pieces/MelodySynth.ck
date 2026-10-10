fun void sweep(LPF lpf)
{
  Math.random2f(4000,8000)=>lpf.freq;  
}
LPF lpf=>NRev rev=>dac;

5=>lpf.Q;
0.02=>rev.mix;
SinOsc osc=>ADSR e =>lpf;
0.5=>osc.gain;
//(1::ms,100::ms,0.0,1::ms)=>e.set;
0.1=>rev.mix;
[60,62,64,67,69]@=>int Notes[];
while(true)
{
Notes[(Math.random2(0,Notes.size()-1))]=>int FreqNote;
    1=>e.keyOn;
Std.mtof(FreqNote+12)=>osc.freq;
    
  spork~ sweep(lpf); 
0.3::second=>now;
}



