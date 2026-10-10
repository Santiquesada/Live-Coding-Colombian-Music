public class ChARMar
{
    // --- Audio chain ---
    me.dir() + "/Samples/MarimbaenDO.wav" => string filename;
    SndBuf mar => dac;
    

    // Load sample once, disable loop, park at end (silent)
    filename => mar.read;
    0 => mar.loop;
    mar.samples() - 1 => mar.pos;

    // --- ChAR models ---
    ChAR _jazz;
    _jazz.load(me.dir() + "onnx/char_a.onnx", me.dir() + "onnx/char_b.onnx");
    _jazz.set_top_k(20);
    _jazz.set_meter(4);

    // Duration bins from MINGUS (in beats)
    [0.25,0.25,0.25,0.5,0.5,0.75,1.0,1.0,1.5,1.5,2.0,2.5,3.0,3.0,4.0,4.0,6.0,8.0]
        @=> float DUR[];

    // Max sound duration for marimba (beats).
    // eb still advances with the real ChAR duration to keep sync —
    // only the audible hit is capped here.
    1.5 => float MAX_SOUND_BEATS;

    // Minimum interval between sample triggers (in ChucK time).
    // Prevents machine-gun effect when ChAR generates rapid short notes.
    // Set to ~1 beat worth of time; updated when play() starts.
    now => time _lastHit;
    0.17::second => dur _minHit;  // default, overridden by Beat in play()

    // --- Transpose sample rate by semitones ---
    // Uses equal temperament: each semitone = 12th root of 2
    fun float transpose(int semitones)
    {
        1.05946309435929 => float semitone;
        1.0 => float result;
        if (semitones > 0)
            for (0 => int i; i < semitones; i++)
                result * semitone => result;
        if (semitones < 0)
            for (0 => int i; i > semitones; i--)
                result * (1.0 / semitone) => result;
        return result;
    }

    // --- Set chord progression ---
    fun void setProgresion(string prog)
    {
        _jazz.clear();
        _jazz.set_progression(prog);
    }

    // --- Swing timing ---
    // t      : beat position (float, e.g. 2.5 = beat 2, halfway)
    // beatSec: seconds per beat
    // type   : 0 = straight, 1 = binary swing, 2 = triplet swing
    // p      : swing amount (0.0 = none, 0.5 = heavy)
    fun float _swing(float t, float beatSec, int type, float p)
    {
        if (type == 0) return t * beatSec;

        Math.floor(t) => float bn;    // integer beat number
        t - bn => float frac;         // fractional position within the beat
        float sf;

        if (type == 1) {
            // Binary swing: stretch first half, compress second half
            if (frac < 0.5) frac * (1.0 + p) => sf;
            else             0.5*(1.0+p) + (frac-0.5)*(1.0-p) => sf;
        } else {
            // Triplet swing: stretch first 2/3, compress last 1/3
            if (frac < 2.0/3.0) frac * (1.0 + p) => sf;
            else                 (2.0/3.0)*(1.0+p) + (frac-2.0/3.0)*(1.0-2.0*p) => sf;
        }

        return (bn + sf) * beatSec;
    }

    // --- Main play loop ---
    // Beat     : seconds per beat
    // swingPct : swing percentage (0-100)
    // swingType: 0=straight, 1=binary, 2=triplet
    // beats    : phrase length in beats
    fun void play(float Beat, int swingPct, int swingType, int beats)
    {
        0.2 => float TA;               // pitch temperature
        4 => float TB;               // duration temperature
        swingPct * 0.01 => float SWING_P;

        // Set minimum retrigger interval to 1 beat at this tempo
        Beat::second => _minHit;
        now => _lastHit;

        // Generate phrase once
        _jazz.generate(beats, TA, TB);
        _jazz.num_tokens() => int N;

        int PITCH[N];
        int BIN[N];
        for (0 => int i; i < N; i++) {
            _jazz.get_stream(0, i) => PITCH[i];
            _jazz.get_stream(1, i) => BIN[i];
        }

        beats * Beat => float limit;

        // Loop the phrase indefinitely
        while (true) {
            0.0 => float eb;

            for (0 => int i; i < N; i++) {
                _swing(eb, Beat, swingType, SWING_P) => float t_start;
                if (t_start >= limit) break;

                PITCH[i] => int pitch;
                BIN[i]   => int bin;

                // ChAR duration (beats) — used for eb accumulation and timing
                0.5 => float dur_b;
                if (bin >= 0 && bin < DUR.size()) DUR[bin] => dur_b;

                // Total note duration in seconds (swing-adjusted)
                _swing(eb + dur_b, Beat, swingType, SWING_P) - t_start => float dur_s;
                if (t_start + dur_s > limit) limit - t_start => dur_s;
                if (dur_s <= 0.001) { eb + dur_b => eb; continue; }

                // Jazz backbeat accents: beats 2 and 4 are louder
                eb % 4.0 => float pos;
                float vel;
                if ((pos >= 1.0 && pos < 2.0) || (pos >= 3.0 && pos < 4.0))
                    Math.random2f(0.65, 0.95) => vel;
                else
                    Math.random2f(0.3, 0.6) => vel;

                // Trigger sample only if enough time has passed since last hit.
                // _minHit (= 1 beat) prevents machine-gun bursts from rapid short ChAR notes.
                // Sample decays naturally — no manual cutoff needed.
                if (pitch > 0 && (now - _lastHit) >= _minHit/2) {
                    transpose(pitch - 60) => mar.rate;
                    0 => mar.pos;
                    0 => mar.loop;
                    vel => mar.gain;
                    now => _lastHit;
                }

                dur_s::second => now;

                eb + dur_b => eb;
            }

            // Wait for any remaining time to fill the phrase
            _swing(eb, Beat, swingType, SWING_P) => float t_end;
            if (t_end < limit) (limit - t_end)::second => now;
        }
    }
}