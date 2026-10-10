// CurrulaoAI.ck
// Generador de currulao usando Chonnx (CurrulaoBrain)

Machine.add(me.dir() + "../Phrasing.ck");
Machine.add(me.dir() + "../MarimbaTimes.ck");

// === PARÁMETROS ===
0.20  => float Beat;     // duración de una corchea en segundos (~94 BPM en 6/8)
60    => int  OFFSET;    // nota raíz: 60 = Do central
0     => int  ESTADO;    // estado inicial: 0 = Tónica, 1 = Dominante
// ==================

// --- Campo armónico ---
// Tónica: raíz + 3ra + 5ta + octavas
[OFFSET-5, OFFSET, OFFSET+4, OFFSET+7, OFFSET+12, OFFSET+16] @=> int ONotes[];

// Dominante: 5to grado con séptima (dominante del modo)
[OFFSET-5, OFFSET-1, OFFSET+2, OFFSET+5, OFFSET+7, OFFSET+12, OFFSET+14] @=> int INotes[];

// === Vocabulario de frases ===
// Corpus: Baudilio Cuama + Marino Beltrán
// Notación: 0=silencio, 1=golpe, -1=toggle a semicorcheas
//
// Índice  Nombre  Descripción
//   0       A     [1,0,0,1,0,0]                          esparsa
//   1       B     [1,0,0,1,0,1]                          esparsa con final
//   2       C     [1,0,1,1,0,1]                          media
//   3       D     [1,1,1,1,1,1]                          todas corcheas
//   4       E     [-1,0,1,-1,0,1,1,0,1]                 síncopa + corcheas
//   5       F     [-1,0,1,-1,0,1,1,1,1]                 síncopa + cierre denso
//   6       G     [-1,0,1,-1,1,1,1,0,1]                 frase dominante del corpus
//   7       H     [-1,0,1,-1,1,1,1,1,1]                 variante densa de G
//   8       I     [-1,0,1,-1,0,1,-1,1,1,-1,0,1]         mixta
//   9       J     [-1,0,1,-1,0,1,-1,0,1,-1,0,1]         clímax — todas semicorcheas

fun int[] frase(int idx) {
    if (idx == 0) return [1,0,0,1,0,0];
    if (idx == 1) return [1,0,0,1,0,1];
    if (idx == 2) return [1,0,1,1,0,1];
    if (idx == 3) return [1,1,1,1,1,1];
    if (idx == 4) return [-1,0,1,-1,0,1,1,0,1];
    if (idx == 5) return [-1,0,1,-1,0,1,1,1,1];
    if (idx == 6) return [-1,0,1,-1,1,1,1,0,1];
    if (idx == 7) return [-1,0,1,-1,1,1,1,1,1];
    if (idx == 8) return [-1,0,1,-1,0,1,-1,1,1,-1,0,1];
    else          return [-1,0,1,-1,0,1,-1,0,1,-1,0,1];
}

// === Asignar notas MIDI al patrón rítmico ===
// 1 → nota aleatoria del campo armónico según estado
// 0 → silencio (pasa directo)
// -1 → toggle de semicorcheas (pasa directo para Phrasing)
fun int[] asignarNotas(int patron[], int estado) {
    int resultado[patron.size()];
    for (0 => int i; i < patron.size(); i++) {
        if (patron[i] == 1) {
            if (estado == 0) {
                Math.random2(0, ONotes.size()-1) => int r;
                ONotes[r] => resultado[i];
            } else {
                Math.random2(0, INotes.size()-1) => int r;
                INotes[r] => resultado[i];
            }
        } else {
            patron[i] => resultado[i];
        }
    }
    return resultado;
}

// === Chonnx — CurrulaoBrain ===
Chonnx brain;
brain.load_model(me.dir() + "../../Chonnx_Training/currulao.onnx");

// === Muestreo proporcional desde las 10 probabilidades ===
fun int muestrear(int estado, int frase_prev) {
    brain.set_input(0, estado * 1.0);
    brain.set_input(1, frase_prev / 9.0);
    brain.run();

    // Acumular probabilidades para muestreo por CDF
    float acc[10];
    0.0 => float total;
    for (0 => int i; i < 10; i++) {
        brain.get_output(i) + total => total;
        total => acc[i];
    }

    Math.random2f(0.0, total) => float r;
    for (0 => int i; i < 10; i++) {
        if (r <= acc[i]) return i;
    }
    return 6;  // fallback: G
}

// === Bombo: patrón 101101 en cada compás ===
SndBuf bombo => Gain bomboGain => dac;
me.dir() + "../Samples/BomboMadera.wav" => bombo.read;
0.8 => bomboGain.gain;
bombo.samples() => bombo.pos;   // silenciar al inicio
SndBuf cununo => Gain cununoGain => dac;
me.dir() + "../Samples/CununoAbierto.wav" => cununo.read;
0.3 => cununoGain.gain;
cununo.samples() => cununo.pos;

[1,0,1,1,1,0] @=> int BOMBO_PAT[];   // patrón rítmico del bombo
[0,1,1,1,1,1] @=> int CUNUNO_PAT[];
fun void bomboLoop() {
    while (true) {
        for (0 => int i; i < BOMBO_PAT.size(); i++) {
            if (BOMBO_PAT[i] == 1) 0 => bombo.pos;
            Beat::second => now;
        }
    }
}
fun void cununoLoop() {
    while (true) {
        for (0 => int i; i < CUNUNO_PAT.size(); i++) {
            if (CUNUNO_PAT[i] == 1) 0 => cununo.pos;
            Beat::second => now;
        }
    }
}
spork ~ bomboLoop();
spork ~ cununoLoop();

// === Síntesis: dos voces de marimba ===
MarimbaTimes rh;
MarimbaTimes lh;

// === Bucle principal ===
6 => int frase_actual;   // arranca en G — la más común del corpus

<<< "=== CurrulaoAI ===" >>>;
<<< "Initial Status", (ESTADO == 0 ? "Tonic" : "Dominant") >>>;

while (true) {
    // Predecir siguiente frase con el modelo
    muestrear(ESTADO, frase_actual) => int siguiente;
    siguiente => frase_actual;

    string nombres[10];
    "A" => nombres[0]; "B" => nombres[1]; "C" => nombres[2];
    "D" => nombres[3]; "E" => nombres[4]; "F" => nombres[5];
    "G" => nombres[6]; "H" => nombres[7]; "I" => nombres[8]; "J" => nombres[9];

    <<< (ESTADO == 0 ? "T" : "D"), "→ Phrase", nombres[frase_actual] >>>;

    // Construir arrays de notas para RH y LH
    // (misma frase rítmica, notas elegidas independientemente)
    frase(frase_actual) @=> int patron[];
    asignarNotas(patron, ESTADO) @=> int RH[];
    asignarNotas(patron, ESTADO) @=> int LH[];

    // Tocar ambas voces (RH sporked, LH bloquea hasta terminar la frase)
    spork ~ rh.play(Beat, 10, 1, RH);
    lh.play(Beat, 8, 1, LH);

    // Alternar estado armónico — regla del currulao
    1 - ESTADO => ESTADO;
}
