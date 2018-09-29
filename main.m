clear; clc; close all; format compact;

filename = 'data/heart_train.arff.txt';
[data, metadata] = read_arff_file(filename);
fclose all;

m = 20;
tree = make_subtree(data, metadata, m);
