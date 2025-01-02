public class Messiaen
{    
MelodySynth instr;
    
fun void Mode3(float Beat,int percentage, int type, int Notes[],int Offset)
{
[0,2,3,4,6,7,9,10,12]@=>int Mode[];
int finalNotes[Notes.size()];    
for(0=>int i;i< Notes.size();i++)
    {
        if (Notes[i]>0)
        {
        Offset+Notes[i]-1=>finalNotes[i];
        }
        if (Notes[i]<=0)
        {
             Notes[i]=>finalNotes[i];
        }
    }
   instr.play(Beat,percentage,type,finalNotes); 
}

}

