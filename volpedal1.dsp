declare name 	"xvolpedal";
declare author 	"Eduardo Moguillansky";
// declare copyright "Grame";
declare version "1.0";
declare license "STK-4.3";

import("music.lib");
import("filter.lib");

// smooth(c)	= *(1-c) : +~*(c);

process = par(i, 1, voice)
with {
     
     adj1 = hslider("[4] relative adjustment", 1, 0, 1, 0.0001);
     vol0 = hslider("[0] min vol (dB)", -120, -120, 0, 1) : db2linear;
     vol1 = hslider("[1] max vol (dB)", 0, -120, 0, 1) : db2linear;
     smoothing = hslider("[3] smoothing (ms)", 4, 0, 20, 1);               
     curve = hslider("[2] curve", 3, 0.2, 20, 0.1);

     smoothfactor = tau2pole(smoothing/100);               
     adj = adj1 ^ curve;
     vol = adj * (vol1 - vol0) + vol0 : smooth(smoothfactor); // : smooth(smoothfactor);
     voice = _ * vol;
};	
		 
