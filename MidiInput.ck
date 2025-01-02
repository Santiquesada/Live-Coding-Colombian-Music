//------------------------------------------------
// name: polyfony2.ck
// desc: polyfonic clarinet model with midi input
//
// authors: Ananya Misra and Ge Wang
// send all complaints to prc@cs.princeton.edu
//--------------------------------------------

// device to open
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

MidiIn min;
MidiMsg msg;

// try to open MIDI port (see chuck --probe for available devices)
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;


// make our own event
class NoteEvent extends Event
{
    int note;
    int velocity;
}

// the event
NoteEvent on;
// array of ugen's handling each note
Event @ us[128];

// the base patch



// handler shred for a single voice
fun void handler()
{
    // don't connect to dac until we need it
   
    Event off;
    int note;

    // inifinite time loop
    while( true )
    {
        on => now;
        on.note => note;
        // dynamically repatch
       
       
        
    
             
                 
        off @=> us[note];

        off => now;
       
        null @=> us[note];
       
       
    }
}

// spork handlers, one for each voice
for( 0 => int i; i < 4; i++ ) spork ~ handler();

// infinite time loop
while( true )
{
    // wait on midi event
    min => now;

    // get the midimsg
    while( min.recv( msg ) )
    {
        // catch only noteon
        
           
            
                 <<<msg.data1,msg.data2,msg.data3>>>;
                
                     
                msg.data2 => on.note;
                // store velocity
               msg.data3 => on.velocity;
               
                // signal the event
                on.signal();
                // yield without advancing time to allow shred to run
                me.yield();
           
        }
       
    }
