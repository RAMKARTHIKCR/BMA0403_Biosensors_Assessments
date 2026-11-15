
clc;
clear;
close all;

%% RADIOMETRIC ENERGY MEASUREMENT SYSTEM

% Sensor and circuit parameters
responsivity = 0.45;       % Photodiode responsivity (A/W)
sensor_area = 1e-4;        % Sensor area (m^2), 1 cm^2
feedback_resistance = 10; % Feedback resistance (ohms)
exposure_time = 2;         % Exposure duration (seconds)

% Incident irradiance (W/m^2)
irradiance = 0:100:1000;

%% Calculate radiant power
radiant_power = irradiance .* sensor_area;

%% Calculate photodiode current
photocurrent = responsivity .* radiant_power;

%% Signal conditioning: transimpedance amplifier
output_voltage = photocurrent .* feedback_resistance;

%% Calculate radiant energy
radiant_energy = radiant_power .* exposure_time;

%% Display results
fprintf('RADIOMETRIC ENERGY MEASUREMENT SIMULATION\n\n');

fprintf('Photodiode responsivity: %.2f A/W\n', responsivity);
fprintf('Sensor area: %.2f cm^2\n', sensor_area * 1e4);
fprintf('Feedback resistance: %.2f kohms\n', ...
    feedback_resistance / 1000);
fprintf('Exposure time: %.2f seconds\n\n', exposure_time);

fprintf(['Irradiance   Power      Current     Output V', ...
         '    Energy\n']);
fprintf(['(W/m^2)      (mW)       (uA)        (V)', ...
         '         (mJ)\n']);

for i = 1:length(irradiance)
    fprintf('%7.1f    %7.3f    %7.3f    %7.4f    %7.3f\n', ...
        irradiance(i), ...
        radiant_power(i)*1000, ...
        photocurrent(i)*1e6, ...
        output_voltage(i), ...
        radiant_energy(i)*1000);
end

%% Graph 1: Photocurrent vs Irradiance
figure;

plot(irradiance, photocurrent*1e6, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Incident Irradiance (W/m^2)');
ylabel('Photocurrent (uA)');
title('Photodiode Current vs Incident Irradiance');
grid on;

%% Graph 2: Output Voltage vs Irradiance
figure;

plot(irradiance, output_voltage, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Incident Irradiance (W/m^2)');
ylabel('Output Voltage (V)');
title('Signal Conditioned Output Voltage');
grid on;

%% Graph 3: Radiant Energy vs Irradiance
figure;

plot(irradiance, radiant_energy*1000, 'm-d', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Incident Irradiance (W/m^2)');
ylabel('Radiant Energy (mJ)');
title('Radiant Energy Measured During Exposure');
grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum radiant power: %.3f mW\n', ...
    max(radiant_power)*1000);
fprintf('Maximum photocurrent: %.3f uA\n', ...
    max(photocurrent)*1e6);
fprintf('Maximum output voltage: %.3f V\n', ...
    max(output_voltage));
fprintf('Maximum radiant energy: %.3f mJ\n', ...
    max(radiant_energy)*1000);
