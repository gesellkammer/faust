declare name        "vumatrix8";
declare version     "1.0";
declare author      "Grame";
declare license     "BSD";
declare copyright   "(c) GRAME 2006";

//-----------------------------------------------
// Audio Matrix : N inputs x M outputs
//-----------------------------------------------

import("music.lib");

mute(state)            = *(1 - checkbox("mute", state));
vumeter         = component("vumeter.dsp").vmeter;
// Fader(in)       = db2linear(vslider("Input %in", -10, -96, 4, 0.1));
vol             = component("volume.dsp");
chan(v, state)        = vgroup("[%v]", mute(state) : hgroup("[2]", vol : vumeter));
// Mixer(N,out)    = hgroup("Output %out", par(in, N, *(Fader(in)) ) :> _ );
Mixer(N,out)    = hgroup("Output %out", par(in, N, *(chan(in, out==in)) ) :> _ );
Matrix(N,M)     = tgroup ("Matrix %N x %M", par(in, N, _) <: par(out, M, Mixer(N, out)));

process = Matrix(8, 8);
