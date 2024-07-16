function plot_Isurf
%Plots the current, voltage and radiance characteristics of PV
%Ambient temperature = 25C
%Format of lookup data is (radiance:temperature:voltage)
%Temperature and Radiance Levels depends on the stepsize used in pv lut generation.


%%% Enter Temperature and Radiance Levels here: %%%
T = 11            %Temperature Levels from 1 to 21 in range -25°C to 75 °C. T = 11 -> 25°C
radiance = 11     %radiance Level from 1 to 11 in range 0 to 1000W/m2


%LUT Data:
load('pv_lut.mat');

% Value ranges
voltage = [0:0.864:86.4];
sun = [0:100:1000];

%Plot the current surface
figure(1)
[A, V] = meshgrid(sun, voltage);
current_data = transpose(squeeze(lut(:,T,:))); % Angenommen, dass dies korrekt umgeformt wurde zu passender Größe
surf(A, V, current_data);
xlabel('Radiance (W/m2)', 'Fontsize', 12)
ylabel('Voltage (V)', 'Fontsize', 12)
zlabel('Current (A)', 'Fontsize', 12)
set(gca, 'FontSize', 12)
