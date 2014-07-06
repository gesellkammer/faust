import("music.lib");
import("oscillator.lib");

freq = hslider("freq", 20, 0, 18000, 1); freqfine =
hslider("freqfine", 0, 0, 20, 0.1); duty = hslider("duty", 0.5, 0, 1,
0.01); wet = hslider("wet", 0, 0, 1, 0.01); lag = hslider("lag", 0.1,
0, 1, 0.001);

amduty(f0, ffine, duty, wet, lag) = _,_:(_*env,_*env) with {
     f = max(f0 + ffine, 0);
     env = lf_pulsetrainpos(f, duty) * wet + (1-wet) : smooth(tau2pole(lag));
};

/*
func = {|freq=20, freqfine=0, duty=0.5, base=0.0, gain=1, lagratio=0.1|
     var a0 = AudioIn.ar(1);
     var a1 = AudioIn.ar(2);
     var f = max(freq + freqfine, 0);
     var env = (LFPulse.ar(f, 0, duty) * gain + base
               ).lag(1/f * lagratio);
     Out.ar(0, [a0*env, a1*env]);
};
*/

process = vgroup("amduty", amduty(freq, freqfine, duty, wet, lag));
