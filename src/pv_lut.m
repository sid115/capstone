%%% VARIABLES %%%

tn = 25; % nominal temperature in °C
astc = 1000; % solar radiation at STC in W/m^2
b = 0.09; % fit parameter
vstep = 100; % number of voltage steps
astep = 100; % number of radiation steps

% PV module data
voc = 86.4; % open circuit voltage in V
isc = 6.14; % short circuit current in A
vmpp = 70.4; % voltage at maximum power point in V
impp = 5.58; % current at maximum power point in A
tci = 0.05; % temperature coefficient of Isc in 1/°C - Estimated Values from: https://www.eco-greenenergy.com/temperature-coefficient-of-solar-pv-module/
tcv = -0.3; % temperature coefficient of Voc in 1/°C - Estimated Values from: https://www.eco-greenenergy.com/temperature-coefficient-of-solar-pv-module/

- currents get negative with higher voltages -

- TC_I = 0.05%/K, TC_V = -0.3%/K

% Open module voltages
vmin = 77.76; % minimum open module voltage in V - estimated Value: 90% * Vmax
vmax = voc; % maximum open module voltage in V
amin = 200; % minimum solar radiation in W/m^2  - 200W/m² as recommanded in the Boeke Paper
amax = astc; % maximum solar radiation in W/m^2

% Ranges
a = linspace(amin, amax, astep); % solar radiations in W/m^2
t = [tn]; % temperatures in °C
v = linspace(0, vmax, vstep); % voltages in V

%%% FUNCTIONS %%%

taui = @(_t) 1 + tci * (_t - tn);
tauv = @(_t) tcv * (_t - tn);

function current = i(_a, _t, _v, b, astc, isc, tci, tn, tcv, vmax, vmin, amax, amin, taui, tauv)
    vdelta = vmax - vmin;
    adelta = amax - amin;
    exponent = _v / (b * (1 + (vdelta / vmax) * ((_a - amax) / adelta)) * (vmax + tauv(_t))) - 1 / b;
    current = _a / astc * isc * taui(_t) * (1 - exp(exponent)) / (1 - exp(-1 / b));
end

%%% LOOKUP TABLE COMPUTATION %%%

[A, T, V] = ndgrid(a, t, v);
I = arrayfun(@(_a, _t, _v) i(_a, _t, _v, b, astc, isc, tci, tn, tcv, vmax, vmin, amax, amin, taui, tauv), A, T, V);
P = V .* I;

% Reshape the results into a 2-D matrix (lookup table)
lut = [A(:), T(:), V(:), I(:), P(:)];

%%% OUTPUT %%%

csvwrite('../out/pv_lut.csv', lut); % this only works on UNIX systems