
clc;
clear;
close all;

%% PRESSURE GRADIENT SENSOR SIMULATION

% Illustrative sensor parameter
sensitivity = 0.02;    % Sensor sensitivity (V/kPa)

% Pressure values
P2 = 100;              % Reference pressure (kPa)
P1 = 100:10:200;       % Varying pressure (kPa)

% Calculate pressure difference
deltaP = P1 - P2;

% Calculate sensor output voltage
Vout = sensitivity .* deltaP;

%% Display results
fprintf('PRESSURE GRADIENT SENSOR SIMULATION\n\n');

fprintf('Reference pressure: %.2f kPa\n', P2);
fprintf('Sensor sensitivity: %.3f V/kPa\n\n', sensitivity);

fprintf('P1 (kPa)   P2 (kPa)   Delta P (kPa)   Output (V)\n');

for i = 1:length(P1)
    fprintf('%7.2f   %7.2f      %7.2f        %7.3f\n', ...
        P1(i), P2, deltaP(i), Vout(i));
end

%% Graph 1: Output voltage vs pressure difference
figure;

plot(deltaP, Vout, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Pressure Difference (kPa)');
ylabel('Output Voltage (V)');
title('Pressure Gradient Sensor Response');

grid on;

%% Graph 2: Effect of Sensor Sensitivity
sensitivity_values = [0.01, 0.02, 0.03];

figure;
hold on;

for i = 1:length(sensitivity_values)
    output = sensitivity_values(i) .* deltaP;

    plot(deltaP, output, 'LineWidth', 2, ...
        'Marker', 'o', 'MarkerSize', 5);
end

xlabel('Pressure Difference (kPa)');
ylabel('Output Voltage (V)');
title('Sensor Output at Different Sensitivities');

legend('0.01 V/kPa', '0.02 V/kPa', ...
    '0.03 V/kPa', 'Location', 'northwest');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum pressure difference: %.2f kPa\n', max(deltaP));
fprintf('Maximum output voltage: %.3f V\n', max(Vout));
