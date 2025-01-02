public class rhythm
{
    genDrummer Bombo;
genDrummer Cununo;
genDrummer Guasa;
fun void Murga(float Beat,int percentage)
{


synch s;
 s.cycle(8,Beat);
[109,0,110,109,110,0]@=>int Notes[];
[0,113,111,111]@=>int Notes2[];
[200,0,200,0]@=>int Notes3[];
spork~Bombo.play(Beat, percentage, 1, Notes);
spork~Guasa.play(Beat, percentage, 1, Notes3);
    
Cununo.play(Beat, percentage, 1, Notes2);
}
fun void Aguabajo(float Beat,int percentage)
{



synch s;
 s.cycle(8,Beat);
[108,0,109,108,0,0,109,0,0,108,109,108,0,0,109,0]@=>int Notes[];
[0,0,112,0,0,0,111,111]@=>int Notes2[];
[200,0,200,0]@=>int Notes3[];

spork~Bombo.play(Beat, percentage, 1, Notes);
spork~Guasa.play(Beat, percentage, 1, Notes3);
Cununo.play(Beat, percentage, 1, Notes2);
    
}
fun void BambucoViejo(float Beat,int percentage)
{



synch s;
 s.cycle(12,Beat);
[109,0,110,119,110,0]@=>int Notes[];
[112,0,111]@=>int Notes2[];
[200,200,0]@=>int Notes3[];    

spork~Bombo.play(Beat, percentage, 2, Notes);
spork~Guasa.play(Beat, percentage, 2, Notes3);    
Cununo.play(Beat, percentage, 2, Notes2);
}
}
