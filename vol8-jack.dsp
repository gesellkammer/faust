declare name        "volume-fader-8ch";
declare version     "1.0";
declare author      "Grame";
declare license     "BSD";
declare copyright   "(c) GRAME 2006";

//-------------------------------------------------
// Simple 8 volume fader with master gain 
//-------------------------------------------------
import("music.lib");

smooth(c)   = *(1-c) : +~*(c);
vol         = component("volume.dsp");
vumeter     = component("vumeter.dsp").vmeter;
mute        = *(1 - checkbox("m"));

master(c1, c2, c3, c4, c5, c6, c7, c8) = 
    vslider("master", 0, -70, +4, 0.1) : db2linear : smooth(0.999)
    <: ((_*c1), (_*c2), (_*c3), (_*c4), (_*c5), (_*c6), (_*c7), (_*c8));
voice(v)    = vgroup("voice %v",  mute : hgroup("[2]", vol : vumeter));
// stereo      = hgroup("stereo out", vol, vol);

// process     = hgroup("mixer", par(i, 8, voice(i)));
process     = hgroup("", par(i, 8, voice(i)) : master);
