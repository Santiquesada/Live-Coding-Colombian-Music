public class Harmonium extends Chugraph
{

    
SawOsc osc => ADSR env1 => LPF lpf=>NRev rev=>Dyno dyno =>dac;

 5=>lpf.Q;
    2500=>int tempfreq;
    fun void keyOn(int key,float Beat,int gain)
    {
        3500=>lpf.freq;
      Math.random2f(0.3,0.31)*gain/10=>osc.gain;
       (1::ms,300::ms,0.0,1::ms)=>env1.set;
       key-12=>Std.mtof=>osc.freq;
       0.05=>rev.mix;
      1=>env1.keyOn;
      for(0=>int i; i<20;i++)
      {
      tempfreq+50=>lpf.freq;
      tempfreq+50=>tempfreq;    
      Beat*0.05::second=>now;
      }    
         1=>env1.keyOff;
       
     
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


