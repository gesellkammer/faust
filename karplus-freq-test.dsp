import("music.lib"); // define noise, SR, delay

// MIDI-driven parameters:
freq = nentry("freq Hz", 440, 20, 20000, 1); // Hz
gain = nentry("gain", 1, 0, 10, 0.01);    // 0 to 1
gate = button("gate");                    // 0 or 1

// Excitation gate (convert gate to a one-period pulse):
diffgtz(x) = (x-x') > 0;
decay(n,x) = x - (x>0)/n;
release(n) = + ~ decay(n);
trigger(n) = diffgtz : release(n) : > (0.0);

// Resonator:
average(x) = (x+x')/2;
P = SR/freq;
resonator = (+ : delay(4096, P)) ~ (average);

process = noise : *(gain) : *(gate : trigger(P)) 
                : resonator;

