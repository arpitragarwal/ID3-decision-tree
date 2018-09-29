function [splits] = determine_candidate_splits(data, metadata)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

is_attribute_numeric = metadata.is_attribute_numeric;
n_attributes = length(data(1,:));

for i = 1:n_attributes
    if is_attribute_numeric(i)
        % check for empty dataset
        if (isempty(data{1,1}))
            splits{i} = [];
        else
            splits{i} = determine_candidate_numeric_splits(data, i);
        end
    else
        unique_values{i} = unique(data(:, i));
        for j = 1:length(unique_values{i})
            for k = 1:length(metadata.attribute_values{i})
                string_to_check = metadata.attribute_values{i}{k};
                if any(strcmp(unique_values{i}, string_to_check))
                    splits{i}{k} = string_to_check;
                end
            end
        end
    end
end

end

