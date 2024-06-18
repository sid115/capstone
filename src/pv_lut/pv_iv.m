%%% READ CSV DATA %%%

filename = '../../out/pv_lut.csv'; % this only works on UNIX systems
data = dlmread(filename, ',');

% Extract columns
a = data(:, 1);
t = data(:, 2);
v = data(:, 3);
i = data(:, 4);
p = data(:, 5);

%%% DETERMINE RADIATION LEVELS %%%

amax = max(a);
a75 = amax * 0.75;
a50 = amax * 0.5;

% Find the closest available a to 75% and 50% of the max
[~, idx75] = min(abs(a - a75));
[~, idx50] = min(abs(a - a50));
a75 = a(idx75);
a50 = a(idx50);

%%% FILTER DATA FOR SPECIFIC RADIATION %%%

% Data for highest a
idxmax = a == amax & t == 25;
vmax = v(idxmax);
imax = i(idxmax);
pmax = p(idxmax);

% Data for 75% a
idx75 = a == a75 & t == 25;
v75 = v(idx75);
i75 = i(idx75);
p75 = p(idx75);

% Data for 50% a
idx50 = a == a50 & t == 25;
v50 = v(idx50);
i50 = i(idx50);
p50 = p(idx50);

%%% PLOT IV CURVES AND POWER CURVES %%%

figure('visible', 'off');
hold on;

% Create plotyy for each set of data
[ax1, h11, h12] = plotyy(vmax, imax, vmax, pmax);
[ax2, h21, h22] = plotyy(v75, i75, v75, p75);
[ax3, h31, h32] = plotyy(v50, i50, v50, p50);

set(h11, 'Color', 'b', 'LineWidth', 2);
set(h12, 'Color', 'b', 'LineStyle', '--', 'LineWidth', 2);
set(h21, 'Color', 'r', 'LineWidth', 2);
set(h22, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
set(h31, 'Color', 'g', 'LineWidth', 2);
set(h32, 'Color', 'g', 'LineStyle', '--', 'LineWidth', 2);

xlabel('Voltage / V');
axes(ax1(1)); ylabel('Current / A');
axes(ax1(2)); ylabel('Power / W');
title('IV and Power Curves at Different Radiation Levels');
lgd = legend([h11; h21; h31; h12; h22; h32], {'I @ 100%', 'I @ 75%', 'I @ 50%', 'P @ 100%', 'P @ 75%', 'P @ 50%'});
set(lgd, 'Location', 'southwest');
grid on;

hold off;

% Save the figure
print('../out/pv_iv.png', '-dpng'); % this only works on UNIX systems
