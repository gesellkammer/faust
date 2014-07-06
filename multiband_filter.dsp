declare name        "multibandfilter";
declare version     "1.0";
declare author      "Grame";
declare license     "BSD";
declare copyright   "(c) GRAME 2006";

//---------------------------Multi Band Filter-----------------------------
//
//-------------------------------------------------------------------------

process         = hgroup("Multi Band Filter",
                            seq( i, 7, vgroup("[%i] peak%i", component("bandfilter.dsp").bandfilter(200*(1+i))) )
                        );
