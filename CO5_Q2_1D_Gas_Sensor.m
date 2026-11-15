
clc;
clear;
close all;

%% ONE-DIMENSIONAL NANOWIRE GAS SENSOR SIMULATION

% Illustrative sensor model parameters
Rmax = 80;       % Maximum sensor response (%)
K = 30;          % Half-response concentration (ppm)

% Gas concentration range
concentration = 0:5:100;

% Langmuir-type saturation response model
response = (Rmax .* concentration) ./ (K + concentration);

% Sensitivity: rate of change of response with concentration
sensitivity = (Rmax .* K) ./ (K + concentration).^2;

%% Display selected results
sample_concentration = [0 10 20 30 40 50 60 80 100];

fprintf('1D NANOWIRE GAS SENSOR SIMULATION\n\n');
fprintf('Maximum response parameter: %.2f %%\n', Rmax);
fprintf('Half-response concentration: %.2f ppm\n\n', K);

fprintf('Concentration(ppm)   Response(%%)   Sensitivity(%%/ppm)\n');

for i = 1:length(sample_concentration)

    C = sample_concentration(i);

    R = (Rmax * C) / (K + C);
    S = (Rmax * K) / (K + C)^2;

    fprintf('%10.2f          %8.3f          %8.4f\n', C, R, S);

end

%% Graph 1: Sensor Response vs Gas Concentration
figure;

plot(concentration, response, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Gas Concentration (ppm)');
ylabel('Sensor Response (%)');
title('1D Nanowire Gas Sensor Response');

grid on;

%% Graph 2: Sensitivity vs Gas Concentration
figure;

plot(concentration, sensitivity, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Gas Concentration (ppm)');
ylabel('Sensitivity (%/ppm)');
title('Sensitivity Variation with Gas Concentration');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum response: %.3f %%\n', max(response));
fprintf('Sensitivity at zero concentration: %.4f %%/ppm\n', ...
    sensitivity(1));
fprintf('Sensitivity at 100 ppm: %.4f %%/ppm\n', ...
    sensitivity(end));
