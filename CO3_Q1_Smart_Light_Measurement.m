
clc;
clear;
close all;

%% SMART LIGHT INTENSITY MEASUREMENT SYSTEM
% Photodiode-based light-to-voltage model with calibration

% Sensor and circuit parameters
responsivity = 0.45;       % Photodiode responsivity (A/W)
sensor_area = 1e-4;        % Photodiode area (m^2)
luminous_efficacy = 300;   % Assumed luminous efficacy (lm/W)
feedback_resistance = 10e3; % Transimpedance amplifier (ohms)

% Ambient light intensity range
lux = 0:100:1000;

%% Photodiode current calculation
optical_power = (lux .* sensor_area) ./ luminous_efficacy;
photocurrent = responsivity .* optical_power;

%% Transimpedance amplifier output
ideal_voltage = photocurrent .* feedback_resistance;

% Introduce illustrative gain and offset errors
raw_voltage = (1.08 .* ideal_voltage) + 0.05 ...
              + 0.005 .* sin(lux ./ 130);

%% Calibration
% Fit a linear calibration equation
calibration_coefficients = polyfit(raw_voltage, lux, 1);

calibrated_lux = polyval(calibration_coefficients, raw_voltage);

% Calculate measurement error
error_before = abs((raw_voltage ./ ...
    (responsivity * sensor_area / luminous_efficacy ...
    * feedback_resistance)) - lux);

error_after = abs(calibrated_lux - lux);

%% Display results
fprintf('SMART LIGHT INTENSITY MEASUREMENT SYSTEM\n\n');

fprintf('Photodiode responsivity: %.2f A/W\n', responsivity);
fprintf('Feedback resistance: %.2f kohms\n', ...
    feedback_resistance / 1000);

fprintf('\nCalibration equation:\n');
fprintf('Estimated Lux = %.4f * Voltage + %.4f\n', ...
    calibration_coefficients(1), ...
    calibration_coefficients(2));

fprintf('\nReference Lux   Photocurrent(uA)   Raw Voltage(V)   Calibrated Lux\n');

for i = 1:length(lux)
    fprintf('%8.1f       %10.4f        %8.4f        %10.2f\n', ...
        lux(i), photocurrent(i)*1e6, ...
        raw_voltage(i), calibrated_lux(i));
end

fprintf('\nMean absolute error before calibration: %.3f lux\n', ...
    mean(error_before));

fprintf('Mean absolute error after calibration: %.3f lux\n', ...
    mean(error_after));

fprintf('\nSimulation completed successfully.\n');

%% Figure 1: Light intensity vs photocurrent
figure;

plot(lux, photocurrent*1e6, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Ambient Light Intensity (lux)');
ylabel('Photodiode Current (uA)');
title('Photodiode Current vs Ambient Light Intensity');
grid on;

%% Figure 2: Voltage response before and after calibration
figure;

plot(lux, raw_voltage, 'r-o', ...
    'LineWidth', 2, 'MarkerSize', 5);

hold on;

plot(lux, ideal_voltage, 'k--', ...
    'LineWidth', 2);

xlabel('Ambient Light Intensity (lux)');
ylabel('Output Voltage (V)');
title('Photodiode-Based Light-to-Voltage Response');

legend('Uncalibrated Output', 'Ideal Output', ...
    'Location', 'northwest');

grid on;

%% Figure 3: Calibration performance
figure;

plot(lux, lux, 'k--', 'LineWidth', 2);

hold on;

plot(lux, calibrated_lux, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Reference Light Intensity (lux)');
ylabel('Estimated Light Intensity (lux)');
title('Calibration of Smart Light Measurement System');

legend('Ideal Calibration', 'Calibrated Sensor Output', ...
    'Location', 'northwest');

grid on;
