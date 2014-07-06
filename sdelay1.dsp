declare name 	"SmoothDelay1";
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

process = (+ : sdelay(N, interp, dtime)) ~ *(fback)
        with {
		N 		= int(2^19); 
                dtime	= hslider("delay_s[unit:s]", 0, 0, 0.5, 0.001)*SR;
                fback 	= hslider("feedback_01[style:knob]",0,0,1,0.001);
                interp 	= hslider("interpolation_s[style:knob]",0.01,0.001,0.1,0.001)*SR;
	};


