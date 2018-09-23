function splits = determineCandidateNumericSplits(data, attribute_number)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

tmp = data(:, attribute_number);
for i = 1:length(tmp)
    attribute_values(i) = str2num(tmp{i});
end

class_values = data(:, end);
[sorted_attribute_values, indices] = sort(attribute_values);

sorted_class_values = class_values(indices);
splits = [];
for i = 2:length(sorted_attribute_values)
    if(strcmp(sorted_class_values(i - 1), sorted_class_values(i)))
    else
        split_value = 0.5 * (sorted_attribute_values(i - 1) + sorted_attribute_values(i));
        splits = [splits, split_value];
    end
end
end

