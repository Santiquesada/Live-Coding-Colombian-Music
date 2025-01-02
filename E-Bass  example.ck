
public class eBass
{
PulseOsc p =>ADSR env1=>NRev r=>dac; // connect a new PulseOsc to dac

0.01=>r.mix;

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
            (10::ms, Beat*0.8::second,0.0, 1::ms) =>env1.set; 
            Math.random2f(0.01,0.9) => p.width; // set random pulse width
         
            Std.mtof(finalNotes[i])=>p.freq;
            Math.random2f(0.1,0.2) => p.gain;
           Math.random2f(0.01,0.9) => p.width; // set random pulse width
         
            Std.mtof(finalNotes[i]-24)=>p.freq;
            Math.random2f(0.1,0.2) => p.gain;
             1=>env1.keyOn;
            finalBeats[i]::second=>now;    
    0=>env1.keyOn;
            }
       
            else
            {
             
            finalBeats[i]::second=>now;
            }
    }
}
}
}
