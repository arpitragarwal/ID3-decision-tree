function [number_correctly_classified, total_no_of_test_instances] = make_predictions(test_data, tree)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% evaluate accuracy

for i = 1:length(test_data(:, 1))
    sample{i, :} = test_data(i, :);
    predicted_label{i, :} = tree.find_correct_child(sample{i, :});
end

for i = 1:length(test_data(:, 1))
    is_predict_correct(i, 1) = strcmp(predicted_label{i}, test_data{i, end});
end

number_correctly_classified = sum(is_predict_correct);
total_no_of_test_instances = length(test_data(:, 1));

disp('<Predictions for the Test Set Instances>');
for i = 1:length(test_data(:, 1))
    disp([num2str(i), ': Actual: ', test_data{i, end}, ' Predicted: ', predicted_label{i}]);
end
disp(['Number of correctly classified: ', num2str(number_correctly_classified), ' Total number of test instances: ', num2str(total_no_of_test_instances)]);
end

