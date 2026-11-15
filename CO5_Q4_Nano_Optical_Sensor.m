
clc;
clear;
close all;

%% NANO-OPTICAL SENSOR SIMULATION USING SPR

% Illustrative SPR sensor parameters
lambda0 = 650;          % Initial resonance wavelength (nm)
max_shift = 30;         % Maximum wavelength shift (nm)
K = 0.02;               % Binding constant (nM^-1)
min_reflectance = 0.15; % Minimum reflectance at resonance
width = 8;              % Resonance dip width (nm)

% Analyte concentration range
concentration = 0:10:100;

% Wavelength range
wavelength = 600:1:720;

%% Calculate surface binding and resonance wavelength
theta = (K .* concentration) ./ (1 + K .* concentration);

resonance_wavelength = lambda0 + max_shift .* theta;

wavelength_shift = resonance_wavelength - lambda0;

%% Display results
fprintf('NANO-OPTICAL SPR SENSOR SIMULATION\n\n');

fprintf('Initial resonance wavelength: %.2f nm\n', lambda0);
fprintf('Maximum wavelength shift parameter: %.2f nm\n', max_shift);
fprintf('Binding constant: %.3f nM^-1\n\n', K);

fprintf('Concentration(nM)   Surface Coverage(%%)   Resonance(nm)   Shift(nm)\n');

for i = 1:length(concentration)

    fprintf('%10.2f             %8.3f          %8.2f      %8.2f\n', ...
        concentration(i), theta(i)*100, ...
        resonance_wavelength(i), wavelength_shift(i));

end

%% Graph 1: SPR Reflectance Spectra
figure;
hold on;

selected_concentrations = [0 20 40 60 80 100];

for i = 1:length(selected_concentrations)

    C = selected_concentrations(i);

    coverage = (K*C)/(1 + K*C);

    lambda_res = lambda0 + max_shift*coverage;

    reflectance = 1 - (1-min_reflectance) .* ...
        exp(-0.5 .* ((wavelength-lambda_res)./width).^2);

    plot(wavelength, reflectance, 'LineWidth', 2);

end

xlabel('Wavelength (nm)');
ylabel('Reflectance (a.u.)');
title('SPR Reflectance Spectra at Different Analyte Concentrations');

legend('0 nM', '20 nM', '40 nM', ...
       '60 nM', '80 nM', '100 nM', ...
       'Location', 'best');

grid on;

%% Graph 2: Resonance Wavelength vs Concentration
figure;

plot(concentration, resonance_wavelength, 'r-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Analyte Concentration (nM)');
ylabel('Resonance Wavelength (nm)');
title('SPR Wavelength Shift with Analyte Concentration');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');

fprintf('Initial resonance wavelength: %.2f nm\n', lambda0);
fprintf('Final resonance wavelength: %.2f nm\n', ...
    resonance_wavelength(end));

fprintf('Maximum wavelength shift: %.2f nm\n', ...
    wavelength_shift(end));
