public class Bass extends Chugraph
{
     MidiIn midi;
         MidiIn midi2;
    MidiMsg msg;
     MidiMsg msg2;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();
     if(!midi2.open(device))me.exit(); 
    30=>int defaultgain;
    30=> int previousgain;
    30=> int currentgain;
    
    
Mandolin bass => NRev r => outlet;
0.08 => r.mix;
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
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
        
        
        if(msg.data1==176 && msg.data2==21)
        {
          
           
            msg.data3=> currentgain;
            msg.data3=>previousgain;
            
            
        }
       else
           previousgain=>currentgain;
        
    }
}
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
      
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
          
         
           
            Std.mtof(finalNotes[i]%100-24)=>bass.freq;
            currentgain*0.003*finalNotes[i]/500 => bass.gain;
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