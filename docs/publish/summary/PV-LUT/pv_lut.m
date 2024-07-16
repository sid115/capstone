%%% PV LUT GENERATION %%%
% This script generates a lookup table for a PV module based
% on the mathematical model of U.Boeke publiched in
% "A simple model of photovoltaic module electric characteristics".

% USAGE:
% 1. Set the parameters in the "PV module data" section below
% 2. Run the script with Octave or Matlab (tested with Octave 7.3.0)
% 3. The lookup table is saved in the "out" folder as "pv_lut.mat"
% (4. Adjust the fit parameter "b" under "Lut Variables" according to the instructions in the Boeke Paper and rerun the script)

% NOTES:
% 1. The lookup table can be ploted with the "plot_Isurf.m" script (tested with Octave 7.3.0)
% 2. to print the lookup table contents use "look_into_binary_lut.m" script

%%% PV MODULE DATA %%%
n = 4;              % number of modules in series
voc = 21.6;         % open circuit voltage in V
isc = 6.14;         % short circuit current in A
vmpp = 17.6;        % voltage at maximum power point in V
impp = 5.58;        % current at maximum power point in A
vmin = 0.9*n*voc;   % minimum open module voltage in V - in this case: not listed in datasheet -> estimate Value: 90% * Vmax
tci = 0.081;        % temperature coefficient of Isc in 1/°C
tcv = -0.37;        % temperature coefficient of Voc in 1/°C

%%% LUT VARIABLES %%%
tn = 25;        % nominal temperature in °C
tmin = -25;     % minimum temperature in °C
tmax = 75;      % maximum temperature in °C
astc = 1000;    % solar radiation at STC in W/m^2
amin = 200;     % minimum solar radiation in W/m^2  - 200W/m² as recommanded in the Boeke Paper
amax = astc;    % maximum solar radiation in W/m^2
vmpp *= n;      % voltage at maximum power point in V
vmax = n*voc;   % maximum open module voltage in V

b = 0.09;       % fit parameter (adjust these according to the instructions in the Boeke Paper)

vstep = 101;    % number of voltage steps
astep = 11;     % number of radiation steps
tstep = 21;     % number of temperature steps

% Ranges
a = linspace(0, amax, astep);   % solar radiations in W/m^2
t = linspace(tmin,tmax,tstep);  % temperatures in °C
v = linspace(0, vmax, vstep);   % voltages in V

%%% FUNCTIONS %%%

taui = @(_t) 1 + tci/100 * (_t - tn);
tauv = @(_t) tcv * (_t - tn);

function current = i(_a, _t, _v, b, astc, isc, tci, tn, tcv, vmax, vmin, amax, amin, taui, tauv)
    vdelta = vmax - vmin;
    adelta = amax - amin;
    exponent = _v / (b * (1 + (vdelta / vmax) * ((_a - amax) / adelta)) * (vmax + tauv(_t))) - 1 / b;
    current = _a / astc * isc * taui(_t) * (1 - exp(exponent)) / (1 - exp(-1 / b));
end

%%% LOOKUP TABLE COMPUTATION %%%

lut = zeros(length(a), length(t), length(v));

[A, T, V] = ndgrid(a, t, v);
lut = arrayfun(@(_a, _t, _v) i(_a, _t, _v, b, astc, isc, tci, tn, tcv, vmax, vmin, amax, amin, taui, tauv), A, T, V);

lut(lut < 0) = 0;   % set all negative Values to zero


%%% OUTPUT %%%
save('-V7', "pv_lut.mat",'lut'); % V7 to ensure compatibility with plecs
