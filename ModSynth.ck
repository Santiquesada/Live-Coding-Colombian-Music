class ModSynth extends Chugraph
{
//LPF es un LowPassFIlter(o filtro pasabajos)
//NRev le agrega reverberación
    
 SawOsc osc=>ADSR env1=>LPF lpf=>NRev rev=>dac;
//500 Hz será la frecuencia de nuestro filtro
500=>lpf.freq;
//También podemos editar la calidad Q del filtro
5=>lpf.Q;
// el valor de reverberación    
0.02=>rev.mix;


        
    // Dentro de nuestro sintetizador crearemos una función que nos permita tocar una nota
    //Recibirémos un valor MIDI de nota y un valor decimal para saber por cuanto tiempo tocar.
    fun void keyOn(int key,float Beat)
    {
//concetaremos una onda diente de sierra a un ADSR y a un filtro
      
      //le damos un poco de aleatoriedad a la ganancia  
      Math.random2f(0.05,0.07)=>osc.gain;
       //editamos los parametros de Attack, Decay, Sustain y Release, el sustain será el 80 por ciento de la duración de nuestro sonido 
       (10::ms, Beat::second,0.0, 1::ms) =>env1.set;
       //convertimos el valor MIDI a Hertz
       key=>Std.mtof=>osc.freq;
       1=>env1.keyOn;
      Beat::second=>now;
       
      //Le damos aleatoriedad al filtro pasabajos para que el sonido del sintetiazador cambie con el tiempo  
      Math.random2f(0.2,0.5)*4000=>lpf.freq; 
     
    }
}
public class RonModes
{
ModSynth m1;
ModSynth m2;
ModSynth m3;
ModSynth m4;
ModSynth m5;
ModSynth m6;    
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
      
 spork~m1.keyOn(Offset+7,finalBeats[i]);
 spork~m2.keyOn(Offset,finalBeats[i]);
 m3.keyOn(Offset+2,finalBeats[i]);
  
 
     

 
  }
   if (ModeType==2)// Dorian "So what" offset is +2
  { 
      <<<"Dorian">>>;
      <<<Offset+2>>>;
 
 spork~m1.keyOn(Offset-12,finalBeats[i]);
 spork~m2.keyOn(Offset-7,finalBeats[i]);
 spork~ m3.keyOn(Offset-2,finalBeats[i]);
 m4.keyOn(Offset+3,finalBeats[i]);     
  }
   if (ModeType==3)// Sus2(Mixolidian Offset+2) Lydian Offset-4 Phrygian Offset-1
  { 
      <<<"5/6">>>;
       <<<Offset+2>>>;
      
 spork~m1.keyOn(Offset,finalBeats[i]);
 spork~m2.keyOn(Offset+4,finalBeats[i]);
 spork~ m3.keyOn(Offset+6,finalBeats[i]);
 m4.keyOn(Offset+11,finalBeats[i]);
 
     

 
  }
    if (ModeType==4)// in order US 6/5 Grip, Ionian is Offset +1
  { 
      <<<"6/5 Grip">>>;
      <<<Offset>>>;
 spork~m1.keyOn(Offset,finalBeats[i]);
 spork~m2.keyOn(Offset+3,finalBeats[i]);
 spork~m3.keyOn(Offset+5,finalBeats[i]);
 m4.keyOn(Offset-6,finalBeats[i]);     

  }
  if (ModeType==5)// Phrygian US, phrygian is Offset
  { 
      <<<"Phrygian US">>>;
      <<<Offset>>>;


  spork~m1.keyOn(Offset,finalBeats[i]);
 spork~m2.keyOn(Offset+1,finalBeats[i]);
 spork~m3.keyOn(Offset+5,finalBeats[i]);
 m4.keyOn(Offset+7,finalBeats[i]); 
  }
   if (ModeType==6)// Melodic Minor Grip, Offset-3 is Melodic Minor
  { 
      <<<"Melodic Minor Grip">>>;
      <<<Offset>>>;
 
   spork~m1.keyOn(Offset,finalBeats[i]);
 spork~m2.keyOn(Offset+4,finalBeats[i]);
 spork~m3.keyOn(Offset+8,finalBeats[i]);
 m4.keyOn(Offset+11,finalBeats[i]);

 
  }
 
}
if (finalNotes[i]==0)
  {
        finalBeats[i]::second=>now;
 
  }

   
}

}
}
}


