public class ChARMel
{
   
    FrencHrn mel => NRev rev => dac;
    0.06 => rev.mix;
    0.3 => mel.gain;

    // --- ChAR ---
    ChAR _jazz;
    _jazz.load(me.dir() + "onnx/char_a.onnx", me.dir() + "onnx/char_b.onnx");
    _jazz.set_top_k(20);
    _jazz.set_meter(4);

    // Quarters bins MINGUS)
    [0.25,0.25,0.25,0.5,0.5,0.75,1.0,1.0,1.5,1.5,2.0,2.5,3.0,3.0,4.0,4.0,6.0,8.0]
        @=> float DUR[];

    fun void setProgresion(string prog)
    {
        _jazz.clear();
        _jazz.set_progression(prog);
    }

    fun float _swing(float t, float beatSec, int type, float p)
    {
        if (type == 0) return t * beatSec;
        Math.floor(t) => float bn;
        t - bn => float frac;
        float sf;
        if (type == 1) {
            if (frac < 0.5) frac * (1.0 + p) => sf;
            else            0.5*(1.0+p) + (frac-0.5)*(1.0-p) => sf;
        } else {
            if (frac < 2.0/3.0) frac * (1.0 + p) => sf;
            else                 (2.0/3.0)*(1.0+p) + (frac-2.0/3.0)*(1.0-2.0*p) => sf;
        }
        return (bn + sf) * beatSec;
    }

    fun void play(float Beat, int swingPct, int swingType, int beats)
    {
        0.2 => float TA;
       4  => float TB;
        swingPct * 0.01 => float SWING_P;

        // Generar frase una sola vez
        _jazz.generate(beats, TA, TB);
        _jazz.num_tokens() => int N;

        int PITCH[N];
        int BIN[N];
        for (0 => int i; i < N; i++) {
            _jazz.get_stream(0, i) => PITCH[i];
            _jazz.get_stream(1, i) => BIN[i];
        }

        beats * Beat => float limit;

        // Loop de reproduccion
        while (true) {
            0.0 => float eb;
            for (0 => int i; i < N; i++) {
                _swing(eb, Beat, swingType, SWING_P) => float t_start;
                if (t_start >= limit) break;

                PITCH[i] => int pitch;
                BIN[i]   => int bin;

                0.5 => float dur_b;
                if (bin >= 0 && bin < DUR.size()) DUR[bin] => dur_b;

                _swing(eb + dur_b, Beat, swingType, SWING_P) - t_start => float dur_s;
                if (t_start + dur_s > limit) limit - t_start => dur_s;
                if (dur_s <= 0.001) { eb + dur_b => eb; continue; }

                // Acents: beats 2  4 (jazz backbeat)
                eb % 4.0 => float pos;
                float vel;
                if ((pos >= 1.0 && pos < 2.0) || (pos >= 3.0 && pos < 4.0))
                    Math.random2f(0.65, 0.95) => vel;
                else
                    Math.random2f(0.3, 0.6) => vel;

                if (pitch > 0) {
                    Std.mtof(pitch) => mel.freq;
                    vel*0.6 => mel.noteOn;                }
                (dur_s * 0.85)::second => now;
                if (pitch > 0) 0.5 => mel.noteOff;
                (dur_s * 0.15)::second => now;

                eb + dur_b => eb;
            }
            _swing(eb, Beat, swingType, SWING_P) => float t_end;
            if (t_end < limit) (limit - t_end)::second => now;
        }
    }
}
