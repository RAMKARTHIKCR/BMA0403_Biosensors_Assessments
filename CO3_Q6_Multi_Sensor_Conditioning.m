
clc;
clear;
close all;

%% MULTI-SENSOR SIGNAL CONDITIONING SIMULATION

fs = 500;
t = 0:1/fs:2;
N = length(t);

fc = 10;
alpha = exp(-2*pi*fc/fs);

fprintf('MULTI-SENSOR SIGNAL CONDITIONING UNIT\n\n');
fprintf('Sampling frequency: %.2f Hz\n', fs);
fprintf('Low-pass filter cutoff: %.2f Hz\n\n', fc);

%% SENSOR 1: TEMPERATURE
temp_sensor = 0.01*(25 + 5*sin(2*pi*1*t));
temp_gain = 10;

%% SENSOR 2: PRESSURE
pressure_sensor = 0.02*(50 + 20*sin(2*pi*0.5*t));
pressure_gain = 2;

%% SENSOR 3: LIGHT
light_sensor = 0.001*(500 + 200*sin(2*pi*0.8*t));
light_gain = 4;

%% ADD SENSOR NOISE
rng(1);

temp_noisy = temp_sensor + 0.015*randn(1,N);
pressure_noisy = pressure_sensor + 0.025*randn(1,N);
light_noisy = light_sensor + 0.020*randn(1,N);

%% OP-AMP AMPLIFICATION
temp_amplified = temp_gain*temp_noisy;
pressure_amplified = pressure_gain*pressure_noisy;
light_amplified = light_gain*light_noisy;

%% FIRST-ORDER LOW-PASS FILTERING
temp_filtered = zeros(1,N);
pressure_filtered = zeros(1,N);
light_filtered = zeros(1,N);

temp_filtered(1) = temp_amplified(1);
pressure_filtered(1) = pressure_amplified(1);
light_filtered(1) = light_amplified(1);

for k = 2:N
    temp_filtered(k) = alpha*temp_filtered(k-1) ...
        + (1-alpha)*temp_amplified(k);

    pressure_filtered(k) = alpha*pressure_filtered(k-1) ...
        + (1-alpha)*pressure_amplified(k);

    light_filtered(k) = alpha*light_filtered(k-1) ...
        + (1-alpha)*light_amplified(k);
end

%% RMS NOISE COMPARISON
temp_ideal = temp_gain*temp_sensor;
pressure_ideal = pressure_gain*pressure_sensor;
light_ideal = light_gain*light_sensor;

temp_error_before = temp_amplified - temp_ideal;
temp_error_after = temp_filtered - temp_ideal;

pressure_error_before = pressure_amplified - pressure_ideal;
pressure_error_after = pressure_filtered - pressure_ideal;

light_error_before = light_amplified - light_ideal;
light_error_after = light_filtered - light_ideal;

fprintf('CHANNEL             BEFORE RMS     AFTER RMS\n');

fprintf('Temperature         %.4f         %.4f\n', ...
    rms(temp_error_before), rms(temp_error_after));

fprintf('Pressure            %.4f         %.4f\n', ...
    rms(pressure_error_before), rms(pressure_error_after));

fprintf('Light               %.4f         %.4f\n', ...
    rms(light_error_before), rms(light_error_after));

fprintf('\nSimulation completed successfully.\n');

%% FIGURE 1: TEMPERATURE CHANNEL
figure;
plot(t,temp_amplified,'Color',[0.7 0.7 0.7]);
hold on;
plot(t,temp_filtered,'r','LineWidth',1.5);
plot(t,temp_ideal,'b--','LineWidth',1.2);
xlabel('Time (seconds)');
ylabel('Output Voltage (V)');
title('Temperature Sensor Signal Conditioning');
legend('Noisy amplified','Filtered output','Ideal signal');
grid on;

%% FIGURE 2: PRESSURE CHANNEL
figure;
plot(t,pressure_amplified,'Color',[0.7 0.7 0.7]);
hold on;
plot(t,pressure_filtered,'r','LineWidth',1.5);
plot(t,pressure_ideal,'b--','LineWidth',1.2);
xlabel('Time (seconds)');
ylabel('Output Voltage (V)');
title('Pressure Sensor Signal Conditioning');
legend('Noisy amplified','Filtered output','Ideal signal');
grid on;

%% FIGURE 3: LIGHT CHANNEL
figure;
plot(t,light_amplified,'Color',[0.7 0.7 0.7]);
hold on;
plot(t,light_filtered,'r','LineWidth',1.5);
plot(t,light_ideal,'b--','LineWidth',1.2);
xlabel('Time (seconds)');
ylabel('Output Voltage (V)');
title('Light Sensor Signal Conditioning');
legend('Noisy amplified','Filtered output','Ideal signal');
grid on;

%% FIGURE 4: COMPARISON OF FILTERED SENSOR OUTPUTS
figure;
plot(t,temp_filtered,'LineWidth',1.5);
hold on;
plot(t,pressure_filtered,'LineWidth',1.5);
plot(t,light_filtered,'LineWidth',1.5);
xlabel('Time (seconds)');
ylabel('Conditioned Output (V)');
title('Comparison of Three Conditioned Sensor Channels');
legend('Temperature','Pressure','Light');
grid on;