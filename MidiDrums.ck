



public class SenDrummer extends Chugraph
{
    
   
    MidiIn midi;
     MidiIn midi2;
    MidiMsg msg;
       MidiMsg msg2;
    0=>int device;
    if(me.args())me.arg(0)=>Std.atoi=>device;
    if(!midi.open(device))me.exit();
    if(!midi2.open(device))me.exit();
    
   Shakers shake => JCRev r => outlet;
   .025 => r.mix;
    SndBuf Sample=>Dyno d=>outlet;
    SndBuf Sample2=>d=>outlet;
    string filename;
   50=>int defaultgain;
    50=> int previousgain;
    float GrandBeat;
    50=> int currentgain;
   string filename2;

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
        
        
        if(msg.data1==176 && msg.data2==20)
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
             
           
             percentage+(Math.random2(-4,4))=>int percent;
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes, GrandBeat,percent,type)@=>float finalBeats[];
    
      
      
           for(0=>int i;i<finalNotes.size();i++)
      {
                     
          
         finalNotes[i]%100=> int MyNote;
        
       currentgain*0.014*finalNotes[i]/50=> float MyGain;
      
          if (finalNotes[i]>0)
          {
              if (MyNote==0)
              {
           me.dir() + "/Samples/Kick.wav" =>  filename;
           0.1*MyGain* Math.random2f(0.1,0.2)=>Sample.gain;
              }
                if (MyNote==01)
              {
           me.dir() + "/Samples/JazzRide.wav" =>  filename;
              }
                  if (MyNote==02)
             {
                 
           me.dir() + "/Samples/JazzRide.wav" =>  filename;
                    0.3*MyGain*Math.random2f(0.2,0.3)=>Sample.gain;
                 
          }
               if (MyNote==03)
              {
                  if(Math.random2(1,5)>3)
                  {
           me.dir() + "/Samples/Snare_SP3.wav" =>  filename;
                   0.1*MyGain*  Math.random2f(0.1,0.11)=>Sample.gain;
                  }
                      else
                      {
                 if(Math.random2(1,6)>4)
                  {
           me.dir() + "/Samples/Cross.wav" =>  filename;
                    0.5*MyGain* Math.random2f(0.1,0.11)=>Sample.gain;
                  }
                  else
                       me.dir() + "/Samples/LowTom.wav" =>  filename;
                   0.1*MyGain*  Math.random2f(0.1,0.11)=>Sample.gain;
              }
              }
                if (MyNote==04)
              {
           me.dir() + "/Samples/Crash1.wav" =>  filename;
          0.1*MyGain*  Math.random2f(0.5,0.51)=>Sample.gain;
              }
                if (MyNote==05)
              {
           me.dir() + "/Samples/Stack.wav" =>  filename;
              }
                 if (MyNote==006)
              {
           me.dir() + "/Samples/Open.wav" =>  filename;
              }
                 if (MyNote==07)
              {
           me.dir() + "/Samples/Slap.wav" =>  filename;
              }
                 if (MyNote==08)
              {
           me.dir() + "/Samples/BomboAbierto.wav" =>  filename;
              0.1*MyGain*     Math.random2f(0.1,0.2)=>Sample.gain;      
           
                  }
                 if (MyNote==009)
              {
           me.dir() + "/Samples/BomboMadera.wav" =>  filename;
            0.1*MyGain*  Math.random2f(0.2,0.21)=>Sample.gain;      
                                   }
                if (MyNote==010)
              {
                   
           me.dir() + "/Samples/BomboMadera.wav" =>  filename;
             me.dir() + "/Samples/BomboAbierto.wav" =>  filename2; 
                    0.1*MyGain*Math.random2f(0.05,0.06)=>Sample.gain;      
                   0.1*MyGain* Math.random2f(0.1,0.11)=>Sample2.gain;      
                  filename2=>  Sample2.read;
        0=>Sample2.pos;
    
              1=>Sample2.rate;
              }

                 if (MyNote==99)
              {
           1 => shake.which;
        Std.mtof( Math.random2f( 10,11 ) ) => shake.freq;
           Math.random2f( 100,101 ) => shake.objects;
             0.1*MyGain*Math.random2f( 0.79, 0.8 ) => shake.noteOn; 
             Math.random2f(0.95,0.96) => shake.decay;     
                  
              }
                 if (MyNote==11)
              {
           me.dir() + "/Samples/CununoAbierto.wav" =>  filename;
                0.1*MyGain*0.15=>Sample.gain;
                  
                  }
               if (MyNote==012)
              {
           me.dir() + "/Samples/CununoQuemao.wav" =>  filename;
              0.1*MyGain*       Math.random2f(0.07,0.071)=>Sample.gain;

                  }
               if (MyNote==013)
              {
           me.dir() + "/Samples/Flam.wav" =>  filename;

  0.1*MyGain*Math.random2f(0.12,0.13)=>Sample.gain;

              }
                if (MyNote==014)
              {
           me.dir() + "/Samples/TamboraOpen.wav" =>  filename;

 0.1*MyGain*Math.random2f(0.1,0.12)=>Sample.gain;

              }
                  if (MyNote==015)
              {
           me.dir() + "/Samples/TamboraShell.wav" =>  filename;

 0.1*MyGain*Math.random2f(0.05,0.07)=>Sample.gain;

              }
                    if (MyNote==16)
              {
           me.dir() + "/Samples/LLamadorOpen.wav" =>  filename;

  0.1*MyGain*Math.random2f(0.2,0.211)=>Sample.gain;

              }
               if (MyNote==17)
              {
           me.dir() + "/Samples/AlegreOpen.wav" =>  filename;

  0.1*MyGain*Math.random2f(0.1,0.12)=>Sample.gain;

              }
               if (MyNote==18)
              {
           me.dir() + "/Samples/AlegreSlap.wav" =>  filename;

  0.1*MyGain*Math.random2f(0.1,0.12)=>Sample.gain;

              }

      if (MyNote!=99)
              {
          
        0=>Sample.pos;
        
       
             
              1=>Sample.rate;
                  filename=>Sample.read;
                         
                  }
              
               finalBeats[i]::second=>now;

          }
          else
          { 
              
          finalBeats[i]::second=>now;
          }
            

      }
  }
        
    }
}