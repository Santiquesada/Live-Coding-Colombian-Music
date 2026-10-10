// ChAR-debug.ck — test minimo para aislar el crash
// Agrega este shred y mira que dice la consola

<<< "1. Iniciando..." >>>;

me.dir() + "../onnx/char_a.onnx" => string pathA;
me.dir() + "../onnx/char_b.onnx" => string pathB;

<<< "2. Rutas:" >>>;
<<< pathA >>>;
<<< pathB >>>;

ChAR jazz;
<<< "3. ChAR instanciado" >>>;

jazz.load(pathA, pathB);
<<< "4. Modelos cargados" >>>;

jazz.set_progression("C7,G7,F7,C7");
<<< "5. Progresion seteada" >>>;

jazz.generate(16, 0.9, 1.2);
<<< "6. Generados", jazz.num_tokens(), "tokens" >>>;

<<< "7. OK — sin crash" >>>;
