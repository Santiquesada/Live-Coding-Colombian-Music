class CSynthM extends Chugraph
{

Noise noise => ADSR env1 => SqrOsc two =>  Gain ramp => SqrOsc one =>  ResonZ reson => ADSR env2 => HalfRect hf =>NRev rev=> Gain out => HPF hpf => LPF lpf => dac;

one.sync(2);

env1.set(50::ms,20::ms,0.1,80::ms);
env2.set(50::ms,50::ms,0.1,80::ms);

two.gain(0.005);
one.gain(0.006);
ramp.gain(10);
out.gain(15);
reson.freq(1000);
reson.Q(0.2);
hpf.freq(1000);
hpf.Q(2);
lpf.freq(1000);
lpf.Q(5);

0.1=> rev.mix;
 
    fun void keyOn(int key,float Beat,int gain)
    {
      Math.random2f(0.3,0.33)*gain/200=>one.gain;
        Math.random2f(0.3,0.33)*gain/100=>two.gain;
       
       key=>Std.mtof=>one.freq;
        key=>Std.mtof=>two.freq;
       reson.freq(one.freq()*1);
     env1.keyOn();
                env2.keyOn();
      Beat::second=>now;
           env1.keyOff();
                env2.keyOff();

       
     
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
            
            finalBeats[i]::second=>now;
            }
    }
}
}
}

   

  



public class CSynthModes
{
   

CSynthM m1;
CSynthM m2;
CSynthM m3;
CSynthM m4;
   
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
       if (ModeType==0)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"Single">>>;
       <<<Offset>>>;
      
     
 Offset=>finalNotes1[i];
 0=>finalNotes2[i];
 0=>finalNotes3[i];
     0=> finalNotes4[i];
     
  
 
     

 
  }
 if (ModeType==1)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"sus2">>>;

      
     
 Offset+7=>finalNotes1[i];
 Offset=>finalNotes2[i];
 Offset+2=>finalNotes3[i];
     0=> finalNotes4[i];
     
  
 
     

 
  }
   if (ModeType==2)// Dorian "So what" offset is +2
  { 
      <<<"So what">>>;
     
 
 Offset-12=>finalNotes1[i];
 Offset-7=>finalNotes2[i];
 Offset-2=>finalNotes3[i];
 Offset+3=> finalNotes4[i];
 
 
   
  }
   if (ModeType==3)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
                   //Use Grip 1 in Offset+2 or in offset
                    
                                               
  { 
      <<<"5/6">>>;
       <<<Offset+2>>>;
      
 Offset=>finalNotes1[i];
 Offset+4=>finalNotes2[i];
 Offset+6=>finalNotes3[i];
 0=> finalNotes4[i];
     
      
 
 
     

 
  }
    if (ModeType==4)// in order US 6/5 Grip, 
                    //use grip 1 in offset +3
                          
        
  { 
      <<<"6/5 Grip">>>;
      <<<Offset>>>;
 Offset=>finalNotes1[i];
 Offset+3=>finalNotes2[i];
 Offset+5=>finalNotes3[i];
 Offset-6=> finalNotes4[i];
       
 

  }
  if (ModeType==5)// Phrygian US, phrygian is Offset, use grip 1 in Offset +3
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
   if (ModeType==7)// Quartal Grip
  { 
      <<<"Quartal Grip">>>;
      <<<Offset>>>;
 Offset=>finalNotes1[i];
 Offset+5=>finalNotes2[i];
 Offset+10=>finalNotes3[i];
 
   
 
  }
     if (ModeType==8)// Crunchy Quartal Grip
  { 
      <<<"Quartal Grip">>>;
      <<<Offset>>>;
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


