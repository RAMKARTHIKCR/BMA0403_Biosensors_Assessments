
clc;
clear;
close all;

%% NANO-CANTILEVER MECHANICAL SENSOR SIMULATION

% Illustrative cantilever parameters
f0 = 100e3;              % Initial resonant frequency (Hz)
m_eff = 1e-12;           % Effective cantilever mass (kg)

% Added mass range (femtograms)
added_mass_fg = 0:100:1000;

% Convert femtograms to kilograms
added_mass = added_mass_fg .* 1e-18;

%% Calculate resonant frequency after mass loading
% Frequency relation: f = f0 * sqrt(m_eff/(m_eff + added_mass))

resonant_frequency = f0 .* ...
    sqrt(m_eff ./ (m_eff + added_mass));

% Calculate frequency shift
frequency_shift = resonant_frequency - f0;

% Convert frequency values to kHz
frequency_kHz = resonant_frequency ./ 1000;
shift_kHz = frequency_shift ./ 1000;

%% Display results
fprintf('NANO-CANTILEVER MECHANICAL SENSOR SIMULATION\n\n');

fprintf('Initial resonant frequency: %.2f kHz\n', f0/1000);
fprintf('Effective cantilever mass: %.3e kg\n\n', m_eff);

fprintf('Added Mass(fg)   Frequency(kHz)   Frequency Shift(kHz)\n');

for i = 1:length(added_mass_fg)

    fprintf('%8.2f          %8.3f             %8.3f\n', ...
        added_mass_fg(i), frequency_kHz(i), shift_kHz(i));

end

%% Graph 1: Resonant Frequency vs Added Mass
figure;

plot(added_mass_fg, frequency_kHz, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Added Mass (fg)');
ylabel('Resonant Frequency (kHz)');
title('Effect of Mass Loading on Cantilever Resonance');

grid on;

%% Graph 2: Frequency Shift vs Added Mass
figure;

plot(added_mass_fg, shift_kHz, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 6);

xlabel('Added Mass (fg)');
ylabel('Frequency Shift (kHz)');
title('Frequency Shift Due to Mass Loading');

grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');

fprintf('Initial frequency: %.3f kHz\n', frequency_kHz(1));
fprintf('Final frequency: %.3f kHz\n', frequency_kHz(end));

fprintf('Maximum frequency shift: %.3f kHz\n', ...
    shift_kHz(end));
