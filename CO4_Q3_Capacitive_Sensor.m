
clc;
clear;
close all;

%% CAPACITIVE SENSOR SIMULATION

% Physical constants and sensor dimensions
epsilon0 = 8.854e-12;       % Permittivity of free space (F/m)
A = 0.01;                   % Plate area (m^2)

% Distance between plates (mm)
distance_mm = 1:0.5:10;
distance_m = distance_mm .* 1e-3;

% Relative dielectric constants
er_air = 1.0;
er_plastic = 2.5;
er_glass = 5.0;

% Calculate capacitance in pF
C_air = (epsilon0 .* er_air .* A ./ distance_m) .* 1e12;
C_plastic = (epsilon0 .* er_plastic .* A ./ distance_m) .* 1e12;
C_glass = (epsilon0 .* er_glass .* A ./ distance_m) .* 1e12;

%% Display results
fprintf('CAPACITIVE SENSOR SIMULATION\n\n');
fprintf('Plate area: %.4f m^2\n', A);
fprintf('Dielectric constants: Air=%.1f, Plastic=%.1f, Glass=%.1f\n\n', ...
    er_air, er_plastic, er_glass);

fprintf('Distance(mm)   Air(pF)   Plastic(pF)   Glass(pF)\n');

for i = 1:length(distance_mm)
    fprintf('%8.2f       %7.3f     %7.3f       %7.3f\n', ...
        distance_mm(i), C_air(i), C_plastic(i), C_glass(i));
end

%% Graph 1: Capacitance vs Distance
figure;

plot(distance_mm, C_air, 'b-o', 'LineWidth', 2);
hold on;
plot(distance_mm, C_plastic, 'r-s', 'LineWidth', 2);
plot(distance_mm, C_glass, 'g-^', 'LineWidth', 2);

xlabel('Distance Between Plates (mm)');
ylabel('Capacitance (pF)');
title('Capacitance vs Distance for Different Dielectrics');

legend('Air', 'Plastic', 'Glass', 'Location', 'northeast');
grid on;

%% Graph 2: Capacitance vs Dielectric Constant
er_values = 1:0.5:5;
fixed_distance = 5e-3;

C_dielectric = (epsilon0 .* er_values .* A ./ fixed_distance) .* 1e12;

figure;

plot(er_values, C_dielectric, 'm-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Relative Dielectric Constant');
ylabel('Capacitance (pF)');
title('Effect of Dielectric Constant on Capacitance');

grid on;

%% Simulation summary
fprintf('\nAt 5 mm distance:\n');
fprintf('Air capacitance: %.3f pF\n', ...
    epsilon0*er_air*A/fixed_distance*1e12);
fprintf('Plastic capacitance: %.3f pF\n', ...
    epsilon0*er_plastic*A/fixed_distance*1e12);
fprintf('Glass capacitance: %.3f pF\n', ...
    epsilon0*er_glass*A/fixed_distance*1e12);

fprintf('\nSimulation completed successfully.\n');