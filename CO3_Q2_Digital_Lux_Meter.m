
clc;
clear;
close all;

%% DIGITAL LUX METER SIMULATION
% Photometric sensor with ADC and microcontroller model

% Sensor and ADC parameters
sensor_sensitivity = 0.005;  % V per lux
Vref = 5;                    % ADC reference voltage
ADC_bits = 10;
ADC_levels = 2^ADC_bits;

% Reference illumination values
lux = 0:100:1000;

% Sensor output voltage
sensor_voltage = sensor_sensitivity .* lux;

% ADC conversion
adc_count = round((sensor_voltage ./ Vref) .* (ADC_levels - 1));

% Reconstructed digital voltage
digital_voltage = (adc_count ./ (ADC_levels - 1)) .* Vref;

% Microcontroller calculation of illumination
estimated_lux = digital_voltage ./ sensor_sensitivity;

% Measurement error
error_lux = estimated_lux - lux;

%% Display results
fprintf('DIGITAL LUX METER SIMULATION\n\n');

fprintf('ADC resolution: %d-bit\n', ADC_bits);
fprintf('ADC levels: %d\n', ADC_levels);
fprintf('ADC reference voltage: %.2f V\n', Vref);
fprintf('Sensor sensitivity: %.4f V/lux\n\n', sensor_sensitivity);

fprintf('Reference Lux   Sensor V   ADC Count   Digital Lux   Error\n');

for i = 1:length(lux)
    fprintf('%8.1f      %6.3f       %4d       %8.2f    %7.3f\n', ...
        lux(i), sensor_voltage(i), adc_count(i), ...
        estimated_lux(i), error_lux(i));
end

fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum ADC count: %d\n', max(adc_count));
fprintf('Maximum absolute error: %.4f lux\n', max(abs(error_lux)));

%% Graph 1: Reference and estimated illumination
figure;
plot(lux, lux, 'k--', 'LineWidth', 1.5);
hold on;
plot(lux, estimated_lux, 'b-o', 'LineWidth', 2);
xlabel('Reference Illumination (lux)');
ylabel('Measured Illumination (lux)');
title('Digital Lux Meter Response');
legend('Ideal Response', 'ADC Measured Response', ...
    'Location', 'northwest');
grid on;

%% Graph 2: ADC output count
figure;
stairs(lux, adc_count, 'r-o', 'LineWidth', 2);
xlabel('Reference Illumination (lux)');
ylabel('ADC Digital Count');
title('ADC Output vs Light Intensity');
grid on;

%% Graph 3: Measurement error
figure;
stem(lux, error_lux, 'filled', 'LineWidth', 1.5);
xlabel('Reference Illumination (lux)');
ylabel('Measurement Error (lux)');
title('ADC Quantization Error in Digital Lux Meter');
grid on;
