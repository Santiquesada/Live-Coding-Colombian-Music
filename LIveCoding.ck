Machine.add(me.dir() + "Library.ck");

0.18=>float Beat;

synch s;


Marimba Test;
 s.cycle(8,Beat);
[55,0,55,0,60,0,60,0]@=>int Notes[];
Test.play(Beat, 0, 1, Notes);