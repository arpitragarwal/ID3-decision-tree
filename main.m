clear; clc; close all; format compact;

filename = 'data/play_tennis.arff.txt';
[data, metadata] = read_arff_file(filename);
fclose all;

tree = make_subtree(data, metadata);
