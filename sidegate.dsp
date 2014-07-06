declare name "Side gate";
declare author "Julius O. Smith (jos at ccrma.stanford.edu)";
declare copyright "Julius O. Smith III";
declare license "STK-4.3"; // Synthesis Tool Kit 4.3 (MIT style license)
declare reference "http://en.wikipedia.org/wiki/Noise_gate";

// expects a stereo signal, where the first channel is gated using the 2nd chann

import ("effect.lib");

process = _,_ : gate_side with {

   gate_group(x)  = vgroup("GATE  [tooltip: Reference: http://en.wikipedia.org/wiki/Noise_gate]", x);
   meter_group(x) = gate_group(hgroup("[0]", x));
   knob_group(x)  = gate_group(hgroup("[1]", x));

   gate_side(x, y) = x * gate_gain_mono(gatethr, gateatt, gatehold, gaterel, y);   

   gatethr = knob_group(hslider("[1] Threshold [unit:dB] [style:knob]  [tooltip: When the signal level falls below the Threshold (expressed in dB), the signal is muted]",
     -30, -120, 0, 0.1));

   gateatt = knob_group(hslider("[2] Attack [unit:us] [style:knob]  [tooltip: Time constant in MICROseconds (1/e smoothing time) for the gate gain to go (exponentially) from 0 (muted) to 1 (unmuted)]",
     10, 10, 10000, 1)) : *(0.000001) : max(1.0/float(SR));

   gatehold = knob_group(hslider("[3] Hold [unit:ms] [style:knob]  [tooltip: Time in ms to keep the gate open (no muting) after the signal level falls below the Threshold]",
     200, 0, 1000, 1)) : *(0.001) : max(1.0/float(SR));

   gaterel = knob_group(hslider("[4] Release [unit:ms] [style:knob]  [tooltip: Time constant in ms (1/e smoothing time) for the gain to go (exponentially) from 1 (unmuted) to 0 (muted)]",
     100, 0, 1000, 1)) : *(0.001) : max(1.0/float(SR));
};
