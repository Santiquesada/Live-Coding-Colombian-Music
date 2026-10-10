public class MarimbaTimes
{
    me.dir() + "/Samples/MarimbaenDO.wav" => string filename;
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
        
      
      0.0 => float elapsed;   // tiempo acumulado dentro del compas

      for(0=>int i;i<finalNotes.size();i++)
      {
          if (finalNotes[i]>0)
          {
          finalNotes[i]-60=>int tones;

          transpose(tones)=>Marimba.rate;

           filename=>  Marimba.read;
        0=>Marimba.pos;

        // Acentos: 6ta fuerte, 4ta medio, 2da semicorchea del 1er pulso medio, resto suave
        if (elapsed >= Beat * 4.9)
            Math.random2f(0.85, 1.0) => Marimba.gain;   // 6ta corchea: fuerte
        else if (elapsed >= Beat * 2.9 && elapsed < Beat * 4.0)
            Math.random2f(0.65, 0.8) => Marimba.gain;   // 4ta corchea: medio
        else if (elapsed >= Beat * 0.4 && elapsed < Beat * 1.0)
            Math.random2f(0.65, 0.8) => Marimba.gain;   // 2da semicorchea del 1er pulso: medio
        else
            Math.random2f(0.4, 0.65) => Marimba.gain;   // resto: suave

               finalBeats[i]::second=>now;
          }
          else
              finalBeats[i]::second=>now;

          finalBeats[i] +=> elapsed;

      }
  
        
    }
}


