clear; clc; close all; format compact;

case_name = 'diabetes';
filename = ['data/', case_name, '_train.arff.txt'];
[all_training_data, training_metadata] = read_arff_file(filename);
test_filename = ['data/', case_name, '_test.arff.txt'];
[test_data, test_metadata] = read_arff_file(test_filename);
fclose all;
m = 4;

total_dataset_size = length(all_training_data(:, 1));

percent_set_sizes = [5, 10, 20, 50, 100];
for j = 1:length(percent_set_sizes)
    percent_data_to_use = percent_set_sizes(j);
    set_size = ceil(percent_data_to_use/100*total_dataset_size);
    
    for i = 1:2
        picked_indices = randsample(total_dataset_size, set_size);
        picked_set = all_training_data(picked_indices, :);
        
        tree = make_subtree(picked_set, training_metadata, m);
        [number_correctly_classified(i, j), total_no_of_test_instances(i, j)] = ...
            make_predictions(test_data, tree);
    end
end
%%
percent_n_correct = 100*(number_correctly_classified./total_no_of_test_instances);
figure()
plot(percent_set_sizes, percent_n_correct)
xlim([0 100])
ylim([0 100])