public class Bergonzi
{
fun int[] MinorP(int Offset, int Initial, int formula,int rhythm[]) //composes melodic lines by using minor pentatonic  
{
    [0,3,5,7,10]@=>int pentatonics[];// here we can have different scales, this function is pentatonic minor
    int scale[40];
   2=>int octave;
     for(0=>int j;j<scale.size();j++)
    {
        octave+1=>octave;
            for(0=>int i;i<pentatonics.size();i++)
             {
               pentatonics[i]+(Offset%12)+octave*12=>scale[j];
              
            j++;
             }
             
            j--;
    
    }
    [-1,-2,1,-2]@=>int Formula3[];
    [-2,1,-2,-1]@=>int Formula2[];
    [1,-2,-1,-2]@=>int Formula1[];
    [-2,-1,-2,1]@=>int Formula4[];
    
    [1,2,-1,2]@=>int Formula5[];
   [2,-1,2,1]@=>int Formula6[];
   [-1,2,1,2]@=>int Formula7[];
    [2,1,2,-1]@=>int Formula8[];

  int chooseFormula[4];
    
    if(formula ==1)
    {
        <<<"Formula1">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula1[j]=>chooseFormula[j];
    }
}
 if(formula ==2)
    {
        <<<"Formula2">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula2[j]=>chooseFormula[j];
    }
}
 if(formula ==3)
    {
        <<<"Formula3">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula3[j]=>chooseFormula[j];
    }
}
 if(formula ==4)
    {
        <<<"Formula4">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula4[j]=>chooseFormula[j];
    }
}
 if(formula ==5)
    {
        <<<"Formula5">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula5[j]=>chooseFormula[j];
    }
}
 if(formula ==6)
    {
        <<<"Formula6">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula6[j]=>chooseFormula[j];
    }
}
 if(formula ==7)
    {
        <<<"Formula7">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula7[j]=>chooseFormula[j];
    }
}
 if(formula ==8)
    {
        <<<"Formula8">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula8[j]=>chooseFormula[j];
    }
}
        
    // complete the other formulas
   //initial sets what degree of the scale we start with     
   
pentatonics[Initial-1]+Offset+12=> int current;
int startingpoint;
int index;
for(0=>int i;i<scale.size();i++)
    {
       if(scale[i]==current)
       {
           i=>index;
           scale[i]=>startingpoint;
       }
      
    }
<<<"starting",index>>>;
    
    int Notes[25];
    startingpoint =>Notes[0];
    
    for(1=>int i;i<Notes.size();i++)
    {
       //Notes[i-1]=>index;
       for(0=>int j;j<chooseFormula.size();j++)
    {
       scale[index+chooseFormula[j]]=>Notes[i];
      
        i++;
    index+chooseFormula[j]=>index;
        }
      i--;  
    
    }
    
    int finalNotes[16];
     for(0=>int i;i<finalNotes.size();i++)
    {
        Notes[i]=>finalNotes[i];
       
    }
    int NoteswithRhythm[rhythm.size()];
    0=>int currentI;
     for(0=>int i;i<NoteswithRhythm.size();i++)
    {
if (rhythm[i]<1)
    rhythm[i]=>NoteswithRhythm[i];
else
{
    if (rhythm[i]==1)
    {
    finalNotes[currentI]=>NoteswithRhythm[i];
     currentI++;
    }
        if (rhythm[i]==2)
    {
    finalNotes[currentI]=>NoteswithRhythm[i];
     
    }
}
    }
      for(0=>int i;i<NoteswithRhythm.size();i++)
    {
       
        <<<NoteswithRhythm[i]>>>;
    }
 return NoteswithRhythm;   
}

