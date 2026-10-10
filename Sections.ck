class section
{
Hid hi;
HidMsg msg;
synch s;
     0.18=>float Beat;
// which keyboard
0 => int device;
0=>int flag;
// get from command line
fun void perform()
{        
if( me.args() ) me.arg(0) => Std.atoi => device;

// open keyboard (get device number from command line)
if( !hi.openKeyboard( device ) ) me.exit();
<<< "Ready to perform" >>>;

// infinite event loop

while( true )
{
    // wait on event
    hi => now;

    // get one or more messages
    while( hi.recv( msg ) )
    {
        // check for action type
        if( msg.isButtonDown() )
        {
          if (msg.ascii==32 && flag==0) 
          {
              1=> flag;
              
          
    
              <<<"section A", me.id()>>>;
             
             s.cycle(8,Beat); 
            Machine.add(me.dir() + "pieces/Section A.ck");
             
          }
     else  if (msg.ascii==32 && flag==1) 
          {
 0=> flag;
    
              <<<"section B">>>; 
         
              Machine.add(me.dir() + "pieces/Section B.ck");
                            
          }
              }
        
      
    }
}
} 
}
section M;
M.perform();