declare name 	"volmatch";
declare author 	"Eduardo Moguillansky";
// declare copyright "Grame";
declare version "1.0";
declare license "STK-4.3";

import("music.lib");
fx = library("effect.lib");

smooth(c)	= *(1-c) : +~*(c);

// balance channel 2 to channel 1

process = par(i, 1, voice)
    with {
                att = hslider("attack [ms]", 1, 0, 500, 1)/1000;
                rel = hslider("release [ms]", 10, 0, 2000, 1)/1000;
                amp_smooth(sig) = sig : fx.amp_follower_ud(att, rel);
                balance(a, b) = b2,b2
                	with { 
                		b2 = b * (amp_smooth(a)/amp_smooth(b));
                	};
                voice = _,_ : balance;
    };     

             
