public class Marimba extends Chugraph
{
      MidiIn midi;
         MidiIn midi2;
    MidiMsg msg;
     MidiMsg msg2;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();
     if(!midi2.open(device))me.exit(); 
    70=>int defaultgain;
    70=> int previousgain;
    70=> int currentgain;
    float GrandBeat;
     
     fun void Accel(float Beat)
 { 
  while(true)
{
    midi2=>now;
    while(midi2.recv(msg2))
    {
        
        
        if(msg2.data1==176 && msg2.data2==1)
        {
           
           
           Beat*(1-msg2.data3*0.25/127.0)=> GrandBeat;
           
            
        }
              
    }
}
  }
     
     
     
     
     
     
     
      fun void Midiinput()
 { 
  while(true)
{
    midi=>now;
    while(midi.recv(msg))
    {
        
        
        if(msg.data1==176 && msg.data2==25)
        {
          
           
            msg.data3=> currentgain;
            msg.data3=>previousgain;
            
            
        }
       else
           previousgain=>currentgain;
        
    }
}
  }
    
    
    
    
    
   me.dir() + "/Samples/MarimbaenDo.wav" => string filename;
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
          spork~Midiinput();  
           spork~Accel(Beat); 
        
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
              currentgain/70.0*MyGain*0.4=>Marimba.gain;
               finalBeats[i]::second=>now;
          }
          
          
          
          
          else 
              finalBeats[i]::second=>now; 
      }
  }
        
    }
}


