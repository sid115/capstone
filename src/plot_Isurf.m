function plot_Isurf_2

%Plots the current, voltage, insolation characteristics of PV
%Ambient temperature = 25C
%Format of lookup data is (Sun:temperature:voltage)
%Temperature values are defined as 1: 0C, 2: 25C, 3: 50C

load('../out/pv_lut.mat');
T = 1
n = 1; %number of panels in array
voltage = [0:0.864:86.4];
Sun = [0:100:1000];
I1 = lut(11,T,:)    %Sun = 1.0, i.e. 1 kW/m2
I2 = lut(5,T,:);    %0.5 kW/m2

disp(lut(:,10,:))

%Plot the current surface
figure(1)
[A, V] = meshgrid(Sun, voltage);
current_data = transpose(squeeze(lut(:,T,:))); % Angenommen, dass dies korrekt umgeformt wurde zu passender Größe
surf(A, V, current_data);
xlabel('Radiance (W/m2)', 'Fontsize', 12)
ylabel('Voltage (V)', 'Fontsize', 12)
zlabel('Current (A)', 'Fontsize', 12)
set(gca, 'FontSize', 12)

##%Plot maximum nominal output characteristics
##figure(2)
##h = plot(voltage, I1, voltage, I2);
##set(h, 'Linewidth', 2);
##set(gca, 'FontSize', 14)
##grid on
##xlabel('Voltage (V)', 'Fontsize', 14)
##ylabel('Current (A)', 'Fontsize', 14)
##title('IV characteristic', 'Fontsize', 14);
##legend('1 kW/m2', '0.5 kW/m2')
##
##figure(3)
##h = plot(voltage, voltage.*I1', voltage, voltage.*I2');
##set(h, 'Linewidth', 2);
##set(gca, 'FontSize', 14)
##grid on;
##xlabel('Voltage (V)', 'Fontsize', 14)
##ylabel('Power (W)', 'Fontsize', 14)
##title('PV characteristic', 'Fontsize', 14);
##legend('1 kW/m2', '0.5 kW/m2')
