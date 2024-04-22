# Single-Phase MPP-Tracking of a PV Generator on a Resistor

> A Markdown cheat sheet can be found [here](https://images.datacamp.com/image/upload/v1697798108/Markdown_Cheat_Sheet_9657d9746f.png).

Essential data of the PV generator with 4 modules in series, all at STC:

- $U_{PV,oc} = 86.4 V$
- $U_{PV,MPP} = 70.4 V$ 
- $I_{PV,sc} = 6.14 A$
- $I_{PV,MPP} = 5.68 A$
- $P_{PV,MPP} = 400 W$

## Steps

1. Modelling a PV generator depending on irradiation and temperature in PLECS
    - Lookup-table using PLECS block
1. Setting up a simulation environment: Refining template and extending it with MPP algorithm
    - Maximize power, voltage not important
    - Measure average power over up to 3 periods via effective capacitor current, $\rightarrow$ sensor can also be used for load drop detection 
    - Transformer ratio?
    - Operating points for different modulation degrees m from 0 (idle) to 1 (short circuit) (ramp m with PV generator connected should return characteristic curve)
1. Load drop detection: Smart shutdown and start-up routine with detection if load is present.
    - System can oscillate (LC undamped)
    - only with sensor for capacitor voltage and current
1. Getting acquainted with code generation for STM32
1. Research for a platform / concept for Auxiliaury Power
    - H-bridge, which can be easily connected to sensors and STM

## PLECS

1. Install [PLECS Standalone](https://www.plexim.com/download/standalone).
1. Get a [Student License](https://plexim.com/store/students). Use your smail address (...@smail.th-koeln.de).
