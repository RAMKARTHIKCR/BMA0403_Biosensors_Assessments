
clc;
clear;
close all;

%% MICROWAVE DOPPLER SENSOR SIMULATION

% Radar parameters
c = 3e8;             % Speed of electromagnetic wave (m/s)
f0 = 10e9;            % Transmitted microwave frequency (10 GHz)

% Calculate wavelength
lambda = c / f0;

% Object velocities (m/s)
velocity = 0:1:10;

% Calculate Doppler frequency shift
% Monostatic radar: reflected signal travels to and from the object
doppler_shift = (2 .* velocity .* f0) ./ c;

% Convert frequency shift to kHz
doppler_kHz = doppler_shift ./ 1000;

%% Display results
fprintf('MICROWAVE DOPPLER SENSOR SIMULATION\n\n');
fprintf('Transmitted Frequency: %.2f GHz\n', f0/1e9);
fprintf('Wavelength: %.4f m\n\n', lambda);

fprintf('Velocity (m/s)   Doppler Shift (Hz)   Doppler Shift (kHz)\n');

for i = 1:length(velocity)
    fprintf('%8.2f          %10.2f             %8.4f\n', ...
        velocity(i), doppler_shift(i), doppler_kHz(i));
end

%% Graph 1: Velocity vs Doppler Frequency Shift
figure;

plot(velocity, doppler_kHz, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Object Velocity (m/s)');
ylabel('Doppler Frequency Shift (kHz)');
title('Velocity vs Doppler Frequency Shift');

grid on;

%% Graph 2: Doppler Shift Comparison
figure;

bar(velocity, doppler_kHz);

xlabel('Object Velocity (m/s)');
ylabel('Doppler Frequency Shift (kHz)');
title('Doppler Frequency Shift at Different Velocities');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum velocity: %.2f m/s\n', max(velocity));
fprintf('Maximum Doppler shift: %.2f Hz\n', max(doppler_shift));
