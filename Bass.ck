public class Bass extends Chugraph
{
    
    
    
Mandolin bass => NRev r => outlet;
0.08 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
     float GrandBeat;
    

  
    
    
    
    
    
    
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
      
        
      
     while(true)
     {
       
         percentage+(Math.random2(-5,5))=>int percent;
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percent,type)@=>float finalBeats[];
      
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
          
         
           
            Std.mtof(finalNotes[i]%100-24)=>bass.freq;
            finalNotes[i]*0.0001=> bass.gain;
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