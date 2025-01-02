public class ModesSynth
{
    
SynthSet m1;
SynthSet m2;
SynthSet m3;
SynthSet m4;
SynthSet m5;
SynthSet m6;    


 
 
 fun void play(float Beat, int percentage, int type, int Notes[])
 {


    
  Phrasing s;
  s.absNotes(Notes)@=>int finalNotes[];
  s.definingBeat(Notes,Beat,percentage,type)@=>float finalBeats[];    
 while(true)
 {    
  for(0=>int i;i<finalNotes.size();i++)
      {  
  // first digit is the scale for modes 1 for Grip Modes
  //
  //second digit is the #Grip
  //3rd and 4th digits are offset note        
  finalNotes[i]%100=>int Offset;
  (finalNotes[i]/100)%10=>int ModeType;        
   
   
  if (finalNotes[i]/1000==1)// Grip Modes
  {  
  
 if (ModeType==1)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"sus2">>>;
       <<<Offset+2>>>;
      
 spork~m1.keyOn(Offset-24+7,finalBeats[i]);
 spork~m2.keyOn(Offset-24,finalBeats[i]);
 m3.keyOn(Offset-24+2,finalBeats[i]);
  
 
     

 
  }
  /*
   if (ModeType==2)// Dorian "So what" offset is +2
  { 
      <<<"Dorian">>>;
      <<<Offset+2>>>;
 Std.mtof(Offset-12)=>m1.freq;
 Std.mtof(Offset-7)=>m2.freq;  
 
 Std.mtof(Offset-2)=>m3.freq;  
 Std.mtof(Offset+3)=>m4.freq;  
 
 Std.mtof(Offset+7)=>m5.freq;
 //Std.mtof(Offset+21)=>m6.freq;
Math.random2f(0.05,0.1)=>m1.noteOn;
  Math.random2f(0.05,0.1)=>m2.noteOn;
  Math.random2f(0.05,0.1)=>m3.noteOn;
  Math.random2f(0.05,0.1)=>m4.noteOn;    
   Math.random2f(0.05,0.1)=>m5.noteOn;
 Math.random2f(0.05,0.1)=>m6.noteOn;                
  }
  */
   if (ModeType==3)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"5/6">>>;
       <<<Offset+2>>>;
      
 spork~m1.keyOn(Offset-24,finalBeats[i]);
 spork~m2.keyOn(Offset-24+4,finalBeats[i]);
 spork~ m3.keyOn(Offset-24+6,finalBeats[i]);
m4.keyOn(Offset-24+11,finalBeats[i]);
 
     

 
  }
  
  
     if (ModeType==4)// in order US 6/5 Grip, Ionian is Offset +1
  { 
      <<<"6/5 Grip">>>;
      <<<Offset>>>;
 spork~m1.keyOn(Offset-24,finalBeats[i]);
 spork~m2.keyOn(Offset-24+3,finalBeats[i]);
 spork~m3.keyOn(Offset-24+5,finalBeats[i]);
 m4.keyOn(Offset-24-6,finalBeats[i]);     

  }
  /*
    if (ModeType==5)// Phrygian US, phrygian is Offset
  { 
      <<<"Phrygian US">>>;
      <<<Offset>>>;
 Std.mtof(Offset)=>m1.freq;
 Std.mtof(Offset+1)=>m2.freq;  
 
 Std.mtof(Offset+5)=>m3.freq;  
 Std.mtof(Offset+7)=>m4.freq;  
 

  Math.random2f(0.05,0.1)=>m1.noteOn;
  Math.random2f(0.05,0.1)=>m2.noteOn;
  Math.random2f(0.05,0.1)=>m3.noteOn;
  Math.random2f(0.05,0.1)=>m4.noteOn;    
  }
   
    if (ModeType==6)// Melodic Minor Grip, Offset-3 is Melodic Minor
  { 
      <<<"Melodic Minor Grip">>>;
      <<<Offset>>>;
 Std.mtof(Offset)=>m1.freq;
 Std.mtof(Offset+4)=>m2.freq;  
 
 Std.mtof(Offset+8)=>m3.freq;  
 Std.mtof(Offset+11)=>m4.freq;  
 

  Math.random2f(0.05,0.1)=>m1.noteOn;
  Math.random2f(0.05,0.1)=>m2.noteOn;
  Math.random2f(0.05,0.1)=>m3.noteOn;
  Math.random2f(0.05,0.1)=>m4.noteOn;    
  }
    
 */
  }
   
if (finalNotes[i]==0)
  {
        finalBeats[i]::second=>now;
 
  }
 }
 }  
  }  
}  
//MelodySynth m;
//synch s;
//s.cycle(8,0.2);
//[1360,0,1360,1360,0,-1,1360,1360,-1, 0,1360]@=>int Notes[];
//[61,60,68,0,61,63,0,61,68,0,60,61,68,61,60,68]@=>int Notes[];
//[109,108]@=>int Notes[];
//[60,0,60,0,61,0,61,0]@=>int Notes[];
//[101,104,105,106,107,103,104,105]@=>int Notes[];
//[70,74,72,0,70,70,74,75]@=>int Notes[];
//m.play(0.2,10,1,Notes);
