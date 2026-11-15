
clc;
clear;
close all;

%% NANOSTRUCTURED THIN FILM GAS SENSOR SIMULATION

% Illustrative sensor parameters
K = 0.05;             % Adsorption equilibrium constant (ppm^-1)
sigma0 = 0.01;        % Initial conductivity (S/m)
beta = 4.5;           % Conductivity response factor

% Gas concentration range
concentration = 0:5:100;

%% Calculate surface coverage using Langmuir adsorption model
theta = (K .* concentration) ./ (1 + K .* concentration);

%% Calculate conductivity
% Assumption: Adsorbed gas increases conductivity
conductivity = sigma0 .* (1 + beta .* theta);

% Calculate percentage conductivity change
conductivity_change = ...
    ((conductivity - sigma0) ./ sigma0) .* 100;

%% Display results
fprintf('NANOSTRUCTURED THIN FILM GAS SENSOR SIMULATION\n\n');

fprintf('Adsorption constant: %.3f ppm^-1\n', K);
fprintf('Initial conductivity: %.4f S/m\n', sigma0);
fprintf('Conductivity response factor: %.2f\n\n', beta);

fprintf('Concentration(ppm)   Coverage(%%)   Conductivity(S/m)   Change(%%)\n');

for i = 1:length(concentration)

    fprintf('%10.2f          %8.3f       %10.5f       %8.3f\n', ...
        concentration(i), theta(i)*100, ...
        conductivity(i), conductivity_change(i));

end

%% Graph 1: Gas concentration vs surface coverage
figure;

plot(concentration, theta*100, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Gas Concentration (ppm)');
ylabel('Surface Coverage (%)');
title('Gas Adsorption on Nanostructured Thin Film');

grid on;

%% Graph 2: Gas concentration vs conductivity
figure;

plot(concentration, conductivity, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Gas Concentration (ppm)');
ylabel('Electrical Conductivity (S/m)');
title('Conductivity Change Due to Gas Adsorption');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');

fprintf('Initial conductivity: %.5f S/m\n', sigma0);
fprintf('Final conductivity: %.5f S/m\n', conductivity(end));

fprintf('Maximum conductivity change: %.2f %%\n', ...
    conductivity_change(end));
