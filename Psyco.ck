public class Psyco extends Chugraph
{
 MidiIn midi;
    MidiMsg msg;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();

    20=>int defaultgain;
    20=> int previousgain;
    20=> int currentgain;
    
      fun void Midiinput()
 { 
  while(true)
{
    midi=>now;
    while(midi.recv(msg))
    {
        
        
        if(msg.data1==176 && msg.data2==24)
        {
          
           
            msg.data3=> currentgain;
            msg.data3=>previousgain;
            
            
        }
       else
           previousgain=>currentgain;
        
    }
}
  }

    
    
    
 SinOsc osc=>ADSR env1=>NRev rev=>dac;
   
0.04=>rev.mix;


        
   
    fun void keyOn(int key,float Beat,int gain)
    {
      currentgain*gain/200.0*Math.random2f(0.2,0.4)=>osc.gain;
       (10::ms, 10::ms,0.0, 1::ms) =>env1.set;
       key+12=>Std.mtof=>osc.freq;
       1=>env1.keyOn;
      Beat::second=>now;
       
     
     
    }
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
        spork~Midiinput(); 
       Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percentage,type)@=>float finalBeats[];
     while(true)
     {  
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


