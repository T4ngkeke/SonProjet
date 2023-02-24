import("stdfaust.lib");


transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
	de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
	maxDelay = 1000;//2^15
	i = 1 - pow(2, s/12);
	d = i : (+ : +(w) : fmod(_,w)) ~ _;
};



pitchshifter=vgroup("Pitch Shifter",transpose(1000,10,6));

//filtre à ajouter

process (x)=x:pitchshifter; 


