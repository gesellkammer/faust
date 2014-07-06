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

process = par(i, 1, voice)
	with 
	{ 
		voice 	= (+ : sdelay(N, interp, dtime)) ~ *(fback);
		N 		= int(2^19); 
                dtime	= hslider("[0] delay[unit:ms][style:knob]", 0, 0, 5000, 0.1)*SR/1000.0;		
                fback 	= hslider("[1] feedback[style:knob]",0,0,100,0.1)/100.0;                 
                interp 	= hslider("[2] interpolation[unit:ms][style:knob]",10,1,100,0.1)*SR/1000.0; 
		
		
	};


