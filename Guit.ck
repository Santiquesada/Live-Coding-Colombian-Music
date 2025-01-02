public class Guitar extends Chugraph
    
{

HnkyTonk g; 
HnkyTonk guit[1];
NRev r => Delay d=> dac;  
    500::samp => d.delay;
0.15 => r.gain; 0.05 => r.mix;


[97,71,77,81] @=> int opGains[];
[1.0,3.0,3.02,8.0] @=> float ratios[];
[31,28,31,31] @=> int attacks[];
[18,6,10,9] @=> int decays[];
[15,0,0,0] @=> int sustains[]; // 15,0,0,0 ???
[8,8,9,6] @=> int releases[];

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

fun void keyOn( int Note, float Beat,int gain) {
   
        Std.mtof(Note) => guit[0].freq;
         Math.random2f(0.07,0.08)*gain/80=>guit[0].noteOn;
         Beat::second=>now;
         allOff();
       
}

fun void play(float Beat, int percentage, int type, int Notes[])
   {
    
     while(true)
     {
         percentage+(Math.random2(-8,8))=>int percento;
       
           Phrasing s;
       s.absNotes(Notes)@=>int finalNotes[];
       s.definingBeat(Notes,Beat,percento,type)@=>float finalBeats[];
       
       for(0=>int i;i< finalNotes.size();i++)
    {
   
        if (finalNotes[i]>0)
        {
        keyOn(finalNotes[i]%100,finalBeats[i],finalNotes[i]);
       
        }
            else
            {
            1=>guit[0].noteOff;
            finalBeats[i]::second=>now;
            }
    }
}
}

   }





