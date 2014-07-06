declare name 	"xvolpedal";
declare author 	"Eduardo Moguillansky";
// declare copyright "Grame";
declare version "1.0";
declare license "STK-4.3";

import("music.lib");

smooth(c)	= *(1-c) : +~*(c);

process = par(i, 1, voice)
        with 
	{
                adj1 = hslider("relative adjustment", 0, 0, 1, 0.0001);
                vol0 = hslider("min value (dB)", -120, -120, 0, 1) : db2linear;
                vol1 = hslider("max value (dB)", 0, -120, 0, 1) : db2linear;
                curve = hslider("curve", 3, 0.2, 20, 0.1);
                adj = adj1 ^ curve;
                vol = adj * (vol1 - vol0) + vol0 : smooth(0.999);
                voice = _ * vol;
	};


