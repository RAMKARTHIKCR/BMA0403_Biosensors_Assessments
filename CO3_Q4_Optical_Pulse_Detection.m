
clc;
clear;
close all;

%% OPTICAL PULSE DETECTION SYSTEM SIMULATION

% Simulation parameters
fs = 100;                 % Sampling frequency (Hz)
duration = 10;            % Duration (seconds)
heart_rate = 72;           % Assumed heart rate (BPM)

t = 0:1/fs:duration;
period = 60 / heart_rate;

%% Generate an illustrative PPG signal

phase = mod(t, period) / period;

% Main systolic pulse and secondary wave
main_pulse = exp(-0.5 * ((phase - 0.18) / 0.07).^2);
secondary_pulse = 0.22 * exp(-0.5 * ((phase - 0.48) / 0.08).^2);

clean_signal = 0.15 + main_pulse + secondary_pulse;

% Add small measurement noise
rng(1);
noise = 0.025 * randn(size(t));
noisy_signal = clean_signal + noise;

%% Detect pulse peaks

threshold = 0.55;
min_peak_distance = 0.60;

peak_indices = [];

for i = 2:length(t)-1

    is_peak = noisy_signal(i) > noisy_signal(i-1) && ...
              noisy_signal(i) >= noisy_signal(i+1) && ...
              noisy_signal(i) > threshold;

    if is_peak
        if isempty(peak_indices) || ...
           (t(i) - t(peak_indices(end))) >= min_peak_distance

            peak_indices(end+1) = i;
        end
    end
end

peak_times = t(peak_indices);
peak_values = noisy_signal(peak_indices);

%% Calculate heart rate

if length(peak_times) >= 2
    pulse_intervals = diff(peak_times);
    instantaneous_hr = 60 ./ pulse_intervals;
    estimated_hr = mean(instantaneous_hr);
else
    pulse_intervals = [];
    instantaneous_hr = [];
    estimated_hr = NaN;
end

%% Display results

fprintf('OPTICAL PULSE DETECTION SIMULATION\n\n');

fprintf('Sampling frequency: %.2f Hz\n', fs);
fprintf('Assumed heart rate: %.2f BPM\n', heart_rate);
fprintf('Detected pulse peaks: %d\n', length(peak_times));

fprintf('\nDetected Peak Times (seconds)\n');

for i = 1:length(peak_times)
    fprintf('%.2f\n', peak_times(i));
end

fprintf('\nEstimated Heart Rate: %.2f BPM\n', estimated_hr);

fprintf('Simulation completed successfully.\n');

%% Figure 1: PPG signal and detected peaks

figure;

plot(t, noisy_signal, 'b', 'LineWidth', 1.2);
hold on;

plot(peak_times, peak_values, 'ro', ...
    'MarkerFaceColor', 'r', 'MarkerSize', 6);

xlabel('Time (seconds)');
ylabel('Optical Signal Amplitude (a.u.)');
title('Optical PPG Signal and Detected Pulse Peaks');

legend('PPG Signal', 'Detected Peaks');
grid on;

%% Figure 2: Clean and noisy PPG signals

figure;

plot(t, clean_signal, 'b', 'LineWidth', 1.5);
hold on;

plot(t, noisy_signal, 'r', 'LineWidth', 0.8);

xlabel('Time (seconds)');
ylabel('Signal Amplitude (a.u.)');
title('Comparison of Clean and Noisy PPG Signals');

legend('Clean PPG Signal', 'Noisy PPG Signal');
grid on;

%% Figure 3: Instantaneous heart rate

figure;

if ~isempty(instantaneous_hr)
    plot(peak_times(2:end), instantaneous_hr, ...
        'mo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'm');

    xlabel('Time (seconds)');
    ylabel('Heart Rate (BPM)');
    title('Instantaneous Heart Rate Estimation');
    grid on;
else
    text(0.2, 0.5, 'Insufficient peaks for heart rate estimation');
end