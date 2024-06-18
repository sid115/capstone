#include <stdlib.h>
#include <math.h>

float m = 0; // modulation degree
float m_step = 0; // value by which m is increased or reduced
float direction = 1; // -1 (down) or 1 (up)
float i_C = 0; // capacitor current in A
float i_C_pre = 0; // capacitor current of previous iteration
int counter = 0; //Count steps of setting back to 1
int sweepCounter = 0;	//step counter, to trigger the sweep
int sweepValue = 250;	//after how many counts the sweep will be done
float sweepMax = 0;		//i_C measured in the sweep
float sweepMaxOld = 0;	//old i_C value to compare
float mMax = 0;			//m at which i_C is max
