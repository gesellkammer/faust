declare name        "tapiir";
declare version     "1.0";
declare author      "Grame";
declare license     "BSD";
declare copyright   "(c) GRAME 2006";

//======================================================
//
//                  TAPIIR
//    (from Maarten de Boer's Tapiir)
//
//======================================================

import("music.lib");


dsize       = 524288;



// user interface
//---------------


tap(n)      = vslider("tap %n", 0,0,1,0.00001);
in(n)       = vslider("input %n", 1,0,1,0.00001);
gain        = vslider("gain", 1,0,1,0.00001);
del         = vslider("delay (ms)", 0, 0, 2000, 1) / 1000 * SR;
delsamp     = vslider("+delay(samp)", 0, 0, 48000, 1);


// mixer and matrix
//-----------------------------------------------------------

mixer(taps,lines)   =   par(i,taps,*(tap(i))),
                        par(i,lines,*(in(i)))
                        :>  *(gain);


matrix(taps,lines)  = ( bus(lines+taps)
                        <: tgroup("",
                                par(i, taps,
                                    hgroup("Tap %i",
                                        mixer(taps,lines) : delay(dsize,del+delsamp))))
                      ) ~ bus(taps);


// tapiir
//--------

tapiir(taps,lines)  =   vgroup("Tapiir",
                            bus(lines)
                            <: (matrix(taps,lines), bus(lines))
                            <: vgroup( "outputs", par( i, lines, hgroup("output %i", mixer(taps,lines)) ) )
                        );



process         =  tapiir(6,2);
