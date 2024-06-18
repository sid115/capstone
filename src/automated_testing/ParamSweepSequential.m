%%% BEGIN USER DEFINITIONS %%%

%% Paths
modelPath = 'pv_lut';        % PLECS model path (name of simulation file)
scopePath = 'Scope';         % Scope path that contains the signal to be measured relative to the model path
outPath = '../out/automated_testing'; % Output path for the CSV and BMP files

% Ensure outPath directory exists
if ~exist(outPath, 'dir')
    mkdir(outPath);
end

%% Parameters to sweep and their ranges
paramNames = {'fPWM', 'fN'}; % Names of the parameters to sweep
paramRanges = {40000:1000:41000, 500:100:600}; % Corresponding ranges for each parameter (start:step:end)

% Signal to measure and analysis settings
signal = 8;                 % Signal number in scope. Count through every signal in every plot.
timeInterval = [0.75, 0.8];    % Time interval for the analysis. Values are in seconds.

% Output files
bmp = true;                 % Export BMP files

% Function that lets the user perform additional operations on the measured scope data
function customOperations(scopeData, paramRanges, paramNames, outPath)
    % Average the signal over the time interval
    avgSignal = arrayfun(@(x) mean(x.signal), scopeData);
    
    % Ensure avgSignal is a column vector
    avgSignal = avgSignal(:);
    
    % Print a table with the parameter values and the average signal
    fprintf('\nParameter sweep results:\n');
    fprintf('  %s\t%s\tAverage signal\n', paramNames{1}, paramNames{2});
    for ix = 1:numel(scopeData)
        fprintf('  %g\t%g\t%g\n', scopeData(ix).paramValues(1), scopeData(ix).paramValues(2), avgSignal(ix));
    end

    % Print the best and worst average signals
    [bestSignal, bestIx] = max(avgSignal);
    [worstSignal, worstIx] = min(avgSignal);
    fprintf('\nBest average signal:\n');
    fprintf('  %s\t%s\tAverage signal\n', paramNames{1}, paramNames{2});
    fprintf('  %g\t%g\t%g\n', scopeData(bestIx).paramValues(1), scopeData(bestIx).paramValues(2), bestSignal);
    fprintf('\nWorst average signal:\n');
    fprintf('  %s\t%s\tAverage signal\n', paramNames{1}, paramNames{2});
    fprintf('  %g\t%g\t%g\n', scopeData(worstIx).paramValues(1), scopeData(worstIx).paramValues(2), worstSignal);
end

%%% END USER DEFINITIONS %%%

%%% BEGIN SCRIPT %%%

% Clear the Octave console
plecs('clc');

% Set the scope path to the full path
scopePath = [modelPath '/' scopePath];

% Generate all combinations of parameter values
[paramGrid{1:numel(paramRanges)}] = ndgrid(paramRanges{:});
paramCombos = cell2mat(cellfun(@(x) x(:), paramGrid, 'UniformOutput', false));

% Number of parameter combinations
numCombos = size(paramCombos, 1);

% Initialize data struct to store simulation results
scopeData = struct();

% Start of the parameter sweep
fprintf('Starting parameter sweep for %s...\n', strjoin(paramNames, ', '));

% Iterate over parameter combinations
for ix = 1:numCombos
    % Verbose output: Current parameter values
    comboStr = strjoin(arrayfun(@(p, v) sprintf('%s = %g', paramNames{p}, paramCombos(ix, p)), 1:numel(paramNames), 'UniformOutput', false), ', ');
    fprintf('\nSetting %s\n', comboStr);

    % Set the parameters of the specified components
    opts = struct('ModelVars', cell2struct(num2cell(paramCombos(ix, :)), paramNames, 2));

    % Clear previous simulation data (if applicable)
    plecs('scope', scopePath, 'ClearTraces');

    % Start simulation
    fprintf('  Running simulation...\n');
    plecs('simulate', opts);

    % Retrieve scope data and export it to a CSV and optionally BMP file
    fprintf('  Retrieving scope data...\n');
    fileName = [outPath '/' modelPath '_' strjoin(arrayfun(@(p) sprintf('%s_%g', paramNames{p}, paramCombos(ix, p)), 1:numel(paramNames), 'UniformOutput', false), '_')];
    plecs('scope', scopePath, 'ExportCSV', [fileName '.csv']);
    if bmp
        plecs('scope', scopePath, 'ExportBitmap', [fileName '.bmp']);
    end

    % Load the CSV file and extract the signal data to a struct
    data = csvread([fileName '.csv']);
    scopeData(ix).paramValues = paramCombos(ix, :);
    scopeData(ix).time = data(:, 1);  % First column is time
    scopeData(ix).signal = data(:, signal+1);

    % Only consider the time interval specified
    timeIx = scopeData(ix).time >= timeInterval(1) & scopeData(ix).time <= timeInterval(2);
    scopeData(ix).time = scopeData(ix).time(timeIx);
    scopeData(ix).signal = scopeData(ix).signal(timeIx);
end

% Run custom operations
fprintf('  Custom operations...\n');
customOperations(scopeData, paramRanges, paramNames, outPath);

fprintf('\nParameter sweep completed. Results written to %s\n', outPath);

%%% END SCRIPT %%%
