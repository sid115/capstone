# PV lookup table

This script generates a lookup table for a photovoltaic panel. The table is used to calculate the current and voltage of the panel at a given temperature and irradiance.

## Usage

Make sure to be in the same directory as the script and run it with Octave.

```bash
octave pv_lut.m
```

> A UNIX-like shell is required to run the script.

A CSV file will be generated in the `out` directory. The file contains the lookup table for the panel.