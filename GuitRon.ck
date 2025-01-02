class ChordsGuit extends Chugraph
{
//LPF es un LowPassFIlter(o filtro pasabajos)
//NRev le agrega reverberación
    
HnkyTonk g; 
HnkyTonk guit[1];
NRev r => Delay d=> dac;  
    500::samp => d.delay;
0.15 => r.gain; 0.01 => r.mix;


[97,71,77,81] @=> int opGains[];
[1.0,3.0,3.02,8.0] @=> float ratios[];
[31,28,31,31] @=> int attacks[];
[15,3,8,6] @=> int decays[];
[10,0,0,0] @=> int sustains[]; // 15,0,0,0 ???
[0,0,0,0] @=> int releases[];

for( int i; i < guit.size(); i++ )
{
    guit[i] => r;

    for( int op; op < 4; op++ )
    {
        guit[i].opWave( op,1 );  // sine waves all
        guit[i].opGain( op,g.getFMTableGain(opGains[op]) );
        guit[i].opADSR( op,	g.getFMTableTime(attacks[op]),
                            g.getFMTableTime(decays[op]),
                            g.getFMTableSusLevel(sustains[op]),
                            g.getFMTableTime(releases[op]) );
        guit[i].opRatio( op,ratios[op] );    
        guit[i].lfoDepth( 0.02 );
    }
}



fun void allOff() {
    for (int i; i < guit.size(); i++) 1 => guit[i].noteOff;
}

fun void keyOn( int Note, float Beat, int gain1) {
   
        Std.mtof(Note) => guit[0].freq;
         Math.random2f(0.05,0.06)*gain1*0.8=>guit[0].noteOn;
         Beat::second=>now;
         allOff();
       
}

     fun void play1(float Beat, int percentage, int type, int Notes[],int Gains[])
   {
     
     while(true)
     {
         percentage+(Math.random2(-8,8))=>int percent;
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percent,type)@=>float finalBeats[];
       
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
        keyOn(finalNotes[i],finalBeats[i],Gains[i]);
       
        }
            else
            {
            allOff();
            finalBeats[i]::second=>now;
            }
    }
}
}

   
}
  



public class GuitRonModes
{
   
ChordsGuit m1;
ChordsGuit m2;
ChordsGuit m3;
ChordsGuit m4;
   
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
  // first digit is the scale for modes 1 for Grip Modes
  //
  //second digit is the #Grip
  //3rd and 4th digits are offset note        
 Notes[i]%100=>int Offset;
  (Notes[i]/100)%10=>int ModeType;        
Notes[i]/1000=>int gains;

          
          
   
   
          
   
  if (Notes[i]/1000>=1)// Grip Modes
  {  
   gains=>finalGains[i];
 if (ModeType==1)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"sus2">>>;
       <<<Offset+2>>>;
      
     
 Offset+7=>finalNotes1[i];
 Offset=>finalNotes2[i];
 Offset+2=>finalNotes3[i];
     0=> finalNotes4[i];
     
  
 
     

 
  }
   if (ModeType==2)// Dorian "So what" offset is +2
  { 
      <<<"Dorian">>>;
      <<<Offset+2>>>;
 
 Offset-12=>finalNotes1[i];
 Offset-7=>finalNotes2[i];
 Offset-2=>finalNotes3[i];
 Offset+3=> finalNotes4[i];
 
 
   
  }
   if (ModeType==3)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"5/6">>>;
       <<<Offset+2>>>;
      
 Offset=>finalNotes1[i];
 Offset+4=>finalNotes2[i];
 Offset+6=>finalNotes3[i];
 0=> finalNotes4[i];
     
      
 
 
     

 
  }
    if (ModeType==4)// in order US 6/5 Grip, 
  { 
      <<<"6/5 Grip">>>;
      <<<Offset>>>;
 Offset=>finalNotes1[i];
 Offset+3=>finalNotes2[i];
 Offset+5=>finalNotes3[i];
 Offset-6=> finalNotes4[i];
       
 

  }
  if (ModeType==5)// Phrygian US, phrygian is Offset
  { 
      <<<"Phrygian US">>>;
      <<<Offset>>>;
Offset=>finalNotes1[i];
 Offset+1=>finalNotes2[i];
 Offset+5=>finalNotes3[i];
 Offset+7=> finalNotes4[i];
 

 
  }
   if (ModeType==6)// Melodic Minor Grip, Offset-3 is Melodic Minor
  { 
      <<<"Melodic Minor Grip">>>;
      <<<Offset>>>;
 Offset=>finalNotes1[i];
 Offset+4=>finalNotes2[i];
 Offset+8=>finalNotes3[i];
 Offset+11=> finalNotes4[i];

   
 
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


