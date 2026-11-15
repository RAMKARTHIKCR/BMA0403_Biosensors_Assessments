
clc;
clear;
close all;

%% BIOSENSOR NOISE ANALYSIS AND FILTERING

% Sampling parameters
Fs = 500;
Ts = 1/Fs;
t = 0:Ts:2;

% Original biosensor signal
f_signal = 5;
clean_signal = sin(2*pi*f_signal*t);

% Add 50 Hz interference and random noise
rng(1);
power_line_noise = 0.4*sin(2*pi*50*t);
random_noise = 0.2*randn(size(t));

noisy_signal = clean_signal + power_line_noise + random_noise;

%% First-order RC low-pass filter
cutoff_frequency = 15;
alpha = (2*pi*cutoff_frequency*Ts) / ...
        (1 + 2*pi*cutoff_frequency*Ts);

filtered_signal = zeros(size(noisy_signal));
filtered_signal(1) = noisy_signal(1);

for i = 2:length(noisy_signal)
    filtered_signal(i) = filtered_signal(i-1) + ...
        alpha*(noisy_signal(i)-filtered_signal(i-1));
end

%% Calculate noise reduction
% Exclude initial filter settling period
valid = t >= 0.2;

noise_before = noisy_signal(valid) - clean_signal(valid);
noise_after = filtered_signal(valid) - clean_signal(valid);

rms_before = sqrt(mean(noise_before.^2));
rms_after = sqrt(mean(noise_after.^2));

reduction = (1 - rms_after/rms_before)*100;

%% Display results
fprintf('BIOSENSOR NOISE ANALYSIS SIMULATION\n\n');

fprintf('Sampling frequency: %.2f Hz\n',Fs);
fprintf('Useful signal frequency: %.2f Hz\n',f_signal);
fprintf('Power-line interference: 50 Hz\n');
fprintf('Low-pass filter cutoff: %.2f Hz\n',cutoff_frequency);
fprintf('Filter coefficient: %.4f\n\n',alpha);

fprintf('RMS noise before filtering: %.4f V\n',rms_before);
fprintf('RMS noise after filtering: %.4f V\n',rms_after);
fprintf('Noise reduction: %.2f %%\n',reduction);

%% Graph 1: Clean and noisy signal
figure;

plot(t,clean_signal,'b','LineWidth',1.5);
hold on;
plot(t,noisy_signal,'r');

xlabel('Time (seconds)');
ylabel('Amplitude (V)');
title('Original and Noisy Biosensor Signal');

legend('Original Signal','Noisy Signal');
grid on;

%% Graph 2: Noisy and filtered signal
figure;

plot(t,noisy_signal,'Color',[0.7 0.7 0.7]);
hold on;
plot(t,filtered_signal,'r','LineWidth',1.5);
plot(t,clean_signal,'b--','LineWidth',1.2);

xlabel('Time (seconds)');
ylabel('Amplitude (V)');
title('Signal Before and After Low-Pass Filtering');

legend('Noisy Signal','Filtered Signal','Original Signal');
grid on;

%% Graph 3: Frequency spectrum
N = length(t);

Y_noisy = abs(fft(noisy_signal))/N;
Y_filtered = abs(fft(filtered_signal))/N;

f = (0:N-1)*(Fs/N);

figure;

plot(f,Y_noisy,'Color',[0.6 0.6 0.6]);
hold on;
plot(f,Y_filtered,'r','LineWidth',1.5);

xlim([0 100]);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum Before and After Filtering');

legend('Noisy Signal','Filtered Signal');
grid on;

%% Simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Noise reduction achieved: %.2f %%\n',reduction);