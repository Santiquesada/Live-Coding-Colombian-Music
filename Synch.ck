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


}