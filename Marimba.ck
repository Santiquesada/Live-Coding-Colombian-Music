public class Marimba extends Chugraph
{
    
    float GrandBeat;
     
    
 { 

  }
     
     
     
     
     
     
 
    
    
    
    
    
   me.dir() + "/Samples/MarimbaenDO.wav" => string filename;
    SndBuf Marimba=>outlet;
 
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
      
        Beat=>GrandBeat;
       
        
       while(true)
       {
          
           
             percentage+(Math.random2(-5,5))=>int percent;
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,GrandBeat,percent,type)@=>float finalBeats[];
     
           for(0=>int i;i<finalNotes.size();i++)
      {
          if (finalNotes[i]>0)
          {
          
          finalNotes[i]%100-60=>int tones;
          
          transpose(tones)=>Marimba.rate;
         
           filename=>  Marimba.read;
            0=>Marimba.pos;
              
              finalNotes[i]/200=>int MyGain;
              MyGain=>Marimba.gain;
            
               finalBeats[i]::second=>now;
          }
          
          
          
          
          else 
              finalBeats[i]::second=>now; 
      }
  }
        
    }
}


