public class synch
{
 fun void cycle(int Beats, float Beat)//La funcion Cycle, dentro de la clase Synch
   // recibe la cantidad de Beats que va a tener el compás(a eso lo vamos a llamar Beats), y la cantidad en segundos que va a durar el Beat(de nombre Beat) 
 {
     Beat::second=>dur Beet;
     (Beats*Beet) -(now% (Beats*Beet))=>now;//esta linea espera en silencio lo que resta entre el ahora y el inicio del siguiente Compás, esa espera es necesaria para sincronizar
 } 
fun void hush()//esta funcion silencia todo para enviar la nueva mezcla sin que interfieran las anteriores 
{
    for (0=>int i;i<me.id();i++)
    {
       
        Machine.remove(i);
    }
} 

fun void one()//esta funcion silencia todo para enviar la nueva mezcla sin que interfieran las anteriores
{
    for (2=>int i;i<me.id();i++)
    {

        Machine.remove(i);
    }
}

// Espera al proximo limite de frase (Beats * Beat) y LUEGO remueve los shreds viejos
// Uso: al inicio de un shred nuevo → la melodia anterior termina limpia antes de hush
fun void sync_hush(int Beats, float Beat)
{
    Beat::second => dur Beet;
    (Beats*Beet) - (now % (Beats*Beet)) => now;
    hush();
}

// Igual que sync_hush pero usa one() en vez de hush() (conserva shred 0 y 1)
fun void sync_one(int Beats, float Beat)
{
    Beat::second => dur Beet;
    (Beats*Beet) - (now % (Beats*Beet)) => now;
    one();
}

}