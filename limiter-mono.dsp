declare name "limiter1176" ;

el = library("effect.lib");

//ratio = vslider("ratio", 4, 1, 20, 0.01);
//thresh = vslider("thresh", -6, -90, 0, 0.1);
//attack = vslider("attack", 0.0008, 0, 0.2, 0.0001);
//release = vslider("release", 0.5, 0, 1, 0.0001);

// process = limiter_1176_R4_mono;
// process = hgroup("limiter", el.compressor_mono(ratio, thresh, attack, release));
process = _ : el.compressor_mono(4, -6, 0.0008, 0.5);
