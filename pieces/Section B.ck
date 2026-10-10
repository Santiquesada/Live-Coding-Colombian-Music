0.18=> float Beat;
synch s;
 Modes perc;
  Marimba m1;
  [1463,1463,1463,1463]@=>int Notes[];
  [60,0,0,0]@=>int Notes2[]; 
      
     
 spork~ perc.play(Beat*2,7,1,Notes);
spork~ m1.play(Beat*2,7,1,Notes2);
1::hour=>now;