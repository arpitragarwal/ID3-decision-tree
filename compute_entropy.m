function entropy = compute_entropy(data, metadata)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
number_of_value_labels = length(metadata.attribute_values{end});
number_of_data_points = length(data(:, 1));
value_labels = data(:, end);
unique_value_labels = metadata.attribute_values{end};

number_of_labels_per_value = zeros(1, number_of_value_labels);
for i = 1:number_of_data_points
    index = find(strcmp(value_labels{i}, unique_value_labels));
    number_of_labels_per_value(index) = number_of_labels_per_value(index) + 1;
end

probabilities = number_of_labels_per_value/number_of_data_points;
entropies = -1 * probabilities.*log(probabilities)/log(2);

entropy = sum(entropies);

end

