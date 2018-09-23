clear; clc; close all; format compact;

filename = 'heart_train.arff.txt';
[data, metadata] = read_arff_file(filename);

[splits] = determineCandidateSplits(data, metadata);
fclose all;
