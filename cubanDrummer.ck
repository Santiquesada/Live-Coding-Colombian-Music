public class cubanDrummer
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
      
            for (0 => int i; i < finalNotes.size(); i++)
            {
                finalNotes[i] % 100 => int MyNote; 
                0.8 * finalNotes[i] / 200 => float MyGain;
          
                if (finalNotes[i] > 0)
                {
                    // --- Afrekete & ChaCha ---
                    if (MyNote == 0) { me.dir() + "/Samples/Cuban/TCP_Afrekete_Bell_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain; }
                    if (MyNote == 1) { me.dir() + "/Samples/Cuban/TCP_Afrekete_Bell_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain; }
                    if (MyNote == 2) { me.dir() + "/Samples/Cuban/TCP_Afrekete_Lo_Drum_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain; }
                    if (MyNote == 3) { me.dir() + "/Samples/Cuban/TCP_Afrekete_Solo_Drum_1.wav" => filename; 0.1 * MyGain * 0.1 => Sample.gain; }
                    if (MyNote == 4) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Itotele_1.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 5) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Itotele_2.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 6) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Iya_1.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 7) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Iya_2.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 8) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Iya_3.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 9) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Okonkolo_1.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    if (MyNote == 10) { me.dir() + "/Samples/Cuban/TCP_ChaCha_Okonkolo_2.wav" => filename; 0.1 * MyGain => Sample.gain; }
                    
                    // --- Batá Osain & Yesa ---
                    if (MyNote == 20) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Iya_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 21) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Iya_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 22) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Iya_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 23) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Iya_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 24) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Itotele_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 25) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Itotele_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 26) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Itotele_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 27) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Okonkolo_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 28) { me.dir() + "/Samples/Cuban/TCP_Osain_Bata_Okonkolo_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 29) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Iya_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 30) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Itotele_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 31) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Itotele_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 32) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Itotele_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 33) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Itotele_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 34) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Okonkolo_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 35) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Okonkolo_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 36) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Okonkolo_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 37) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Caja_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 38) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Caja_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 39) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Caja_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    
                    // --- Conga, Columbia & Guaguanco ---
                    if (MyNote == 40) { me.dir() + "/Samples/Cuban/TCP_Conga_Hi_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 41) { me.dir() + "/Samples/Cuban/TCP_Conga_Snare_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 42) { me.dir() + "/Samples/Cuban/TCP_Conga_Snare_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 43) { me.dir() + "/Samples/Cuban/TCP_Conga_Snare_6.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 44) { me.dir() + "/Samples/Cuban/TCP_Columbia_Conga_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 45) { me.dir() + "/Samples/Cuban/TCP_Columbia_Conga_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 46) { me.dir() + "/Samples/Cuban/TCP_Columbia_Tumba_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 47) { me.dir() + "/Samples/Cuban/TCP_Columbia_Tumba_5.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 48) { me.dir() + "/Samples/Cuban/TCP_Guaguanco_Clave.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 49) { me.dir() + "/Samples/Cuban/TCP_Guaguanco_Quinto_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 50) { me.dir() + "/Samples/Cuban/TCP_Guaguanco_Tumba_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    
                    // --- Makuta, Guiro, Yuka, Palo, Yesa Drums ---
                    if (MyNote == 60) { me.dir() + "/Samples/Cuban/TCP_Makuta_Bell.wav" => filename;0.1 * MyGain * 0.5 => Sample.gain; }
                    if (MyNote == 61) { me.dir() + "/Samples/Cuban/TCP_Makuta_Cachimbo_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 62) { me.dir() + "/Samples/Cuban/TCP_Makuta_Caja_Mid_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 63) { me.dir() + "/Samples/Cuban/TCP_Makuta_Caja_Mid_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 64) { me.dir() + "/Samples/Cuban/TCP_Makuta_Mula_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 65) { me.dir() + "/Samples/Cuban/TCP_Guiro_Drum_Bell_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 66) { me.dir() + "/Samples/Cuban/TCP_Guiro_Hi_Drum_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 67) { me.dir() + "/Samples/Cuban/TCP_Guiro_Hi_Drum_6.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 68) { me.dir() + "/Samples/Cuban/TCP_Guiro_Lo_Drum_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 69) { me.dir() + "/Samples/Cuban/TCP_Guiro_Lo_Drum_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 70) { me.dir() + "/Samples/Cuban/TCP_Guiro_Mid_Drum_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 71) { me.dir() + "/Samples/Cuban/TCP_Palo_Hi_Drum_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 72) { me.dir() + "/Samples/Cuban/TCP_Palo_Lo_Drum_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 73) { me.dir() + "/Samples/Cuban/TCP_Palo_Mid_Drum_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 74) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bass_Drum_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 75) { me.dir() + "/Samples/Cuban/TCP_Yesa_Hi_Drum.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 76) { me.dir() + "/Samples/Cuban/TCP_Yesa_Lo_Bell_1.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 77) { me.dir() + "/Samples/Cuban/TCP_Yesa_Mid_Drum.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 78) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Maraca_2.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 79) { me.dir() + "/Samples/Cuban/TCP_Yesa_Bata_Maraca_3.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}
                    if (MyNote == 80) { me.dir() + "/Samples/Cuban/TCP_Yuka_Cata_4.wav" => filename; 0.1 * MyGain * 0.5 => Sample.gain;}

                    // Trigger Logic
                    if (MyNote != 99)
                    {
                        0 => Sample.pos;
                        1 => Sample.rate;
                        filename => Sample.read;
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