// CurrulaoGRU.ck
// Currulao generator using Chonnx (CurrulaoGRU)
// Trained on transcriptions by Baudilio Cuama and Marino Beltran
// (book "Arrullos y Currulaos")
//
// The model learns P(next_phrase | last 4 phrases and their states)
// The GRU remembers the arc of previous phrases:
//   G->G->G->G behaves differently from B->F->G->H
//   even when the last step is the same.
//
// Difference vs CurrulaoAI.ck (MLP):
//   MLP sees: [current_state, previous_phrase]                    (2 inputs)
//   GRU sees: [state_t-4, phrase_t-4, ..., state_t-1, phrase_t-1]  (8 inputs)

Machine.add(me.dir() + "../Phrasing.ck");
Machine.add(me.dir() + "../MarimbaTimes.ck");

// === PARAMETERS ===
0.26  => float Beat;     // duration of an eighth note in seconds
60    => int  OFFSET;    // root note: 60 = middle C
0     => int  STATE;     // initial state: 0 = tonic, 1 = dominant
2.5   => float TEMP;     // temperature: 1.0 = pure model, >1 = more variety, <1 = safer
// ==================

// --- Harmonic field ---
[OFFSET-5, OFFSET, OFFSET+4, OFFSET+7, OFFSET+12, OFFSET+16] @=> int ONotes[];             // tonic
[OFFSET-5, OFFSET-1, OFFSET+2, OFFSET+5, OFFSET+7, OFFSET+12, OFFSET+14] @=> int INotes[]; // dominant

// === Phrase vocabulary ===
fun int[] phrase(int idx) {
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

fun int[] assignNotes(int pattern[], int state) {
    int result[pattern.size()];
    for (0 => int i; i < pattern.size(); i++) {
        if (pattern[i] == 1) {
            if (state == 0) {
                Math.random2(0, ONotes.size()-1) => int r;
                ONotes[r] => result[i];
            } else {
                Math.random2(0, INotes.size()-1) => int r;
                INotes[r] => result[i];
            }
        } else {
            pattern[i] => result[i];
        }
    }
    return result;
}

// === Chonnx — CurrulaoGRU ===
Chonnx brain;
brain.load_model(me.dir() + "../../Chonnx_Training/currulao_gru.onnx");

// === History of the last 4 phrases ===
// Updated after every prediction
int history[4];
6 => history[0];   // initialize with G (most common phrase)
6 => history[1];
6 => history[2];
6 => history[3];

// === Proportional sampling from the 10 probabilities ===
// GRU input: 8 values = 4 timesteps x [phrase/9.0, state]
// Order: oldest first (history[0] -> history[3])
//
// Since the state always alternates, if CURRENT_STATE = E:
//   t-4 -> E     (4 steps back, even number of alternations)
//   t-3 -> E^1
//   t-2 -> E
//   t-1 -> E^1
fun int sampleNext(int currentState) {
    // State of each step in the history
    // history[0] = t-4 -> same state as current (even)
    // history[1] = t-3 -> opposite state
    // history[2] = t-2 -> same state
    // history[3] = t-1 -> opposite state
    int st[4];
    currentState     => st[0];
    1 - currentState => st[1];
    currentState     => st[2];
    1 - currentState => st[3];

    // Fill the model's 8 inputs
    for (0 => int i; i < 4; i++) {
        brain.set_input(i*2,     history[i] / 9.0);
        brain.set_input(i*2 + 1, st[i] * 1.0);
    }
    brain.run();

    // Temperature scaling: p^(1/T) flattens the distribution when T > 1
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

// === Update history (shift + new value) ===
fun void pushHistory(int newPhrase) {
    // shift: history[0]<-[1], [1]<-[2], [2]<-[3], [3]<-newPhrase
    for (0 => int i; i < 3; i++) {
        history[i+1] => history[i];
    }
    newPhrase => history[3];
}

// === Percussion ===
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

// === Synthesis: two marimba voices ===
MarimbaTimes rh;
MarimbaTimes lh;

// === Main loop ===
string names[10];
"A" => names[0]; "B" => names[1]; "C" => names[2];
"D" => names[3]; "E" => names[4]; "F" => names[5];
"G" => names[6]; "H" => names[7]; "I" => names[8]; "J" => names[9];

<<< "=== CurrulaoGRU ===" >>>;
<<< "Initial state:", (STATE == 0 ? "Tonic" : "Dominant") >>>;
<<< "Initial history: G G G G" >>>;

while (true) {
    // Predict the next phrase with the GRU
    sampleNext(STATE) => int nextPhrase;

    // Show history -> next
    <<< (STATE == 0 ? "T" : "D"),
        "  [", names[history[0]], names[history[1]],
               names[history[2]], names[history[3]], "]",
        "->", names[nextPhrase] >>>;

    // Update history
    pushHistory(nextPhrase);

    // Build notes for RH and LH
    phrase(nextPhrase) @=> int pattern[];
    assignNotes(pattern, STATE) @=> int RH[];
    assignNotes(pattern, STATE) @=> int LH[];

    // Play
    spork ~ rh.play(Beat, 10, 1, RH);
    lh.play(Beat, 8, 1, LH);

    // Alternate harmonic state
    1 - STATE => STATE;
}
