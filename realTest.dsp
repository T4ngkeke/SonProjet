import("stdfaust.lib");

B = button("Capture");	// Capture sound while pressed
I = int(B);				// convert button signal from float to integer
R = (I-I') <= 0;		// Reset capture when button is pressed
D = (+(I):*(R))~_;		// Compute capture duration while button is pressed: 0..NNNN0..MMM


capture = *(B) : (+ : de.delay(8*65536, D-1)) ~ *(1.0-B);

myCapture=vgroup("Audio Capture", capture);

pitchshifter=vgroup("Pitch Shifter",ef.transpose(1000,10,6));

process (x)=x:myCapture:pitchshifter; 

