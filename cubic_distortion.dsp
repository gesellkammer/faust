declare name "Cubic Distortion";
declare author "Julius O. Smith (jos at ccrma.stanford.edu)";
declare copyright "Julius O. Smith III";
declare license "STK-4.3"; // Synthesis Tool Kit 4.3 (MIT style license)
declare reference "http://asa.aip.org/publications.html";

fl = library("filter.lib");
el = library("effect.lib");
process = _ : el.cubicnl_nodc(drive:fl.smooth(0.999),offset:fl.smooth(0.999))
        with {
             cnl_group(x)  = vgroup("CUBIC NONLINEARITY cubicnl [tooltip: Reference:
                           https://ccrma.stanford.edu/~jos/pasp/Cubic_Soft_Clipper.html]", x);
             slider_group(x)  = cnl_group(hgroup("[1]", x));
             drive = slider_group(hslider("[1] Drive [tooltip: Amount of distortion]", 0, 0, 1, 0.01));
             offset = slider_group(hslider("[2] Offset [tooltip: Brings in even harmonics]", 0, 0, 1, 0.01));
};

