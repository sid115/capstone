# Octave PLECS Simulation Script

This README provides instructions on how to use the provided Octave script to perform a parameter sweep simulation using PLECS. The script will vary specified parameters, run simulations, and analyze the resulting data.

## Setup

1. **Model File:** Ensure you have a PLECS model file (e.g., `pv_lut.plecs`) located in the same directory as the script or provide the correct path to it.

2. **Output Directory:** This script will save output files (CSV and BMP) in the specified output directory. Make sure you have write permissions for this directory.

## Script Configuration

### User Definitions
In the script, there is a section for user definitions that you need to configure:

1. **Paths:**
   ```matlab
   modelPath = 'pv_lut';        % Path to your PLECS model file
   scopePath = 'Scope';         % Path to the scope within the model
   outPath = '../out/automated_testing'; % Path to save the output files
   ```

2. **Parameters to Sweep:**
   Define the parameters to sweep and their ranges:
   ```matlab
   paramNames = {'fPWM', 'fN'}; % Names of the parameters
   paramRanges = {40000:1000:41000, 500:100:600}; % Ranges for each parameter
   ```

3. **Signal and Analysis Settings:**
   Define the signal to measure and the time interval for analysis:
   ```matlab
   signal = 8;                 % Signal number in scope
   timeInterval = [0.75, 0.8]; % Time interval in seconds
   ```

4. **Output Files:**
   Indicate if BMP files should be exported:
   ```matlab
   bmp = true;  % Export BMP files if true
   ```

### Custom Operations
Customize the function `customOperations` to perform additional operations on the measured scope data. The provided function averages the signal over the specified time interval and prints the results.

## Running the Script

Copy the script to *Simulation -> Simulation Scripts...* in PLECS and run it. The name of the script can be arbitrary. Select *Window -> Show Console* to view the script's output.

## Output

The script will generate the following outputs:

1. **CSV Files:** Containing scope data for each parameter combination.
2. **BMP Files:** (optional) Snapshot of the scope for each parameter combination.
3. **Console Output:** Prints a summary of the parameter sweep results, including the best and worst average signal values.

### Example Output Directory Structure
```
../out/automated_testing/
│
├── pv_lut_fPWM_40000_fN_500.csv
├── pv_lut_fPWM_40000_fN_500.bmp
├── pv_lut_fPWM_40000_fN_600.csv
├── pv_lut_fPWM_40000_fN_600.bmp
└── ...
```

## Notes

- Ensure the directory specified in `outPath` exists or the script will attempt to create it.
- The script clears the Octave console before starting the simulation.
- The scope path is derived from the model path and the scope name provided.

## Troubleshooting

- **File Paths:** Ensure that the paths provided for the model, scope, and output directory are correct.
- **Parameter Ranges:** Ensure the parameter ranges are correctly specified and within the valid range for your model.

If you encounter any issues, review the script's output for errors and adjust the configurations accordingly.
