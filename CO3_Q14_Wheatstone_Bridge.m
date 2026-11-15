
clc;
clear;
close all;

%% WHEATSTONE BRIDGE STRAIN SENSOR SIMULATION

% Bridge parameters
Vex = 5;                  % Excitation voltage (V)
R = 350;                  % Nominal resistance (ohms)
GF = 2.0;                 % Strain gauge factor

% Applied strain in microstrain
strain_micro = 0:100:1000;

% Convert microstrain to actual strain
strain = strain_micro * 1e-6;

% Strain gauge resistance
R1 = R .* (1 + GF .* strain);

% Other three bridge resistances
R2 = R;
R3 = R;
R4 = R;

% Calculate voltage at bridge midpoints
Vleft = Vex .* R2 ./ (R1 + R2);
Vright = Vex .* R4 ./ (R3 + R4);

% Differential bridge output
Vout = Vright - Vleft;

% Convert output to millivolts
Vout_mV = Vout .* 1000;

%% Display results
fprintf('WHEATSTONE BRIDGE STRAIN SENSOR SIMULATION\n\n');

fprintf('Excitation voltage: %.2f V\n',Vex);
fprintf('Nominal resistance: %.2f ohms\n',R);
fprintf('Gauge factor: %.2f\n\n',GF);

fprintf('Strain( microstrain )   Resistance(ohm)   Output(mV)\n');

for i = 1:length(strain_micro)
    fprintf('%8.0f                 %8.3f         %8.4f\n', ...
        strain_micro(i),R1(i),Vout_mV(i));
end

%% Graph 1: Output voltage vs strain
figure;

plot(strain_micro,Vout_mV,'b-o','LineWidth',1.8);

xlabel('Applied Strain (microstrain)');
ylabel('Bridge Output Voltage (mV)');
title('Wheatstone Bridge Output vs Applied Strain');

grid on;

%% Graph 2: Resistance variation
figure;

plot(strain_micro,R1,'r-s','LineWidth',1.8);

xlabel('Applied Strain (microstrain)');
ylabel('Strain Gauge Resistance (ohms)');
title('Strain Gauge Resistance vs Applied Strain');

grid on;

%% Graph 3: Bridge output sensitivity
sensitivity = gradient(Vout_mV,strain_micro);

figure;

plot(strain_micro,sensitivity,'m-o','LineWidth',1.8);

xlabel('Applied Strain (microstrain)');
ylabel('Sensitivity (mV/microstrain)');
title('Wheatstone Bridge Sensitivity');

grid on;

%% Summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Initial bridge output: %.4f mV\n',Vout_mV(1));
fprintf('Final bridge output: %.4f mV\n',Vout_mV(end));
fprintf('Maximum applied strain: %.0f microstrain\n', ...
    max(strain_micro));