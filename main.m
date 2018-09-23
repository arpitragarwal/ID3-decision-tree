clear; clc; close all; format compact;

filename = 'data/heart_train.arff.txt';
[data, metadata] = read_arff_file(filename);
fclose all;

[splits] = determine_candidate_splits(data, metadata);
entropy = compute_entropy(data, metadata);

attribute_number = 2;
children_data_sets = split_data_sets(data, metadata, splits, attribute_number);

%gain = info_gain(data, metadata, splits, attribute_number);