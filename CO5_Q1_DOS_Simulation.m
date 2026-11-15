
clc;
clear;
close all;

%% DENSITY OF STATES (DOS) SIMULATION
% One-dimensional nanostructure

% Physical constants
hbar = 1.0545718e-34;      % Reduced Planck constant (J.s)
q = 1.6021766e-19;         % Electron charge (C)
m0 = 9.1093837e-31;        % Electron rest mass (kg)

% Effective electron mass
m_eff = 0.067 * m0;

% Energy range in eV
E = 0.001:0.001:0.30;

% Subband energy levels (eV)
En = [0.00, 0.05, 0.10];

% Initialise DOS matrix
DOS = zeros(length(En), length(E));

%% Calculate DOS for each subband

for i = 1:length(En)

    for j = 1:length(E)

        if E(j) > En(i)

            deltaE = E(j) - En(i);

            DOS(i,j) = sqrt(2*m_eff*q) / ...
                (pi*hbar*sqrt(deltaE));

        end

    end

end

% Total density of states
total_DOS = sum(DOS, 1);

%% Display selected results

fprintf('ONE-DIMENSIONAL DENSITY OF STATES SIMULATION\n\n');

fprintf('Effective electron mass: %.3f times electron mass\n', ...
    m_eff/m0);

fprintf('Subband energy levels: 0.00, 0.05 and 0.10 eV\n\n');

fprintf('Energy (eV)       Total DOS (states/m/eV)\n');

sample_energy = [0.02, 0.04, 0.06, 0.08, ...
                 0.12, 0.15, 0.20, 0.25, 0.30];

for i = 1:length(sample_energy)

    [~, index] = min(abs(E - sample_energy(i)));

    fprintf('%8.3f             %.4e\n', ...
        E(index), total_DOS(index));

end

%% Graph 1: Total DOS vs Energy

figure;

plot(E, total_DOS, 'b', 'LineWidth', 2);

xlabel('Energy (eV)');
ylabel('Density of States (states/m/eV)');
title('Density of States in a 1D Nanostructure');

grid on;

%% Graph 2: Individual Subband Contributions

figure;
hold on;

plot(E, DOS(1,:), 'b', 'LineWidth', 2);
plot(E, DOS(2,:), 'r', 'LineWidth', 2);
plot(E, DOS(3,:), 'g', 'LineWidth', 2);

xlabel('Energy (eV)');
ylabel('Density of States (states/m/eV)');

title('DOS Contribution from Individual Subbands');

legend('Subband 1 (0.00 eV)', ...
       'Subband 2 (0.05 eV)', ...
       'Subband 3 (0.10 eV)');

grid on;

%% Simulation summary

fprintf('\nSimulation completed successfully.\n');
fprintf('Number of subbands: %d\n', length(En));
fprintf('Maximum energy analysed: %.2f eV\n', max(E));
