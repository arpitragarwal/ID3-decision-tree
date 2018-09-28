clear; clc; close all; format compact;

filename = 'data/play_tennis.arff.txt';
[data, metadata] = read_arff_file(filename);
fclose all;

[splits] = determine_candidate_splits(data, metadata);
entropy = compute_entropy(data, metadata);


%children_data_sets = split_data_sets(data, metadata, splits, attribute_number);

for i = 1:length(metadata.attribute_names)
    attribute_number = i;
    gain(i) = info_gain(data, metadata, splits, attribute_number);
end