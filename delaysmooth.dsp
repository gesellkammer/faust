declare name 	"DelaySmooth";
declare author 	"Yann Orlarey";
declare copyright "Grame";
declare version "1.0";
declare license "STK-4.3";


//--------------------------process----------------------------
//
// 	A stereo smooth delay with a feedback control
//  
//	This example shows how to use sdelay, a delay that doesn't
//  click and doesn't transpose when the delay time is changed
//-------------------------------------------------------------

import("music.lib");

process = par(i, 1, voice)
	with 
	{ 
                N = int(96000*3);  // 3 seconds at 96000, 6 seconds at 48000       
                voice = (+ : sdelay(N, interp, dtime)) ~ *(fback);
		
		interp 	= hslider("interpolation[unit:s][style:knob]",0.01,0,1,0.001)*SR; 
		dtime	= hslider("delay[unit:s][style:knob]", 0, 0, 4, 0.1)*SR;
		fback 	= hslider("feedback[style:knob]",0,0,1,0.001); 
	};


