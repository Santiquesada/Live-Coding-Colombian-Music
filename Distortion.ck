public class Distortion extends Chugraph
{

    
 SawOsc osc;
 BeeThree c=>ADSR env1=>NRev rev=>dac;
0.2=>rev.mix;


        
   
    fun void keyOn(int key,float Beat)
    {
      Math.random2f(0.2,0.4)=>osc.gain;
       (10::ms, Beat::second,0.0, 1::ms) =>env1.set;
       key-12=>Std.mtof=>osc.freq;
        key=>Std.mtof=>c.freq;
        1=>c.noteOn;
       1=>env1.keyOn;
      Beat::second=>now;
       
     
     
    }
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
       Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percentage,type)@=>float finalBeats[];
     while(true)
     {  
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
        keyOn(finalNotes[i],finalBeats[i]);
       
        }
            else
            {
            
            finalBeats[i]::second=>now;
            }
    }
}
}

   
}


