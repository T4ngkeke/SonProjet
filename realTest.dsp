import("stdfaust.lib");

B = button("Capture");	// Capture sound while pressed
I = int(B);				// convert button signal from float to integer
R = (I-I') <= 0;		// Reset capture when button is pressed
D = (+(I):*(R))~_;		// Compute capture duration while button is pressed: 0..NNNN0..MMM

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
	de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
	maxDelay = 32768;//2^15
	i = 1 - pow(2, s/12);
	d = i : (+ : +(w) : fmod(_,w)) ~ _;
};


capture = *(B) : (+ : de.delay(8*32768, D-1)) ~ *(1.0-B);//2^15

myCapture=vgroup("Audio Capture", capture);

pitchshifter=vgroup("Pitch Shifter",ef.transpose(1000,10,6));

//filtre à ajouter

process (x)=x:myCapture:pitchshifter; 


