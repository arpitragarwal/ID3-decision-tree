function dt_learn(training_filename, test_filename, m)
%Script for building tree and making predictions

if ~exist('m','var')
      m = 20;
end
if ~exist('training_filename','var')
      training_filename = 'data/heart_train.arff.txt';
end
if ~exist('test_filename','var')
      test_filename = 'data/heart_test.arff.txt';
end



[training_data, training_metadata] = read_arff_file(training_filename);
fclose all;

tree = make_subtree(training_data, training_metadata, m, [0 0]);

[test_data, ~] = read_arff_file(test_filename);
fclose all;

print_sub_tree(tree, 0);

[number_correctly_classified, total_no_of_test_instances] = ...
    make_predictions(test_data, tree);
end

