function [gain_value, splitting_value_index] = info_gain(data, metadata, splits, attribute_number)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
splitting_value_index = -1;
current_entropy = compute_entropy(data, metadata);

no_of_attributes    = length(data(1, :));
no_of_data_points   = length(data(:, 1));
% check for empty dataset
if(isempty(data{1,1}))
    gain_value = 0;
    return
end
children_data_sets  = split_data_sets(data, metadata, splits, attribute_number);
are_attributes_numeric = metadata.is_attribute_numeric;
if ~are_attributes_numeric(attribute_number) % Non numerical features
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
else
    % numerical features
    gain_value = 0; % initialization
    if length(children_data_sets)<=1
        return
    end
    for i = 1:length(children_data_sets) - 1
        % construct binary splits based on children data sets provided
        clearvars left_child_set right_child_set
        for k = 1:length(splits{attribute_number})
            left_child_set = repmat({''}, 1, length(data(1, :)));
            right_child_set = repmat({''}, 1, length(data(1, :)));
        end
        for j = 1:length(children_data_sets)
            if j <= i
                left_child_set  = ...
                    combine_data_sets(left_child_set, children_data_sets(j).data);
            else
                right_child_set =...
                    combine_data_sets(right_child_set, children_data_sets(j).data);
            end
        end
        
        % compute gain for these binary splits
        numeric_children_sets{1} = left_child_set;
        numeric_children_sets{2} = right_child_set;
        for j = 1:2
            num_of_data_points_in_child(j) = length(numeric_children_sets{j}(:,1));
            if num_of_data_points_in_child(j) == 1
                if (strcmp(numeric_children_sets{j}(:, end), ''))
                    num_of_data_points_in_child(j) = 0;
                end
            end
            probability_of_child(j) = num_of_data_points_in_child(j)/no_of_data_points;
            entropy(j) = compute_entropy(numeric_children_sets{j}, metadata);
        end
        if (sum(num_of_data_points_in_child)~=no_of_data_points)
            warning('Something is wrong in the data splits')
        end
        gain_value_for_split_j = current_entropy - sum(probability_of_child.*entropy);
        if(gain_value_for_split_j > gain_value)
            gain_value = gain_value_for_split_j;
            splitting_value_index = i;
        end
    end
end
end