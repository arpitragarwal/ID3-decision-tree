function gain_value = info_gain(data, metadata, splits, attribute_number)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
current_entropy = compute_entropy(data, metadata);

no_of_attributes    = length(data(1, :));
no_of_data_points   = length(data(:, 1));
children_data_sets  = split_data_sets(data, metadata, splits, attribute_number);

for i = 1:length(children_data_sets)
    num_of_data_points_in_child(i) = length(children_data_sets(i).data(:, 1));
    if num_of_data_points_in_child(i) == 1
        if (strcmp(children_data_sets(i).data(:, end), ''))
            num_of_data_points_in_child(i) = 0;
        end
    end
    probability_of_child(i) = num_of_data_points_in_child(i)/no_of_data_points;
    entropy(i) = compute_entropy(children_data_sets(i).data, metadata);
end
if (sum(num_of_data_points_in_child)~=no_of_data_points)
    warning('Something is wrong in the data splits')
end
gain_value = current_entropy - sum(probability_of_child.*entropy);

end

