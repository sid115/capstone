%%% VARIABLES %%%

% Constants
tN = 25; % nominal temperature in °C
astc = 1000; % solar radiation at STC in W/m^2
b = 1; % fit parameter

% PV module data
voc = 86.4; % open circuit voltage in V
isc = 6.14; % short circuit current in A
vmpp = 70.4; % voltage at maximum power point in V
impp = 5.58; % current at maximum power point in A
tci = 0; % temperature coefficient of Isc in 1/°C
tcv = 0; % temperature coefficient of Voc in 1/°C

% Open module voltages in two operation points
vmin = 0; % minimum open module voltage in V
vmax = voc; % maximum open module voltage in V
amin = 0; % minimum solar radiation in W/m^2
amax = astc; % maximum solar radiation in W/m^2

% Ranges
a = linspace(amin, amax, 5); % solar radiations in W/m^2
t = [tN]; % temperatures in °C
v = linspace(vmin, vmax, 1); % voltages in V

%%% FUNCTIONS %%%

taui = @(_t) 1 + tci * (_t - tN); % % formula (1)
tauv = @(_t) tcv * (_t - tN); % formula (2)

function current = i(_a, _t, _v) % formula (3)
    vdelta = vmax - vmin;
    adelta = amax - amin;
    exponent = _v / (b * (1 + vdelta / vmax * (_a - amax) / adelta) * (vmax + tauv(_t))) - 1 / b;
    current = _a / astc * isc * taui(_t) * (1 - exp(exponent)) / (1 - exp(-1 / b));
end

%%% COMPUTATION OF LOOKUP TABLE %%%

lookup_table = [];
for _a = a
    for _t = t
        for _v = v
            _i = i(_a, _t, _v); % compute current
            _p = _v * _i; % compute power
            lookup_table = [lookup_table; _a, _t, _v, _i, _p];
        end
    end
end

%%% DISPLAY AND SAVE LOOKUP TABLE %%%
disp("Solar Radiation (a), Temperature (T), Voltage (V), Current (I), Power (P)");
disp(lookup_table);
csvwrite('pv_lut.csv', lookup_table);
