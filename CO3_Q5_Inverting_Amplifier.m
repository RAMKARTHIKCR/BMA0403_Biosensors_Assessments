
clc;
clear;
close all;

%% INVERTING OP-AMP AMPLIFIER SIMULATION

% Circuit parameters
Rin = 10e3;          % Input resistance: 10 kohms
Rf = 100e3;          % Feedback resistance: 100 kohms
Vin_peak = 0.5;      % Input peak voltage
frequency = 5;      % Input frequency in Hz
supply_voltage = 12; % Op-amp supply: +/-12 V

% Calculate theoretical gain
gain = -Rf/Rin;

% Generate input signal
t = 0:0.001:1;
Vin = Vin_peak*sin(2*pi*frequency*t);

% Calculate ideal output
Vout_ideal = gain*Vin;

% Apply output voltage limitation
Vout = max(min(Vout_ideal,supply_voltage),-supply_voltage);

% Calculate measured gain
measured_gain = max(abs(Vout))/max(abs(Vin));

%% Display results
fprintf('INVERTING OP-AMP AMPLIFIER SIMULATION\n\n');

fprintf('Input resistance: %.2f kohms\n',Rin/1000);
fprintf('Feedback resistance: %.2f kohms\n',Rf/1000);
fprintf('Theoretical gain: %.2f\n',gain);
fprintf('Input peak voltage: %.2f V\n',Vin_peak);
fprintf('Supply voltage: +/- %.2f V\n',supply_voltage);

fprintf('\nMaximum input voltage: %.3f V\n',max(abs(Vin)));
fprintf('Maximum output voltage: %.3f V\n',max(abs(Vout)));
fprintf('Measured gain magnitude: %.2f\n',measured_gain);

%% Graph 1: Input and output signals
figure;

plot(t,Vin,'b','LineWidth',1.5);
hold on;
plot(t,Vout,'r','LineWidth',1.5);

xlabel('Time (seconds)');
ylabel('Voltage (V)');
title('Input and Output of Inverting Amplifier');

legend('Input Signal','Output Signal');
grid on;

%% Graph 2: Input vs output voltage
figure;

plot(Vin,Vout,'m','LineWidth',1.8);
hold on;
plot([-Vin_peak Vin_peak], ...
     [Vin_peak -Vin_peak]*abs(gain),'k--');

xlabel('Input Voltage (V)');
ylabel('Output Voltage (V)');
title('Voltage Transfer Characteristics');

legend('Amplifier Response','Reference');
grid on;

%% Graph 3: Output gain comparison
figure;

bar([abs(gain),measured_gain]);

set(gca,'XTickLabel',{'Theoretical Gain','Measured Gain'});

ylabel('Gain Magnitude');
title('Comparison of Amplifier Gain');

grid on;

%% Summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Gain verification: %.2f\n',measured_gain);
