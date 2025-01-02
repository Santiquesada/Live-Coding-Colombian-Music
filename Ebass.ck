
public class eBass extends Chugraph
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
     
      float GrandBeat;
    
PulseOsc p =>ADSR env1=>NRev r=>outlet; // connect a new PulseOsc to dac

0.01=>r.mix;
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
            (10::ms, Beat*0.8::second,0.0, 1::ms) =>env1.set; 
            Math.random2f(0.01,0.9) => p.width; // set random pulse width
         
            Std.mtof(finalNotes[i]%100 -24)=>p.freq;
            
            Math.random2f(0.02,0.03) => p.gain;
           Math.random2f(0.01,0.9) => p.width; // set random pulse width
         
           
            currentgain/100.0*0.02*finalNotes[i]/100 => p.gain;
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
