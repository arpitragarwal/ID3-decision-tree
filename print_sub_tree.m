function print_sub_tree(node, level)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

pre_string = '';
for i = 1:level
    pre_string = [pre_string, '|    '];
end

isnumeric = node.metadata.is_attribute_numeric(node.split_attribute_no);
n_children = length(node.children);
for i = 1:n_children
    child_i = node.children(i);
    
    if isempty(child_i.children)
        % if this child is a leaf then print label
        if isnumeric
            if i == 1
                sign = ' <= ';
            else
                sign = ' > ';
            end
            split_value = node.splits{node.split_attribute_no}(node.splitting_value_index(node.split_attribute_no));
            split_val_str = num2str(split_value);
            disp([pre_string, node.split_attribute_name, sign, split_val_str])
        else
            disp([pre_string, node.split_attribute_name, ' = ', node.children_labels{i}, ...
                ' : ', child_i.class_label])
        end
    else
        % if this child is NOT a leaf then print subtree
        if isnumeric
            if i == 1
                sign = ' <= ';
            else
                sign = ' > ';
            end
            split_value = node.splits{node.split_attribute_no}(node.splitting_value_index(node.split_attribute_no));
            split_val_str = num2str(split_value);
            disp([pre_string, node.split_attribute_name, sign, split_val_str])
        else
            disp([pre_string, node.split_attribute_name, ' = ', node.children_labels{i}])
        end
        print_sub_tree(child_i, level + 1)
    end
end

end

