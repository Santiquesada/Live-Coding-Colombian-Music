public class HarmonySynth extends Chugraph
{
 MidiIn midi;
         MidiIn midi2;
    MidiMsg msg;
     MidiMsg msg2;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();
     if(!midi2.open(device))me.exit(); 
    40=>int defaultgain;
    40=> int previousgain;
    40=> int currentgain;
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
        
        
        if(msg.data1==176 && msg.data2==23)
        {
          
           
            msg.data3=> currentgain;
            msg.data3=>previousgain;
            
            
        }
       else
           previousgain=>currentgain;
        
    }
}
  }

    spork~Midiinput();  
    
    
    
    
    
FrencHrn osc=>NRev rev=>outlet;

  osc.op(4);
   
0.06=>rev.mix;


 
    fun void keyOn(int key,float Beat,int gain)
    {
      currentgain/5*Math.random2f(0.3,0.31)*gain/100.0=>osc.gain;
       
       key=>Std.mtof=>osc.freq;
       
      1=>osc.noteOn;
      Beat::second=>now;
         1=>osc.noteOff;
       
     
    }
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
        Beat=>GrandBeat;
       spork~Midiinput();  
        spork~Accel(Beat); 
     
     while(true)
     {
        
         percentage+(Math.random2(-8,8))=>int percent;
         
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,GrandBeat,percent,type)@=>float finalBeats[];
       
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


