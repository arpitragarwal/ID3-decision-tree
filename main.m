clear; clc; close all; format compact;

filename = 'data/heart_train.arff.txt';
%filename = 'data/diabetes_train.arff.txt';
[training_data, training_metadata] = read_arff_file(filename);
fclose all;

m = 20;
tree = make_subtree(training_data, training_metadata, m, [0 0]);

%%
test_filename = 'data/heart_test.arff.txt';
%test_filename = 'data/diabetes_test.arff.txt';
[test_data, test_metadata] = read_arff_file(test_filename);
fclose all;

%%
clc;
print_sub_tree(tree, 0);
%%
[number_correctly_classified, total_no_of_test_instances] = ...
    make_predictions(test_data, tree);