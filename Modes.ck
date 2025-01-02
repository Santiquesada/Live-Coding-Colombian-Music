public class Modes
{
Rhodey m1=>JCRev rev=>Chorus c=>dac;
    0.1=>c.mix;
 Rhodey m2=>rev;
 Rhodey m3=>rev;  
 Rhodey m4=>rev;
 Rhodey m5=>rev; 
  Rhodey m6=>rev;    
    0.18=>rev.mix;
   0.5=> m1.afterTouch;
    0.5=> m2.afterTouch;
 0.5=> m3.afterTouch;

  //  1000=>m1.lfoSpeed;
   //  1000=>m2.lfoSpeed;
   //  1000=>m3.lfoSpeed;


   //0.5=> m2.afterTouch;
  //0.5=> m3.afterTouch ;  
 
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
 Std.mtof(Offset+7)=>m1.freq;
 Std.mtof(Offset)=>m2.freq;  
 
 Std.mtof(Offset+2)=>m3.freq;  
 //Math.random2f(0.0,0.3) => m1.filterQ;
// Math.random2f(0.01,1.0) => m1.filterSweepRate;
// Math.random2f(0.0,0.3) => m2.filterQ;
// Math.random2f(0.01,1.0) => m2.filterSweepRate;     
 //Math.random2f(0.0,0.3) => m3.filterQ;
 //Math.random2f(0.01,1.0) => m3.filterSweepRate;     

 Math.random2f(0.2,0.3)=>m1.noteOn;
  Math.random2f(0.2,0.3)=>m2.noteOn;
  Math.random2f(0.2,0.3)=>m3.noteOn;
  }
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
   if (ModeType==3)// in order, Phrygian 5/6 US Grip Taken from Miles, Ron Miller, Bass note, half step below offset
  { 
      <<<"5/6 Grip 3">>>;
    
 Std.mtof(Offset)=>m1.freq;
 Std.mtof(Offset+4)=>m2.freq;  
 
 Std.mtof(Offset+6)=>m3.freq;  
 Std.mtof(Offset+11)=>m4.freq;  
 

  Math.random2f(0.09,0.13)=>m1.noteOn;
  Math.random2f(0.09,0.13)=>m2.noteOn;
  Math.random2f(0.09,0.1)=>m3.noteOn;
  Math.random2f(0.09,0.1)=>m4.noteOn;    
         
  }
     if (ModeType==4)// in order US 6/5 Grip, Ionian is Offset +1
  { 
      <<<"6/5 Grip">>>;
      <<<Offset>>>;
 Std.mtof(Offset)=>m1.freq;
 Std.mtof(Offset+3)=>m2.freq;  
 
 Std.mtof(Offset+5)=>m3.freq;  
 

  Math.random2f(0.05,0.1)=>m1.noteOn;
  Math.random2f(0.05,0.1)=>m2.noteOn;
  Math.random2f(0.05,0.1)=>m3.noteOn;
  }
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
    
 finalBeats[i]::second=>now;
  1=>m1.noteOff;
  1=>m2.noteOff;
  1=>m3.noteOff;
  1=>m4.noteOff;
  1=>m5.noteOff;
  1=>m6.noteOff;
  }
   
if (finalNotes[i]==0)
  {
        finalBeats[i]::second=>now;
  1=>m1.noteOff;
  1=>m2.noteOff;
  1=>m3.noteOff;
  1=>m4.noteOff;
  1=>m5.noteOff;
  1=>m6.noteOff;    
  }
 }
 }  
  }  
}  
MelodySynth m;
synch s;
s.cycle(8,0.2);
//[1360,0,1360,1360,0,-1,1360,1360,-1, 0,1360]@=>int Notes[];
//[61,60,68,0,61,63,0,61,68,0,60,61,68,61,60,68]@=>int Notes[];
//[109,108]@=>int Notes[];
//[60,0,60,0,61,0,61,0]@=>int Notes[];
//[101,104,105,106,107,103,104,105]@=>int Notes[];
//[70,74,72,0,70,70,74,75]@=>int Notes[];
//m.play(0.2,10,1,Notes);
