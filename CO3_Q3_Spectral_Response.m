
clc;
clear;
close all;

%% SPECTRAL RESPONSE ANALYZER SIMULATION
% Photodiode response at different light wavelengths

% Define wavelength range
wavelength = 400:10:700;  % nm

% Photodiode model parameters
peak_wavelength = 550;    % nm
maximum_responsivity = 0.45; % A/W
bandwidth = 80;           % nm (model parameter)

% Constant incident optical power
optical_power = 1e-3;      % 1 mW

% Transimpedance amplifier feedback resistance
feedback_resistance = 10e3; % 10 kohms

%% Calculate spectral responsivity
responsivity = maximum_responsivity .* ...
    exp(-((wavelength - peak_wavelength).^2) ./ (2 * bandwidth^2));

% Calculate photocurrent
photocurrent = responsivity .* optical_power;

% Convert photocurrent into output voltage
output_voltage = photocurrent .* feedback_resistance;

% Normalize response
normalized_response = (responsivity ./ maximum_responsivity) .* 100;

%% Display selected results
fprintf('SPECTRAL RESPONSE ANALYZER SIMULATION\n\n');

fprintf('Peak wavelength: %.2f nm\n', peak_wavelength);
fprintf('Maximum responsivity: %.2f A/W\n', maximum_responsivity);
fprintf('Incident optical power: %.2f mW\n', optical_power*1000);
fprintf('Feedback resistance: %.2f kohms\n\n', ...
    feedback_resistance/1000);

fprintf('Wavelength(nm)  Responsivity(A/W)  Current(uA)  Output(V)\n');

selected = 1:5:length(wavelength);

for i = selected
    fprintf('%8.1f         %8.4f          %8.3f      %8.4f\n', ...
        wavelength(i), responsivity(i), ...
        photocurrent(i)*1e6, output_voltage(i));
end

% Find maximum response
[max_response, max_index] = max(responsivity);

fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum responsivity: %.4f A/W\n', max_response);
fprintf('Peak response wavelength: %.1f nm\n', wavelength(max_index));
fprintf('Maximum output voltage: %.4f V\n', max(output_voltage));

%% Graph 1: Spectral responsivity
figure;
plot(wavelength, responsivity, 'b-', 'LineWidth', 2);
hold on;
plot(wavelength(max_index), max_response, 'ro', ...
    'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Wavelength (nm)');
ylabel('Responsivity (A/W)');
title('Photodiode Spectral Responsivity');
legend('Responsivity', 'Peak Response', 'Location', 'northwest');
grid on;

%% Graph 2: Photocurrent response
figure;
plot(wavelength, photocurrent*1e6, 'r-o', ...
    'LineWidth', 1.8, 'MarkerSize', 4);
xlabel('Wavelength (nm)');
ylabel('Photocurrent (uA)');
title('Photocurrent Variation with Wavelength');
grid on;

%% Graph 3: Normalized spectral response
figure;
plot(wavelength, normalized_response, 'm-', 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Normalized Response (%)');
title('Normalized Spectral Response of Photodiode');
ylim([0 110]);
grid on;
