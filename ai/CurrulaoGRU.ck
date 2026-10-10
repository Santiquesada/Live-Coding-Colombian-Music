// CurrulaoGRU.ck
// Generador de currulao usando Chonnx (CurrulaoGRU)
// Entrenado sobre transcripciones de Baudilio Cuama y Marino Beltran
// (libro Arrullos y Currulaos)
//
// El modelo aprende P(frase_siguiente | ultimas 4 frases y sus estados)
// La GRU recuerda el arco de frases anterior:
//   G->G->G->G se comporta diferente a B->F->G->H
//   aunque el ultimo paso sea el mismo.
//
// Diferencia vs CurrulaoAI.ck (MLP):
//   MLP ve:  [estado_actual, frase_anterior]        (2 entradas)
//   GRU ve:  [estado_t-4, frase_t-4, ..., estado_t-1, frase_t-1]  (8 entradas)

Machine.add(me.dir() + "../Phrasing.ck");
Machine.add(me.dir() + "../MarimbaTimes.ck");

// === PARAMETROS ===
0.20  => float Beat;     // duracion de una corchea en segundos (~94 BPM en 6/8)
60    => int  OFFSET;    // nota raiz: 60 = Do central
0     => int  ESTADO;    // estado inicial: 0 = Tonica, 1 = Dominante
2.5   => float TEMP;     // temperatura: 1.0=modelo puro, >1=mas variedad, <1=mas seguro
// ==================

// --- Campo armonico ---
[OFFSET-5, OFFSET, OFFSET+4, OFFSET+7, OFFSET+12, OFFSET+16] @=> int ONotes[];
[OFFSET-5, OFFSET-1, OFFSET+2, OFFSET+5, OFFSET+7, OFFSET+12, OFFSET+14] @=> int INotes[];

// === Vocabulario de frases ===
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

// === Chonnx — CurrulaoGRU ===
Chonnx brain;
brain.load_model(me.dir() + "../../Chonnx_Training/currulao_gru.onnx");

// === Historial de las ultimas 4 frases ===
// Se actualiza despues de cada prediccion
int historial[4];
6 => historial[0];   // inicializar con G (frase mas comun)
6 => historial[1];
6 => historial[2];
6 => historial[3];

// === Muestreo proporcional desde las 10 probabilidades ===
// Input GRU: 8 valores = 4 timesteps x [frase/9.0, estado]
// Orden: mas antiguo primero (historial[0] -> historial[3])
//
// Como el estado siempre alterna, si ESTADO_ACTUAL = E:
//   t-4 -> E     (4 pasos atras, numero par de alternaciones)
//   t-3 -> E^1
//   t-2 -> E
//   t-1 -> E^1
fun int muestrear(int estado_actual) {
    // Calcular estado de cada paso del historial
    // historial[0] = t-4 -> mismo estado que el actual (par)
    // historial[1] = t-3 -> estado contrario
    // historial[2] = t-2 -> mismo estado
    // historial[3] = t-1 -> estado contrario
    int est[4];
    estado_actual     => est[0];
    1 - estado_actual => est[1];
    estado_actual     => est[2];
    1 - estado_actual => est[3];

    // Llenar los 8 inputs del modelo
    for (0 => int i; i < 4; i++) {
        brain.set_input(i*2,     historial[i] / 9.0);
        brain.set_input(i*2 + 1, est[i] * 1.0);
    }
    brain.run();

    // Temperature scaling: p^(1/T) aplana la distribucion cuando T > 1
    float acc[10];
    0.0 => float total;
    for (0 => int i; i < 10; i++) {
        Math.pow(brain.get_output(i), 1.0 / TEMP) => float p;
        p + total => total;
        total => acc[i];
    }
    Math.random2f(0.0, total) => float r;
    for (0 => int i; i < 10; i++) {
        if (r <= acc[i]) return i;
    }
    return 6;  // fallback: G
}

// === Actualizar historial (shift + nuevo valor) ===
fun void actualizarHistorial(int nueva_frase) {
    // shift: historial[0]<-[1], [1]<-[2], [2]<-[3], [3]<-nueva_frase
    for (0 => int i; i < 3; i++) {
        historial[i+1] => historial[i];
    }
    nueva_frase => historial[3];
}

// === Percusion ===
SndBuf bombo => Gain bomboGain => dac;
me.dir() + "../Samples/BomboMadera.wav" => bombo.read;
0.8 => bomboGain.gain;
bombo.samples() => bombo.pos;

SndBuf cununo => Gain cununoGain => dac;
me.dir() + "../Samples/CununoAbierto.wav" => cununo.read;
0.3 => cununoGain.gain;
cununo.samples() => cununo.pos;

[1,0,1,1,1,0] @=> int BOMBO_PAT[];
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

// === Sintesis: dos voces de marimba ===
MarimbaTimes rh;
MarimbaTimes lh;

// === Bucle principal ===
string nombres[10];
"A" => nombres[0]; "B" => nombres[1]; "C" => nombres[2];
"D" => nombres[3]; "E" => nombres[4]; "F" => nombres[5];
"G" => nombres[6]; "H" => nombres[7]; "I" => nombres[8]; "J" => nombres[9];

<<< "=== CurrulaoGRU ===" >>>;
<<< "Estado inicial:", (ESTADO == 0 ? "Tonica" : "Dominante") >>>;
<<< "Historial inicial: G G G G" >>>;

while (true) {
    // Predecir siguiente frase con la GRU
    muestrear(ESTADO) => int siguiente;

    // Mostrar historial -> siguiente
    <<< (ESTADO == 0 ? "T" : "D"),
        "  [", nombres[historial[0]], nombres[historial[1]],
               nombres[historial[2]], nombres[historial[3]], "]",
        "->", nombres[siguiente] >>>;

    // Actualizar historial
    actualizarHistorial(siguiente);

    // Construir notas para RH y LH
    frase(siguiente) @=> int patron[];
    asignarNotas(patron, ESTADO) @=> int RH[];
    asignarNotas(patron, ESTADO) @=> int LH[];

    // Tocar
    spork ~ rh.play(Beat, 10, 1, RH);
    lh.play(Beat, 8, 1, LH);

    // Alternar estado armonico
    1 - ESTADO => ESTADO;
}
