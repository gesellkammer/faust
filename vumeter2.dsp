declare name        "jackvumeter8";
declare version     "1.0";
declare author      "Grame";
declare license     "BSD";
declare copyright   "(c) GRAME 2006";

//-------------------------------------------------
// Simple 8 ch vu-meter with a main gain and mute for each chan
// The channels flow through (8 in - 8 out) and a gain can be
// applied to these channels. 
// It is thought to be used for monitoring at the end of the jack chain
//-------------------------------------------------

import("music.lib");

vumeter     = component("vumeter.dsp").vmeter;
mute        = (*(1 - checkbox("m")));
smooth(c)   = *(1-c) : +~*(c);
gain        = vslider("gain", 0, -70, +4, 0.1) : db2linear : smooth(0.999);
xgain2(ch1, ch2) = gain <: ((_ * ch1), (_ * ch2));

voice(v)    = vgroup("ch%v",  mute : vumeter);

process     = hgroup("VU", par(i, 2, voice(i)) : xgain2);
