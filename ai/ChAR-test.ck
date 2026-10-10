// ChAR-test.ck — Jazz solo con HnkyTonk + JazzRide
// Edita los parametros aqui abajo y reinicia el shred para cambiarlos

me.dir() + "../onnx/char_a.onnx" => string pathA;
me.dir() + "../onnx/char_b.onnx" => string pathB;

// === PARAMETROS ===
150 => float BPM;
6 => int   BEATS;
1.1  => float TA;
1.6 => float TB;
10   => int   TOPK;
"G7,Cmaj7" => string PROG;
2     => int   SWING_TYPE;  // 0=recto, 1=binario(swing), 2=ternario
33    => int   SWING_PCT;   // porcentaje de desviacion (0-50)
3     => int   METER;        // beats por compas (4=4/4, 3=3/4, 5=5/4, etc.)
// ==================

(60.0 / BPM) => float beatSec;

[0.25,0.25,0.25,0.5,0.5,0.75,1.0,1.0,1.5,1.5,2.0,2.5,3.0,3.0,4.0,4.0,6.0,8.0]
    @=> float DUR[];

// --- Sintesis melodia ---
FrencHrn piano => NRev rev => dac;
0.05 => rev.mix;
0.3  => piano.gain;
//7.0  => piano.lfoSpeed;
//0.03 => piano.lfoDepth;


me.dir() + "../Samples/BomboAbierto.wav" => string ridePath;
SndBuf ride => Gain rideGain => dac;
ridePath => ride.read;
0.9 => rideGain.gain;
ride.samples() => ride.pos;

// --- Kick: beat 1 de cada compas ---
me.dir() + "../Samples/BomboMadera.wav" => string kickPath;
SndBuf kick => Gain kickGain => dac;
kickPath => kick.read;
0.3 => kickGain.gain;
kick.samples() => kick.pos;

fun void rideLoop() {
    0 => int beat;
    while (true) {
        if (beat % 3 == 0) 0 => kick.pos;   // beat 1 de cada compas
        0 => ride.pos;
        beat + 1 => beat;
        beatSec :: second => now;
    }
}
spork ~ rideLoop();

// --- Modelo ---
ChAR jazz;
jazz.load(pathA, pathB);
jazz.set_top_k(TOPK);
jazz.set_meter(METER);
jazz.clear();
jazz.set_progression(PROG);
jazz.generate(BEATS, TA, TB);
jazz.num_tokens() => int N;

// --- Guardar frase en arreglos ---
int PITCH[N];
int BIN[N];
for (0 => int i; i < N; i++) {
    jazz.get_stream(0, i) => PITCH[i];
    jazz.get_stream(1, i) => BIN[i];
}

// --- Imprimir para guardar si te gusta ---
"[" => string pitchStr;
"[" => string binStr;
for (0 => int i; i < N; i++) {
    pitchStr + Std.itoa(PITCH[i]) => pitchStr;
    binStr   + Std.itoa(BIN[i])   => binStr;
    if (i < N-1) {
        pitchStr + "," => pitchStr;
        binStr   + "," => binStr;
    }
}
<<< pitchStr + "] @=> int PITCH[];" >>>;
<<< binStr   + "] @=> int BIN[];" >>>;
<<< "Frase:", N, "notas" >>>;

// --- Mapa de swing: convierte posicion en beats rectos a segundos reales ---
// Cada beat se divide en 2 mitades; la primera se expande, la segunda se contrae.
// Una nota que cruce la mitad del beat se calcula correctamente.
fun float swingTime(float t_beats) {
    if (SWING_TYPE == 0) return t_beats * beatSec;
    Math.floor(t_beats) => float bn;
    t_beats - bn => float frac;
    SWING_PCT * 0.01 => float p;
    float sf;
    if (SWING_TYPE == 1) {
        // binario: primera mitad larga, segunda corta
        if (frac < 0.5) frac * (1.0 + p) => sf;
        else            0.5*(1.0+p) + (frac-0.5)*(1.0-p) => sf;
    } else {
        // ternario: primeros dos tercios largos, ultimo corto
        if (frac < 2.0/3.0) frac * (1.0 + p) => sf;
        else                 (2.0/3.0)*(1.0+p) + (frac-2.0/3.0)*(1.0-2.0*p) => sf;
    }
    return (bn + sf) * beatSec;
}

// --- Tocar desde los arreglos en loop ---
fun void playPhrase() {
    BEATS * beatSec => float limit;
    0.0 => float eb;   // elapsed en beats rectos (para el mapa de swing)

    for (0 => int i; i < N; i++) {
        swingTime(eb) => float t_start;
        if (t_start >= limit) break;

        PITCH[i] => int pitch;
        BIN[i]   => int bin;

        0.5 => float dur_b;
        if (bin >= 0 && bin < DUR.size()) DUR[bin] => dur_b;

        // duracion real = diferencia en el mapa de swing
        swingTime(eb + dur_b) - t_start => float dur_s;
        if (t_start + dur_s > limit) limit - t_start => dur_s;

        // --- dinamica: acentos en beats 2 y 4 ---
        eb % 4.0 => float pos;
        float vel;
        if ((pos >= 1.0 && pos < 2.0) || (pos >= 3.0 && pos < 4.0)) {
            Math.random2f(0.65, 0.95) => vel;
        } else {
            Math.random2f(0.3, 0.6) => vel;
        }

        <<< "  [", i, "] pitch:", pitch, "dur_b:", dur_b, "dur_s:", dur_s, "eb:", eb, "now:", (now/second) >>>;

        if (pitch > 0) {
            Std.mtof(pitch) => piano.freq;
            vel => piano.noteOn;
        }
        (dur_s * 0.85 :: second) => now;
        if (pitch > 0) 0.5 => piano.noteOff;
        (dur_s * 0.15 :: second) => now;

        eb + dur_b => eb;
    }

    // rellenar silencio si la frase termino antes
    swingTime(eb) => float t_end;
    if (t_end < limit) ((limit - t_end) :: second) => now;
}

while (true) { playPhrase(); }
