//-------------------------- sawtooth_demo ---------------------------
// USAGE:  sawtooth_demo : _

sawtooth_demo = signal with { 
  osc_group(x) = vgroup("[0] SAWTOOTH OSCILLATOR 
    [tooltip: See Faust's oscillator.lib for documentation and references]",x);
  knob_group(x)  = osc_group(hgroup("[1]", x));
  ampdb  = knob_group(vslider("[1] Amplitude [unit:dB] [style:knob]
    [tooltip: Sawtooth waveform amplitude]",
    -20,-120,10,0.1));
  amp = ampdb : db2linear : smooth(0.999);
  freq = knob_group(
  vslider("[2] Frequency [unit:PK] [style:knob]
    [tooltip: Sawtooth frequency as a Piano Key (PK) number (A440 = key 49)]",
    49,1,88,0.01) : pianokey2hz);
  pianokey2hz(x) = 440.0*pow(2.0, (x-49.0)/12); // piano key 49 = A440 (also defined in effect.lib)
  detune1 = 1 + 0.01 * knob_group(
    vslider("[3] Detuning 1 [unit:%%] [style:knob]
      [tooltip: Percentange frequency-shift up or down for second oscillator]",
      -0.1,-10,10,0.01));
  detune2 = 1 + 0.01 * knob_group(
    vslider("[4] Detuning 2 [unit:%%] [style:knob]
[tooltip: Percentange frequency-shift up or down for third detuned oscillator]",
    +0.1,-10,10,0.01));
  portamento = knob_group(
    vslider("[5] Portamento [unit:sec] [style:knob]
      [tooltip: Portamento (frequency-glide) time-constant in seconds]",
      0.1,0.01,1,0.001));
  sfreq = freq : smooth(tau2pole(portamento));
  tone = (amp/3) * 
    (sawtooth(sfreq) + sawtooth(sfreq*detune1) + sawtooth(sfreq*detune2));
  signal = amp * select2(ei, select2(ss, tone, pink_noise), _);
  checkbox_group(x) = knob_group(vgroup("[6] Alternate Signals",x));
  ss = checkbox_group(checkbox("[0] 
[tooltip: Pink Noise (or 1/f noise) is Constant-Q Noise, meaning that it has the same total power in every octave] Pink Noise Instead (uses only Amplitude control on the left)"));
  ei = checkbox_group(checkbox(
      "[1] External Input Instead (overrides Sawtooth/Noise selection above)"));
};
