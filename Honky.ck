class HonkySynth extends Chugraph
{
    float GrandBeat;
 MidiIn midi;
         MidiIn midi2;
    MidiMsg msg;
     MidiMsg msg2;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();
     if(!midi2.open(device))me.exit(); 
    20=>int defaultgain;
    20=> int previousgain;
    20=> int currentgain;
    
 HnkyTonk osc=>ADSR env1=>LPF lpf=>outlet;
500=>lpf.freq;
5=>lpf.Q;
     
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
        
        
        if(msg.data1==176 && msg.data2==22)
        {
         
           
            msg.data3=> currentgain;
            msg.data3=>previousgain;
            
            
        }
       else
           previousgain=>currentgain;
        
    }
}
  }





 

    fun void keyOn(int key,float Beat,int gain1)
    {
      
       currentgain*0.0002*gain1=>osc.gain;
        
       (10::ms, Beat::second,0.0, 1::ms) =>env1.set;
       key=>Std.mtof=>osc.freq;
        1=>osc.noteOn;
       1=>env1.keyOn;
        Beat::second=>now;
         1=>osc.noteOff;
       
      Math.random2f(0.1,0.5)*4000=>lpf.freq; 
     
    }
     fun void play1(float Beat, int percentage, int type, int Notes[],int Gains[])
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
        keyOn(finalNotes[i],finalBeats[i],Gains[i]);
       
        }
            else
            {
            
            finalBeats[i]::second=>now;
            }
    }
    }
}

   
}
  


public class RonModes extends Chugraph
{
  
    
    NRev r=>outlet;
0.05=>r.mix;
HonkySynth m1=>r;
HonkySynth m2=>r;
HonkySynth m3=>r;
HonkySynth m4=>r;
   
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
       int finalGains[Notes.size()];
       int finalNotes1[Notes.size()];
   int finalNotes2[Notes.size()];
   int finalNotes3[Notes.size()];
   int finalNotes4[Notes.size()];

  while(true)
 {    
  for(0=>int i;i<Notes.size();i++)
      {  
  // first digit is the gain
  //
  //second digit is the #Grip
  //3rd and 4th digits are offset note        
 Notes[i]%100=>int Offset;
  (Notes[i]/100)%10=>int ModeType;        
Notes[i]/1000=>int gains;

          
          
   
   
          
   
  if (Notes[i]/1000>=1)// Grip Modes
  {  
   gains=>finalGains[i];
       if (ModeType==0)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
     
     
 Offset=>finalNotes1[i];
 0=>finalNotes2[i];
 0=>finalNotes3[i];
     0=> finalNotes4[i];
     
  
 
     

 
  }
 if (ModeType==1)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
     

      
     
 Offset+7=>finalNotes1[i];
 Offset=>finalNotes2[i];
 Offset+2=>finalNotes3[i];
     0=> finalNotes4[i];
     
  
 
     

 
  }
   if (ModeType==2)// Dorian "So what" offset is +2
  { 
     
 
 Offset=>finalNotes1[i];
 Offset+5=>finalNotes2[i];
 Offset+10=>finalNotes3[i];
 Offset+15=> finalNotes4[i];
 
 
   
  }
   if (ModeType==3)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
                   //Use Grip 1 in Offset+2 or in offset
                    
                                               
  { 
      
 Offset=>finalNotes1[i];
 Offset+4=>finalNotes2[i];
 Offset+6=>finalNotes3[i];
 0=> finalNotes4[i];
     
      
 
 
     

 
  }
    if (ModeType==4)// in order US 6/5 Grip, 
                    //use grip 1 in offset +3
                          
        
  { 
     
 Offset=>finalNotes1[i];
 Offset+3=>finalNotes2[i];
 Offset+5=>finalNotes3[i];
 Offset-6=> finalNotes4[i];
       
 

  }
  if (ModeType==5)// Phrygian US, phrygian is Offset, use grip 1 in Offset +3
  { 
    
Offset=>finalNotes1[i];
 Offset+1=>finalNotes2[i];
 Offset+5=>finalNotes3[i];
 Offset+7=> finalNotes4[i];
 

 
  }
   if (ModeType==6)// Melodic Minor Grip, Offset-3 is Melodic Minor
  { 
     
 Offset=>finalNotes1[i];
 Offset+4=>finalNotes2[i];
 Offset+8=>finalNotes3[i];
 Offset+11=> finalNotes4[i];

   
 
  }
   if (ModeType==7)// Quartal Grip
  { 
      
 Offset=>finalNotes1[i];
 Offset+5=>finalNotes2[i];
 Offset+10=>finalNotes3[i];
 
   
 
  }
     if (ModeType==8)// Crunchy Quartal Grip
  { 
      
 Offset-1=>finalNotes1[i];
 Offset+5=>finalNotes2[i];
 Offset+10=>finalNotes3[i];
 
   
 
  }
 
}
if (Notes[i]==0)
  {
      0=>finalNotes1[i];
 0=>finalNotes2[i];
 0=>finalNotes3[i];
 0=> finalNotes4[i];
  
       
 
  }

   
}
spork~m1.play1(Beat,percentage,type,finalNotes1,finalGains);
spork~m2.play1(Beat,percentage,type,finalNotes2,finalGains);
spork~m3.play1(Beat,percentage,type,finalNotes3,finalGains);
m4.play1(Beat,percentage,type,finalNotes4,finalGains);


}
}
}


