//------------------------------------------------
// name: polyfony.ck
// desc: polyfonic mandolin model
//
// authors: Ananya Misra and Ge Wang
// send all complaints to prc@cs.princeton.edu
//--------------------------------------------

// device to open (see: chuck --probe)
public class MidiInDist
{

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
Gain g => JCRev r => dac;
.05 => g.gain;
.02 => r.mix;

// handler for a single voice
fun void handler()
{
    // don't connect to dac until we need it
    HevyMetl osc=> ADSR env =>LPF lpf;
    
    //0.5 => osc.controlOne; 0.8 => osc.controlTwo;
    500=>lpf.freq;
    5=>lpf.Q;
    (1::ms,2000::ms,0.0,1::ms)=>env.set;
    Event off;
    int note;

    while( true )
    {
        on => now;
        on.note => note;
        // dynamically repatch
        lpf => g;
        Std.mtof( note ) => osc.freq;
        1=>env.keyOn;
         1=>osc.noteOn;
         on.velocity /6.0=> osc.gain;
        off @=> us[note];

        off => now;
        null @=> us[note];
         1=>osc.noteOff;
        1=>env.keyOff;
        
        lpf =< g;
    }
}

// spork handlers, one for each voice
for( 0 => int i; i < 5; i++ ) spork ~ handler();

// infinite time-loop
while( true )
{
    // wait on midi event
    min => now;

    // get the midimsg
    while( min.recv( msg ) )
    {
        // catch only noteon
        if( (msg.data1 & 0xf0) == 0x90 )
        {
            // check velocity
            if( msg.data3 > 0 )
            {
                // store midi note number
                msg.data2 => on.note;
                // store velocity
                msg.data3 => on.velocity;
                // signal the event
                on.signal();
                // yield without advancing time to allow shred to run
                me.yield();
            }
            else
            {
                if( us[msg.data2] != null ) us[msg.data2].signal();
            }
        }
        else if( (msg.data1 & 0xf0) == 0x80 )
        {
            us[msg.data2].signal();
        }
    }
}
}