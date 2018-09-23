clear; clc; close all; format compact;

filename = 'data/heart_train.arff.txt';
[data, metadata] = read_arff_file(filename);

[splits] = determineCandidateSplits(data, metadata);
fclose all;
