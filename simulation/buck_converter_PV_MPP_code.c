// this code is copied from the C code block in buck_converter_PV_MPP.plecs
// rearranged for better understanding

float a = 0; // duty cycle ("m")
float MPP_Step = 0; // step size, by which a is increased or decreased each iteration
float direction = 1; // 1: increase a -1: decrease a
float direction_k_minus_1 = 1; // direction value from last iteration
float U_load = 0; // load resistor voltage
float I_load = 0; // load resistor current
float P_load_k_minus_1 = 0; // load resistor power from last iteration
float P_load = 0; // current load resistor power

// executed each sample time (there are major and minor time steps??)
void main(){
    output();
    update();
}

// specified functions in the C code block //
void output(){
    // read inputs
    U_load = InputSignal(0,0); // read resistor voltage
    I_load = InputSignal(0,1); // read resistor current
    MPP_Step = InputSignal(0,2); // read step size parameter

    P_load = (U_load * I_load); // calculate output power

    // switch direction, if power at previous sample time was greater than current power
    if (P_load_k_minus_1 >= P_load)
    direction = - direction_k_minus_1;
    else
    direction = direction_k_minus_1;

    // write outputs
    OutputSignal(0,0) = a + MPP_Step*direction; // m value for PWM
    OutputSignal(0,1) = P_load; // power value output to scope
}

void update(){
    // update previous values for next iteration
    a = a + MPP_Step*direction;
    P_load_k_minus_1 = P_load; 
    direction_k_minus_1 = direction;

    // limit duty cycle
    if (a<0)
    a = 0.01;
    if (a>1)
    a = 0.99;
}
