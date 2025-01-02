class RhodeySynth extends Chugraph
{
//LPF es un LowPassFIlter(o filtro pasabajos)
//NRev le agrega reverberación
    
 Rhodey voc => JCRev r => Echo a => Echo b => Echo c => dac;

//220.0 => voc.freq;
0.8 => voc.gain;
.5 => r.gain;
.02 => r.mix;
10::ms => a.max => b.max => c.max;
7::ms => a.delay => b.delay => c.delay;

        
    // Dentro de nuestro sintetizador crearemos una función que nos permita tocar una nota
    //Recibirémos un valor MIDI de nota y un valor decimal para saber por cuanto tiempo tocar.
        fun void keyOn(int key,float Beat)
    {
//concetaremos una onda diente de sierra a un ADSR y a un filtro
      
      //le damos un poco de aleatoriedad a la ganancia  
      Math.random2f(0.3,0.5)=>voc.gain;
       
       //convertimos el valor MIDI a Hertz
       key-12=>Std.mtof=>voc.freq;
        1=>voc.noteOn;
      
      Beat::second=>now;
       
      1=>voc.noteOff;
     
    }
     fun void play(float Beat, int percentage, int type, int Notes[])
   {
       Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percentage,type)@=>float finalBeats[];
     while(true)
     {  
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
        keyOn(finalNotes[i],finalBeats[i]);
       
        }
            else
            {
            
            finalBeats[i]::second=>now;
            }
    }
}
}

   
}
  



public class RodModes
{
   

RhodeySynth m1;
RhodeySynth m2;
RhodeySynth m3;
RhodeySynth m4;
   
    fun void play(float Beat, int percentage, int type, int Notes[])
   {
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


          
          
   
   
          
   
  if (Notes[i]/1000==1)// Grip Modes
  {  
  
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
    if (ModeType==4)// in order US 6/5 Grip, Ionian is Offset +1
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
spork~m1.play(Beat,percentage,type,finalNotes1);
spork~m2.play(Beat,percentage,type,finalNotes2);
spork~m3.play(Beat,percentage,type,finalNotes3);
m4.play(Beat,percentage,type,finalNotes4);


}
}
}


