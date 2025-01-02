public class MarimbaTimes
{
    me.dir() + "/Samples/MarimbaenDo.wav" => string filename;
    SndBuf Marimba=>dac;
     fun float transpose(int semitones)
    {
          1.05946309435929=>float semitone;
          1=>float result;
        if (semitones>0)
        {
            for(0=>int i; i<semitones;i++)
            {
                result*semitone=>result;
            }
        }
                if (semitones<0)
        {
            for(0=>int i; i>semitones;i--)
            {
                result*(1/semitone)=>result;
            
            }
        }
        return result;
    }
    
    fun void play(float Beat, int percentage, int type, int Notes[])
    
   
    {
       Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percentage,type)@=>float finalBeats[];
        
      
      for(0=>int i;i<finalNotes.size();i++)
      {
          if (finalNotes[i]>0)
          {
          finalNotes[i]-60=>int tones;
          
          transpose(tones)=>Marimba.rate;
         
           filename=>  Marimba.read;
        0=>Marimba.pos;
        Math.random2f(0.6,0.9)=>Marimba.gain;
               finalBeats[i]::second=>now;
          }
          else 
              finalBeats[i]::second=>now; 
            
      }
  
        
    }
}


