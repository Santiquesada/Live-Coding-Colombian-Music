public class CSynth extends Chugraph
{

Noise noise => ADSR env1 => SqrOsc two =>  Gain ramp => SqrOsc one =>  ResonZ reson => ADSR env2 => HalfRect hf =>NRev rev=> Gain out => HPF hpf => LPF lpf => dac;

one.sync(2);

env1.set(50::ms,20::ms,0.1,80::ms);
env2.set(50::ms,50::ms,0.1,80::ms);

two.gain(0.005);
one.gain(0.006);
ramp.gain(10);
out.gain(15);
reson.freq(1000);
reson.Q(0.2);
hpf.freq(1000);
hpf.Q(2);
lpf.freq(1000);
lpf.Q(5);

0.1=> rev.mix;
 
    fun void keyOn(int key,float Beat,int gain)
    {
      Math.random2f(0.3,0.33)*gain/100=>one.gain;
        Math.random2f(0.3,0.33)*gain/50=>two.gain;
       
       key=>Std.mtof=>one.freq;
        key=>Std.mtof=>two.freq;
       reson.freq(one.freq()*1);
     env1.keyOn();
                env2.keyOn();
      Beat::second=>now;
           env1.keyOff();
                env2.keyOff();

       
     
    }
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
     
     while(true)
     {
         percentage+(Math.random2(-8,8))=>int percent;
         
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percent,type)@=>float finalBeats[];
       
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
        keyOn(finalNotes[i]%100,finalBeats[i],finalNotes[i]/100);
       
        }
            else
            {
            
            finalBeats[i]::second=>now;
            }
    }
}
}

   
}