fun int[] Messiaen(int Offset, int Initial, int formula,int rhythm[]) //composes melodic lines by using minor pentatonic  
{
    [0,2,3,4,6,7,8,10,11]@=>int Messiaen[];// here we can have different scales, this function is pentatonic minor
    int scale[90];
   1=>int octave;
     for(0=>int j;j<scale.size();j++)
    {
        octave+1=>octave;
            for(0=>int i;i<Messiaen.size();i++)
             {
               Messiaen[i]+(Offset%12)+octave*12=>scale[j];
              
            j++;
             }
             
            j--;
    
    }
    [-1,-2,1,-2]@=>int Formula3[];
    [-2,1,-2,-1]@=>int Formula2[];
    [1,-2,-1,-2]@=>int Formula1[];
    [-2,-1,-2,1]@=>int Formula4[];
    
    [1,2,-1,2]@=>int Formula5[];
   [2,-1,2,1]@=>int Formula6[];
   [-1,2,1,2]@=>int Formula7[];
    [2,1,2,-1]@=>int Formula8[];

  int chooseFormula[4];
    
    if(formula ==1)
    {
        <<<"Formula1">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula1[j]=>chooseFormula[j];
    }
}
 if(formula ==2)
    {
        <<<"Formula2">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula2[j]=>chooseFormula[j];
    }
}
 if(formula ==3)
    {
        <<<"Formula3">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula3[j]=>chooseFormula[j];
    }
}
 if(formula ==4)
    {
        <<<"Formula4">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula4[j]=>chooseFormula[j];
    }
}
      if(formula ==5)
    {
        <<<"Formula5">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula5[j]=>chooseFormula[j];
    }
}
 if(formula ==6)
    {
        <<<"Formula6">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula6[j]=>chooseFormula[j];
    }
}
 if(formula ==7)
    {
        <<<"Formula7">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula7[j]=>chooseFormula[j];
    }
}
 if(formula ==8)
    {
        <<<"Formula8">>>;
      for(0=>int j;j<chooseFormula.size();j++)
    {
        Formula8[j]=>chooseFormula[j];
    }
}  
    // complete the other formulas
   //initial sets what degree of the scale we start with     
   
Messiaen[Initial-1]+Offset+12=> int current;
int startingpoint;
int index;
for(0=>int i;i<scale.size();i++)
    {
       if(scale[i]==current)
       {
           i=>index;
           scale[i]=>startingpoint;
       }
      
    }
<<<"starting",index>>>;
    
    int Notes[25];
    startingpoint =>Notes[0];
    
    for(1=>int i;i<Notes.size();i++)
    {
       //Notes[i-1]=>index;
       for(0=>int j;j<chooseFormula.size();j++)
    {
       scale[index+chooseFormula[j]]=>Notes[i];
      
        i++;
    index+chooseFormula[j]=>index;
        }
      i--;  
    
    }
    
    int finalNotes[16];
     for(0=>int i;i<finalNotes.size();i++)
    {
        Notes[i]=>finalNotes[i];
       
    }
    int NoteswithRhythm[rhythm.size()];
    0=>int currentI;
     for(0=>int i;i<NoteswithRhythm.size();i++)
    {
if (rhythm[i]<1)
    rhythm[i]=>NoteswithRhythm[i];
else
{
    if (rhythm[i]==1)
    {
    finalNotes[currentI]=>NoteswithRhythm[i];
     currentI++;
    }
        if (rhythm[i]==2)
    {
    finalNotes[currentI]=>NoteswithRhythm[i];
     
    }
}
    }
      for(0=>int i;i<NoteswithRhythm.size();i++)
    {
       
        <<<NoteswithRhythm[i]>>>;
    }
    
     
   
 return NoteswithRhythm;   
}


fun int[] join(int rhythmA[], int rhythmB[])
{
    int finalNotes[rhythmA.size()+rhythmB.size()];
     for(0=>int i;i<finalNotes.size();i++)
    {
     for(0=>int j;j<rhythmA.size();j++)
    {
       rhythmA[j]=>finalNotes[i];
        i++;
    }  
     for(0=>int k;k<rhythmB.size();k++)
    {
       rhythmB[k]=>finalNotes[i];
       i++; 
    }  
        
    }
     for(0=>int k;k<finalNotes.size();k++)
    {
      
        
    }
    return finalNotes;
}

}

