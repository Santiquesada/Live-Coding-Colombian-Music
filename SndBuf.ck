 // definimos que vamos a crear un sample de nombre sample
 SndBuf Sample=>dac;
 // la siguiente línea es muy importante, la palabra me.dir() quiere decir q en la carpeta que guardemos este código, tiene que existir el audio llamado Kick_01.wav, si no existe el programa no hará nada
 me.dir()+"Kick.wav"=>Sample.read;
 0.8=>Sample.gain;
 1::second=>now;