function [splits] = determineCandidateSplits(data, metadata)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

is_attribute_numeric = metadata.is_attribute_numeric;
n_attributes = length(data(1,:));
for i = 1:n_attributes
    if is_attribute_numeric(i)
        splits{i} = determineCandidateNumericSplits(data, i);
    else
        splits{i} = unique(data(:, i));
    end
end

end

