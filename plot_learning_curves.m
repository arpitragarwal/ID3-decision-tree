clear; clc; close all; format compact;

case_name = 'diabetes';
%case_name = 'heart';
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
    set_size(j) = ceil(percent_data_to_use/100*total_dataset_size);
    
    for i = 1:10
        picked_indices = randsample(total_dataset_size, set_size(j));
        picked_set = all_training_data(picked_indices, :);
        
        tree = make_subtree(picked_set, training_metadata, m, [0 0]);
        [number_correctly_classified(i, j), total_no_of_test_instances(i, j)] = ...
            make_predictions(test_data, tree);
    end
end
%%
percent_n_correct = 100*mean(number_correctly_classified./total_no_of_test_instances);
figure()
plot(set_size, percent_n_correct, 'o-')
%xlim([0 100])
ylim([0 100])
grid on
xlabel('No. of training instances')
ylabel('Percentage accuracy')
legend(case_name)
savefig(gcf, ['../figures/learning_curve_', case_name,'.fig'])
