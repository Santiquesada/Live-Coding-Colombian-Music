// ChAR-params.ck — Parámetros de live coding
// =====================================================
// ESTE es el archivo que editas y reemplazas en vivo.
// ChAR-test.ck debe estar corriendo primero.

global float gBPM;
global float gTA;
global float gTB;
global int   gBEATS;
global int   gTopK;

// === EDITA AQUÍ ===
120.0 => gBPM;     // tempo
0.9   => gTA;      // temperatura pitch (0.5=conservador, 1.5=loco)
1.5   => gTB;      // temperatura duración
48    => gBEATS;   // beats por frase (48 = 12 compases de 4/4)
10    => gTopK;    // top-k sampling
