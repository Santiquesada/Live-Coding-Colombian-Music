
public class AImarimba
{
         MarimbaTimes rh;
         MarimbaTimes lh; 
// generate

//score will generate Measure bars of  traditional phrases
fun int[] score(int Measures) 
{

HMM hmm;

// load
[0.0] @=> float initial[];
// we are changing always from tonic to Dominant
[[0.0, 1.0],
 [1.0, 0.0]] @=> float transition[][];
 // we will have 4 musical phrases
[[0.2, 0.7, 0.04,0.06],
 [0.1, 0.5, 0.1,0.3]] @=> float emission[][];
hmm.load( initial, transition, emission );
int observations[Measures];    
hmm.generate(Measures, observations );

    
    
return observations;
}



 
fun int[] phrases(int phrase)
{
    <<<"soy phrase,",phrase>>>;
if(phrase==0)
    return [0,1,1,1,1,1];
if(phrase==1)
    return [-1,0,1,-1,0,1,1,0,1];
if(phrase==2)
    return [-1,0,1,-1,0,1,-1,0,1,-1,0,1];
if(phrase==3)
    return [0,1,0,1,0,1];
else
    return[0,0,0,0,0,0];
}    
fun void phrasetomusic(int measures, float Beat,int Offset)
{
    

//<<<"soy measures",measures>>>;    
score(measures)@=>int generation[];    
    
    //<<<"gensize",generation.size()>>>;
    [Offset-5,Offset, Offset +4, Offset+7, Offset+12,Offset+16]@=>int ONotes[];
    [Offset-5,Offset-1, Offset +2, Offset+5,Offset+7, Offset+12,Offset+14]@=>int INotes[];
 for(0=>int i;i<generation.size();i++)
      {
     phrases(generation[i])@=>int rhythm[];
          //<<<generation[i]>>>;
         // <<<"rsize",rhythm.size()>>>;
     int RH[rhythm.size()];
     int LH[rhythm.size()];     
          
 for(0=>int j;j<rhythm.size();j++)
      {
          
          if(rhythm[j]==1)
          {
              if (i%2==0)
              {
                Math.random2(1,ONotes.size()-1)=>int randomrh;
                randomrh-1=>int randomlh;  
                ONotes[randomrh]=>RH[j];
                Math.random2(0,1)*ONotes[randomlh]=>LH[j];  
              }
               if (i%2==1)
              {
                Math.random2(1,INotes.size()-1)=>int randomrh;
                randomrh-1=>int randomlh;  
                INotes[randomrh]=>RH[j];
                Math.random2(0,1)*INotes[randomlh]=>LH[j];
              }
          }
          else
          {
              rhythm[j]=>RH[j];
               rhythm[j]=>LH[j];
           }
       }
          for(0=>int k;k<RH.size();k++)
          {
           // <<<"soy RH",RH[k]>>>;
            //   <<<"soy LH",LH[k]>>>;
          }
    
     
     spork ~ rh.play(Beat,10,2,RH);
     lh.play(Beat,12,2,LH);     
      
    
      }
      
} 
}