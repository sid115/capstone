# Questions
1. Power calculation at load
    - How do we measure power with only one current sensor?
        > Simulation shows that at peak power, v_C and therefore i_C are at their maximum. If we let m follow i_C, we should oscillate around P_max. EDIT: This kinda works, but power slowly decreases over time. Let's discuss this on Thursday. -Sid
1. PV simulation
    - What are the STC?
        > STC is an industry-wide standard to indicate the performance of PV modules and specifies a cell temperature of 25°C and an irradiance of 1 kW/m2 with an air mass (AM) of 1.5 spectra. AM 1.0 signifies that the sun is directly overhead, at its zenith, and the sunlight travels through one atmosphere thickness to reach the surface of the earth. An air mass of 1.5 spectra signifies conditions where the sun is at an angle and the sunlight travels through 1.5 times the atmosphere thickness before reaching the Earth's surface. -Sid

# TODO
- PV sim: adjust PV module parameters to match ours. I just grabbed a random working simulation from the internet that was dependent on temperature and irradiance and had implemented a lookup table for the IV curve.
- MPPT: max power is not just dependent on i_C_max.
