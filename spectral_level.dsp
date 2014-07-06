declare name "SpectralLevel";
declare author "Julius O. Smith (jos at ccrma.stanford.edu)";
declare copyright "Julius O. Smith III";
declare license "STK-4.3"; // Synthesis Tool Kit 4.3 (MIT style license)
declare reference "http://asa.aip.org/publications.html";

import("filter.lib");

M = 3; // number of bands per octave

spectral_level6e(M,ftop,N,tau,dB_offset) = _<:
    _,mth_octave_analyzer6e(M,ftop,N) : 
    _,(display:>_):attach with {
  fc(n) = ftop * 2^(float(n-N+3)/float(M))+0.5; // -3dB crossover frequencies  
  display = par(i,N,dbmeter(i));
  dbmeter(i) = abs : smooth(tau2pole(tau)) : linear2db : +(dB_offset) : 
     meter(N-i-1, int(fc(N-i-1)));
    meter(i, f) = speclevel_group(vgroup("[%2i] %f", vbargraph("[%2i] [unit:dB] 
     [tooltip: Spectral Band Level in dB]", -50, 10)));
  // Can M be included in the label string somehow?
  speclevel_group(x)  = hgroup("[0] CONSTANT-Q SPECTRUM ANALYZER (6E)
     [tooltip: See Faust's filter.lib for documentation and references]", x);
};

mth_spectral_level(M) = 
  spectral_level6e(M,ftop,N,tau,dB_offset) 
with {
  // Span nearly 10 octaves so that lowest band-edge is at 
  // ftop*2^(-Noct+2) = 40 Hz when ftop=10 kHz:
  N = int(10*M); // without 'int()', segmentation fault observed for M=1.67
  ftop = 10000;
  ctl_group(x)  = hgroup("[1] SPECTRUM ANALYZER CONTROLS", x);
  tau = ctl_group(hslider("[0] Level Averaging Time [unit:sec]
        [tooltip: band-level averaging time in seconds]",
        0.1,0,1,0.01)); 
  dB_offset = ctl_group(hslider("[1] Level dB Offset [unit:dB]
        [tooltip: Level offset in decibels]",
        50,0,100,1)); 
};

// process = mth_spectral_level(3) <: _,_;
process = mth_spectral_level(3) : _;
