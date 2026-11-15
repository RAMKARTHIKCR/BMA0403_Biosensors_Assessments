
clc;
clear;
close all;

%% SENSOR CALIBRATION SIMULATION

% Known reference input values
reference = 0:10:100;

% Simulated sensor errors
gain_error = 1.08;
offset_error = 5;

% Simulated uncalibrated sensor readings
raw_output = gain_error .* reference + offset_error;

% Add a small measurement variation
measurement_variation = [0 0.3 -0.2 0.4 -0.3 ...
                         0.2 -0.1 0.3 -0.4 0.2 0];

raw_output = raw_output + measurement_variation;

%% Linear calibration
% Fit reference values against measured sensor output
calibration_coefficients = polyfit(raw_output, reference, 1);

% Apply calibration equation
corrected_output = polyval(calibration_coefficients, raw_output);

% Calculate measurement errors
error_before = raw_output - reference;
error_after = corrected_output - reference;

% Calculate error statistics
mae_before = mean(abs(error_before));
mae_after = mean(abs(error_after));

%% Display results
fprintf('SENSOR CALIBRATION SIMULATION\n\n');

fprintf('Original sensor gain: %.3f\n', gain_error);
fprintf('Original sensor offset: %.3f\n', offset_error);

fprintf('\nCalibration equation:\n');
fprintf('Corrected = %.5f * Measured + %.5f\n', ...
    calibration_coefficients(1), ...
    calibration_coefficients(2));

fprintf('\nReference   Raw Output   Corrected Output\n');

for i = 1:length(reference)
    fprintf('%8.2f   %8.2f       %8.2f\n', ...
        reference(i), raw_output(i), corrected_output(i));
end

fprintf('\nMean absolute error before calibration: %.4f\n',mae_before);
fprintf('Mean absolute error after calibration: %.4f\n',mae_after);

%% Graph 1: Sensor calibration
figure;

plot(reference,reference,'k--','LineWidth',1.5);
hold on;
plot(reference,raw_output,'ro-','LineWidth',1.5);
plot(reference,corrected_output,'b-o','LineWidth',1.5);

xlabel('Reference Input');
ylabel('Sensor Output');
title('Sensor Output Before and After Calibration');

legend('Ideal Response','Uncalibrated Output', ...
       'Calibrated Output','Location','northwest');

grid on;

%% Graph 2: Measurement error
figure;

plot(reference,error_before,'r-o','LineWidth',1.5);
hold on;
plot(reference,error_after,'b-s','LineWidth',1.5);

yline(0,'k--');

xlabel('Reference Input');
ylabel('Measurement Error');
title('Measurement Error Before and After Calibration');

legend('Before Calibration','After Calibration', ...
       'Location','best');

grid on;

%% Graph 3: Error comparison
figure;

bar([mae_before mae_after]);

set(gca,'XTickLabel',{'Before Calibration','After Calibration'});

ylabel('Mean Absolute Error');
title('Comparison of Calibration Error');

grid on;

%% Summary
fprintf('\nSimulation completed successfully.\n');
fprintf('Error reduction: %.2f %%\n', ...
    (1-mae_after/mae_before)*100);
