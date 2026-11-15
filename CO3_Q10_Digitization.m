
clc;
clear;
close all;

%% SIGNAL DIGITIZATION SIMULATION

% Original analog signal
t = 0:0.0001:1;
f = 5;
analog_signal = sin(2*pi*f*t);

% Sampling parameters
Fs = 20;                 % Sampling frequency
Ts = 1/Fs;
t_sample = 0:Ts:1;

% Sample the analog signal
sampled_signal = sin(2*pi*f*t_sample);

% Quantization parameters
n_bits = 3;
levels = 2^n_bits;

Vmin = -1;
Vmax = 1;

step_size = (Vmax - Vmin)/(levels-1);

% Quantization
quantized_signal = round((sampled_signal - Vmin) ...
    / step_size) * step_size + Vmin;

% Limit values to the quantization range
quantized_signal = max(min(quantized_signal,Vmax),Vmin);

% Quantization error
quantization_error = sampled_signal - quantized_signal;

%% Display results
fprintf('SIGNAL DIGITIZATION SIMULATION\n\n');

fprintf('Analog signal frequency: %.2f Hz\n',f);
fprintf('Sampling frequency: %.2f Hz\n',Fs);
fprintf('Sampling interval: %.4f seconds\n',Ts);
fprintf('Quantization bits: %d\n',n_bits);
fprintf('Quantization levels: %d\n',levels);
fprintf('Quantization step size: %.4f V\n\n',step_size);

fprintf('Time(s)   Sampled(V)   Quantized(V)   Error(V)\n');

for i = 1:length(t_sample)
    fprintf('%.2f      %8.4f      %8.4f      %8.4f\n', ...
        t_sample(i), sampled_signal(i), ...
        quantized_signal(i), quantization_error(i));
end

%% Graph 1: Analog and sampled signal
figure;

plot(t,analog_signal,'b','LineWidth',1.8);
hold on;

stem(t_sample,sampled_signal,'r','filled');

xlabel('Time (seconds)');
ylabel('Amplitude (V)');
title('Analog Signal and Sampled Signal');

legend('Analog Signal','Sampled Signal');
grid on;

%% Graph 2: Quantized signal
figure;

stairs(t_sample,quantized_signal,'m','LineWidth',2);
hold on;

plot(t,analog_signal,'b--','LineWidth',1.2);

xlabel('Time (seconds)');
ylabel('Amplitude (V)');
title('Quantization of Sampled Signal');

legend('Quantized Signal','Original Analog Signal');
grid on;

%% Graph 3: Quantization error
figure;

stem(t_sample,quantization_error,'k','filled');

xlabel('Time (seconds)');
ylabel('Quantization Error (V)');
title('Quantization Error');

grid on;

%% Summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Maximum absolute quantization error: %.4f V\n', ...
    max(abs(quantization_error)));
