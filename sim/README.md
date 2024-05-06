# Questions
1. Power calculation at load
    - How do we measure power with only one current sensor?
        > Simulation shows that at i_C_abs_avg roughly follows P_R. -Sid
1. PV simulation
    - What are the STC?
        > STC is an industry-wide standard to indicate the performance of PV modules and specifies a cell temperature of 25°C and an irradiance of 1 kW/m2 with an air mass (AM) of 1.5 spectra. AM 1.0 signifies that the sun is directly overhead, at its zenith, and the sunlight travels through one atmosphere thickness to reach the surface of the earth. An air mass of 1.5 spectra signifies conditions where the sun is at an angle and the sunlight travels through 1.5 times the atmosphere thickness before reaching the Earth's surface. -Sid
1. MPPT (lookup)
    - P peaks at m_target = 0.39, but decreases to a stable P = 1274 W while m = m_target. Why?
        > This is probably related to the PV module model. Through simulation, I was able to rule out other parameters. -Sid

# TODO
- pv_lut.m: How do I import .mat files into Plecs? The pv base model just loads the included .mat file. The init code inside the PV system block seems to be matlab code, but I wonder how the lut is formatted so everything works. -Sid
