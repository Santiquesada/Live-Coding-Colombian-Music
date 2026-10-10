// ChAR-jazz.ck — Jazz solo con ChAR en 4/4
// Genera UNA frase de BEATS beats y la repite en loop

me.dir() + "../onnx/char_a.onnx" => string pathA;
me.dir() + "../onnx/char_b.onnx" => string pathB;

// === PARAMETROS ===
150  => float BPM;
8    => int   BEATS;      // beats de la frase (= longitud del loop)
1.5  => float TA;         // temperatura pitch
3.0  => float TB;         // temperatura duracion
30   => int   TOPK;
"Dm7,G7,Cmaj7,Am7" => string PROG;
2    => int   SWING_TYPE; // 0=recto 1=binario 2=ternario
30   => int   SWING_PCT;
4    => int   METER;
// ==================

(60.0 / BPM) => float beatSec;

[0.25,0.25,0.25,0.5,0.5,0.75,1.0,1.0,1.5,1.5,2.0,2.5,3.0,3.0,4.0,4.0,6.0,8.0]
    @=> float DUR[];

// --- Sintesis ---
FrencHrn mel => NRev rev => dac;
0.05 => rev.mix;
0.35 => mel.gain;

// --- Percusion ---
me.dir() + "../Samples/JazzRide.wav" => string ridePath;
SndBuf ride => Gain rideGain => dac;
ridePath => ride.read;
ride.samples() => ride.pos;
0.9 => rideGain.gain;

me.dir() + "../Samples/Kick.wav" => string kickPath;
SndBuf kick => Gain kickGain => dac;
kickPath => kick.read;
kick.samples() => kick.pos;
0.35 => kickGain.gain;

fun void rideLoop() {
    0 => int beat;
    while (true) {
        if (beat % METER == 0) 0 => kick.pos;
        0 => ride.pos;
        beat + 1 => beat;
        beatSec::second => now;
    }
}
spork ~ rideLoop();

// --- Swing ---
fun float swingTime(float t_beats) {
    if (SWING_TYPE == 0) return t_beats * beatSec;
    Math.floor(t_beats) => float bn;
    t_beats - bn => float frac;
    SWING_PCT * 0.01 => float p;
    float sf;
    if (SWING_TYPE == 1) {
        if (frac < 0.5) frac * (1.0 + p) => sf;
        else            0.5*(1.0+p) + (frac-0.5)*(1.0-p) => sf;
    } else {
        if (frac < 2.0/3.0) frac * (1.0 + p) => sf;
        else                 (2.0/3.0)*(1.0+p) + (frac-2.0/3.0)*(1.0-2.0*p) => sf;
    }
    return (bn + sf) * beatSec;
}

// --- Generar frase UNA sola vez ---
ChAR jazz;
jazz.load(pathA, pathB);
jazz.set_top_k(TOPK);
jazz.set_meter(METER);
jazz.clear();
jazz.set_progression(PROG);
jazz.generate(BEATS, TA, TB);
jazz.num_tokens() => int N;

int PITCH[N];
int BIN[N];
for (0 => int i; i < N; i++) {
    jazz.get_stream(0, i) => PITCH[i];
    jazz.get_stream(1, i) => BIN[i];
}

<<< "=== ChAR jazz ===" >>>;
<<< "BPM:", BPM, "| BEATS:", BEATS, "| notas:", N >>>;

// === Loop de reproduccion ===
BEATS * beatSec => float limit;

fun void playPhrase() {
    0.0 => float eb;
    for (0 => int i; i < N; i++) {
        swingTime(eb) => float t_start;
        if (t_start >= limit) break;

        PITCH[i] => int pitch;
        BIN[i]   => int bin;

        0.5 => float dur_b;
        if (bin >= 0 && bin < DUR.size()) DUR[bin] => dur_b;

        swingTime(eb + dur_b) - t_start => float dur_s;
        if (t_start + dur_s > limit) limit - t_start => dur_s;
        if (dur_s <= 0.001) { eb + dur_b => eb; continue; }

        // Acentos: beats 2 y 4 (jazz backbeat)
        eb % 4.0 => float pos;
        float vel;
        if ((pos >= 1.0 && pos < 2.0) || (pos >= 3.0 && pos < 4.0))
            Math.random2f(0.65, 0.95) => vel;
        else
            Math.random2f(0.3, 0.6) => vel;

        if (pitch > 0) {
            Std.mtof(pitch) => mel.freq;
            vel => mel.noteOn;
        }
        (dur_s * 0.85)::second => now;
        if (pitch > 0) 0.5 => mel.noteOff;
        (dur_s * 0.15)::second => now;

        eb + dur_b => eb;
    }
    swingTime(eb) => float t_end;
    if (t_end < limit) (limit - t_end)::second => now;
}

while (true) { playPhrase(); }
