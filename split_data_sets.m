function children_data_sets = split_data_sets(data, metadata, splits, attribute_number)

attribute_values = data(:, attribute_number);
is_curr_attribute_numeric = metadata.is_attribute_numeric(attribute_number);

for i = 1:length(splits{attribute_number})
    children_data_sets(i).data = repmat({''}, 1, length(data(1, :)));
end

if is_curr_attribute_numeric
    % numeric attribute values
    % TODO FIX BUG HERE: THE DATA SPLITS ARE INCORRECT
    for i = 1:length(attribute_values)
        numeric_attribute_values(i) = str2num(attribute_values{i});
    end
    numeric_split_values = splits{attribute_number};
    
    for i = 1:length(attribute_values)
        curr_value = numeric_attribute_values(i);
        for j = 1:length(numeric_split_values)
            if(curr_value <= numeric_split_values(j))
                if(strcmp(children_data_sets(j).data{1, end}, ''))
                    children_data_sets(j).data = data(i, :);
                else
                    curr_size_of_child_set = length(children_data_sets(j).data(:, 1));
                    data_point_number = curr_size_of_child_set + 1;
                    children_data_sets(j).data(data_point_number, :) = data(i, :);
                end
                break
            end
        end
    end
else
    %non numeric attribute
    n_children = length(splits{attribute_number});
    % initialize empty children datasets
    children_data_sets(n_children).data = repmat({''}, 1, length(data(1, :)));
    for i = 1:length(attribute_values)
        curr_value = attribute_values{i};
        for j = 1:n_children
            if(strcmp(curr_value, splits{attribute_number}{j}))
                if(~strcmp(children_data_sets(j).data{1, end}, ''))
                    curr_size_of_child_set = length(children_data_sets(j).data(:, 1));
                    data_point_number = curr_size_of_child_set + 1;
                    children_data_sets(j).data(data_point_number, :) = data(i, :);
                else
                    children_data_sets(j).data = data(i, :);
                end
                break
            end
        end
    end
end
end

