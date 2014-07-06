declare name 	"xvolpedal2";
declare author 	"Eduardo Moguillansky";
// declare copyright "Grame";
declare version "1.0";
declare license "STK-4.3";

import("music.lib");

smooth(c)	= *(1-c) : +~*(c);
adj1 = hslider("relative adjustment[0]", 0, 0, 1, 0.0001); 
vol0 = hslider("min value (dB)[1]", -120, -120, 0, 1) : db2linear : smooth(0.999);
vol1 = hslider("max value (dB)[2]", 0, -120, 0, 1) : db2linear : smooth(0.999);
curve = hslider("curve[3]", 3, 0.2, 20, 0.1);
adj = adj1 ^ curve;
vol = adj * (vol1 - vol0) + vol0 : smooth(0.999);

process = par(i, 2, voice)
        with 
	{
                voice = _ * vol;
	};


