public class Bass
{
Mandolin bass => NRev r => dac;
0.1 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
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
          
         
            Std.mtof(finalNotes[i])=>bass.freq;
            Math.random2f(0.1,0.2) => bass.gain;
           
            Std.mtof(finalNotes[i]-24)=>bass.freq;
            Math.random2f(0.1,0.2) => bass.gain;
             1=>bass.noteOn;
            finalBeats[i]::second=>now;    
    0=>bass.noteOn;
            }
       
            else
            {
             
            finalBeats[i]::second=>now;
            }
    }
}
}

}