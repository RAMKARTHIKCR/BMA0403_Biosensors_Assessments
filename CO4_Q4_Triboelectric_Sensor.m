
clc;
clear;
close all;

%% TRIBOELECTRIC ENERGY HARVESTING SIMULATION

% Illustrative model parameters
Vmax = 100;       % Maximum output voltage (V)
F0 = 5;           % Characteristic force (N)
f0 = 5;           % Characteristic frequency (Hz)

% Input ranges
force = 1:1:10;       % Contact force (N)
frequency = 1:1:10;   % Contact frequency (Hz)

% Simplified voltage model:
% Output increases with force and frequency, then approaches saturation.

%% Calculate voltage for different forces
fixed_frequency = 5;

voltage_force = Vmax .* ...
    (1 - exp(-force ./ F0)) .* ...
    (1 - exp(-fixed_frequency ./ f0));

%% Calculate voltage for different frequencies
fixed_force = 5;

voltage_frequency = Vmax .* ...
    (1 - exp(-fixed_force ./ F0)) .* ...
    (1 - exp(-frequency ./ f0));

%% Display results
fprintf('TRIBOELECTRIC SENSOR SIMULATION\n\n');

fprintf('Illustrative model parameters:\n');
fprintf('Maximum voltage: %.2f V\n', Vmax);
fprintf('Characteristic force: %.2f N\n', F0);
fprintf('Characteristic frequency: %.2f Hz\n\n', f0);

fprintf('Voltage variation with contact force\n');
fprintf('Fixed frequency: %.2f Hz\n\n', fixed_frequency);
fprintf('Force (N)     Output Voltage (V)\n');

for i = 1:length(force)
    fprintf('%5.2f             %8.3f\n', ...
        force(i), voltage_force(i));
end

fprintf('\nVoltage variation with frequency\n');
fprintf('Fixed force: %.2f N\n\n', fixed_force);
fprintf('Frequency (Hz)     Output Voltage (V)\n');

for i = 1:length(frequency)
    fprintf('%8.2f                %8.3f\n', ...
        frequency(i), voltage_frequency(i));
end

%% Graph 1: Effect of Contact Force
figure;

plot(force, voltage_force, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Contact Force (N)');
ylabel('Output Voltage (V)');
title('Effect of Contact Force on Triboelectric Output');

grid on;

%% Graph 2: Effect of Contact Frequency
figure;

plot(frequency, voltage_frequency, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Contact Frequency (Hz)');
ylabel('Output Voltage (V)');
title('Effect of Contact Frequency on Triboelectric Output');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum simulated voltage in force study: %.3f V\n', ...
    max(voltage_force));
fprintf('Maximum simulated voltage in frequency study: %.3f V\n', ...
    max(voltage_frequency));