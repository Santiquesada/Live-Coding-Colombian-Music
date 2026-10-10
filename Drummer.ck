public class genDrummer
{
    Shakers shake => JCRev r => dac;
    .025 => r.mix;
    SndBuf Sample => Dyno d => dac;
    SndBuf Sample2 => d => dac;
    string filename;
    string filename2;

    fun void reading(SndBuf sample, string filename)
    {
        filename => sample.read;   
    }   
    
    fun void play(float Beat, int percentage, int type, int Notes[])
    {
        while(true)
        {
            percentage + (Math.random2(-4, 4)) => int percent;
            Phrasing s;
            s.absNotes(Notes) @=> int finalNotes[];
            s.definingBeat(Notes, Beat, percent, type) @=> float finalBeats[];
      
            for(0 => int i; i < finalNotes.size(); i++)
            {
                finalNotes[i] % 100 => int MyNote; 
                0.2 * finalNotes[i] / 10 => float MyGain;
          
                if (finalNotes[i] > 0)
                {
                    // --- Original percussion kit and triggers ---
                    if (MyNote == 0) { me.dir() + "/Samples/Kick.wav" => filename; 0.1 * MyGain * Math.random2f(0.05, 0.06) => Sample.gain; }
                    if (MyNote == 01) { me.dir() + "/Samples/JazzRide.wav" => filename; }
                    if (MyNote == 02) { me.dir() + "/Samples/JazzRide.wav" => filename; 0.25 * MyGain * Math.random2f(0.03, 0.04) => Sample.gain; }
                    
                    if (MyNote == 03) { 
                        if(Math.random2(1, 5) > 3) { me.dir() + "/Samples/Snare_SP3.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.11) => Sample.gain; }
                        else if(Math.random2(1, 6) > 4) { me.dir() + "/Samples/Cross.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.11) => Sample.gain; }
                        else { me.dir() + "/Samples/LowTom.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.11) => Sample.gain; }
                    }
                    
                    if (MyNote == 04) { me.dir() + "/Samples/Crash1.wav" => filename; 0.1 * MyGain * Math.random2f(0.5, 0.51) => Sample.gain; }
                    if (MyNote == 05) { me.dir() + "/Samples/Stack.wav" => filename; }
                    if (MyNote == 006) { me.dir() + "/Samples/Open.wav" => filename; }
                    if (MyNote == 07) { me.dir() + "/Samples/Slap.wav" => filename; }
                    if (MyNote == 08) { me.dir() + "/Samples/BomboAbierto.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.2) => Sample.gain; }
                    if (MyNote == 009) { me.dir() + "/Samples/BomboMadera.wav" => filename; 0.1 * MyGain * Math.random2f(0.2, 0.21) => Sample.gain; }
                    
                    if (MyNote == 010) { 
                        me.dir() + "/Samples/BomboMadera.wav" => filename; 
                        me.dir() + "/Samples/BomboAbierto.wav" => filename2; 
                        0.1 * MyGain * Math.random2f(0.05, 0.06) => Sample.gain; 
                        0.1 * MyGain * Math.random2f(0.1, 0.11) => Sample2.gain;
                        filename2 => Sample2.read; 0 => Sample2.pos; 1 => Sample2.rate;
                    }

                    if (MyNote == 99) { 
                        1 => shake.which; 
                        Std.mtof(Math.random2f(10, 11)) => shake.freq;
                        Math.random2f(100, 101) => shake.objects; 
                        0.1 * MyGain * Math.random2f(0.79, 0.8) => shake.noteOn; 
                        Math.random2f(0.95, 0.96) => shake.decay;
                    }
                    
                    if (MyNote == 11) { me.dir() + "/Samples/CununoAbierto.wav" => filename; 0.1 * MyGain * 0.15 => Sample.gain; }
                    if (MyNote == 012) { me.dir() + "/Samples/CununoQuemao.wav" => filename; 0.1 * MyGain * Math.random2f(0.07, 0.071) => Sample.gain; }
                    if (MyNote == 013) { me.dir() + "/Samples/Flam.wav" => filename; 0.1 * MyGain * Math.random2f(0.12, 0.13) => Sample.gain; }
                    if (MyNote == 014) { me.dir() + "/Samples/TamboraOpen.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.12) => Sample.gain; }
                    if (MyNote == 015) { me.dir() + "/Samples/TamboraShell.wav" => filename; 0.1 * MyGain * Math.random2f(0.05, 0.07) => Sample.gain; }
                    if (MyNote == 16) { me.dir() + "/Samples/LLamadorOpen.wav" => filename; 0.1 * MyGain * Math.random2f(0.2, 0.211) => Sample.gain; }
                    if (MyNote == 17) { me.dir() + "/Samples/AlegreOpen.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.12) => Sample.gain; }
                    if (MyNote == 18) { me.dir() + "/Samples/AlegreSlap.wav" => filename; 0.1 * MyGain * Math.random2f(0.1, 0.12) => Sample.gain; }

                    // --- Trigger Logic ---
                    if (MyNote != 99)
                    {
                        0 => Sample.pos;
                        1 => Sample.rate;
                        filename => Sample.read;
                        Sample.samples() / 44100.0 => float tiempo;
                    }

                    finalBeats[i]::second => now;
                }
                else 
                {
                    finalBeats[i]::second => now; 
                }
            }
        }
    }
}