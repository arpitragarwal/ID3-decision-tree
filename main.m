clear; clc; close all; format compact;

filename = 'data/heart_train.arff.txt';
[training_data, training_metadata] = read_arff_file(filename);
fclose all;

m = 2;
tree = make_subtree(training_data, training_metadata, m);

%%
test_filename = 'data/heart_test.arff.txt';
[test_data, test_metadata] = read_arff_file(test_filename);
fclose all;
%%

clearvars sample_label sample
for i = 1:length(test_data(:, 1))
    sample{i, :} = test_data(i, :);
    predicted_label{i, :} = tree.find_correct_child(sample{i, :});
end

% evaluate accuracy
for i = 1:length(test_data(:, 1))
    is_predict_correct(i, 1) = strcmp(predicted_label{i}, test_data{i, end});
end

number_correctly_classified = sum(is_predict_correct);
total_no_of_test_instances = length(test_data(:, 1));
%%
clc
for i = 1:length(test_data(:, 1))
    disp([num2str(i), ': Actual: ', test_data{i, end}, ' Predicted: ', predicted_label{i}]);
end
disp(['Number of correctly classified: ', num2str(number_correctly_classified), ' Total number of test instances: ', num2str(total_no_of_test_instances)]);