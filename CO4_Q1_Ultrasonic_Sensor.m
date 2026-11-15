
clc;
clear;
close all;

%% ULTRASONIC SENSOR SIMULATION
% Time-of-flight distance measurement

% Define distances in metres
distance = 0.1:0.1:2.0;

% Speed of sound in different media (m/s)
speed_air = 343;
speed_water = 1480;

% Calculate round-trip time of flight
time_air = (2 .* distance ./ speed_air) .* 1000;
time_water = (2 .* distance ./ speed_water) .* 1000;

%% Display results
fprintf('ULTRASONIC SENSOR SIMULATION\n\n');
fprintf('Distance(m)   Air Delay(ms)   Water Delay(ms)\n');

for i = 1:length(distance)
    fprintf('%.2f           %.4f          %.4f\n', ...
        distance(i), time_air(i), time_water(i));
end

%% Graph 1: Distance vs Time Delay
figure;

plot(distance, time_air, 'b-o', ...
    'LineWidth', 2, 'MarkerSize', 5);

hold on;

plot(distance, time_water, 'r-s', ...
    'LineWidth', 2, 'MarkerSize', 5);

xlabel('Distance (m)');
ylabel('Time of Flight (ms)');
title('Distance vs Ultrasonic Time Delay');

legend('Air', 'Water', 'Location', 'northwest');
grid on;

%% Graph 2: Effect of Medium
figure;

bar([mean(time_air), mean(time_water)]);

set(gca, 'XTickLabel', {'Air', 'Water'});

ylabel('Average Time Delay (ms)');
title('Comparison of Time Delay in Different Media');

grid on;

%% Display simulation summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Sound velocity in air: %d m/s\n', speed_air);
fprintf('Sound velocity in water: %d m/s\n', speed_water);
