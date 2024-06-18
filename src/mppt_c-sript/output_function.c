/* adopt values */
i_C_pre = i_C;

/* read input */
i_C = InputSignal(0,0);

/* change direction if previous value was better */
if (i_C_pre > i_C) direction *= -1; // change direction
// else keep direction -> do nothing

//normal addapting of m
if(sweepCounter <sweepValue){
	/* calculate new m */
	m += m_step * direction;

	/* restrict m */
	if (m < 0) m = 0.01;
	if (m > 1.0){
		m = 1.0;
		counter = counter+1;
	}
}

//reset all variables für the sweep
if(sweepCounter == sweepValue){
	m = 0;
	sweepMaxOld = 0;
	sweepMax = 0;
}
sweepCounter = sweepCounter +1;

//Sweep funkction
if(sweepCounter > sweepValue){
	m = m+0.05;
	//m can not be higher than 1, so reset the counter here
	if(m>=1.0){
		sweepCounter = 0;
		m=mMax;
		mMax = 0;
	}
	
	//compare the old an new i_C
	sweepMaxOld = sweepMax;
	sweepMax = InputSignal(0,0);
	if(sweepMax >= sweepMaxOld){
		mMax = m;
	}
}
	
/* output m */
OutputSignal(0,0) = m;
