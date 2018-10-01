classdef TreeNode < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data
        metadata
        split_attribute_no
        split_attribute_name
        children_labels
        children TreeNode;
        splits
        gain = [];
        is_leaf = false;
        class_label
        label_count
        splitting_value_index = [];
    end
    
    methods
        function obj = TreeNode(data, metadata)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.data = data;
            obj.metadata = metadata;
        end
        
        function determine_candidate_splits(obj)
            obj.splits = determine_candidate_splits(obj.data, obj.metadata);
        end
        
        function count_class_labels(obj)
            class_labels = obj.data(:, end);
            unique_class_labels = obj.metadata.attribute_values{end};
            obj.label_count = zeros(length(unique_class_labels), 1);
            for i = 1:length(unique_class_labels)
                obj.label_count(i) = sum(ismember(class_labels, unique_class_labels{i}));
            end
        end
        
        function determine_class_label(obj)
            %TODO 1. need to add functionality for equal number of class
            %labels. 2. need to add functionality for 0 datapoints reaching
            %leaf node
            class_labels = obj.data(:, end);
            unique_class_labels = obj.metadata.attribute_values{end};
            [~, label_index] = max(obj.label_count);
            obj.class_label = unique_class_labels{label_index};
        end
        
        function are_criteria_met = are_stopping_criteria_met(obj, m)
            class_labels = obj.data(:, end);
            unique_class_values = unique(class_labels);
            if (length(class_labels) < m)
                obj.is_leaf = true;
            elseif (length(unique_class_values)<=1)
                obj.is_leaf = true;
            elseif (max(obj.gain) <= 0)
                obj.is_leaf = true;
            else
                no_of_unique_labels = ones(1, length(obj.data(1,:)));
                for i = 1:length(obj.data(1,:))
                    no_of_unique_labels(i) = length(unique(obj.data(:, i)));
                end
                % no_of_unique_labels(i) == 1 implies that either the
                % original dataset only had one label for feature i or that
                % feature i has already been used earlier in the tree
                if(max(no_of_unique_labels(1:end-1)) == 1)
                    obj.is_leaf = true;
                end
            end
            are_criteria_met = obj.is_leaf;
        end
        
        function find_best_split(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            for attribute_number = 1:length(obj.metadata.attribute_names)
                [obj.gain(attribute_number), obj.splitting_value_index(attribute_number)]= ...
                    info_gain(obj.data, obj.metadata, obj.splits, attribute_number);
            end
            [~, obj.split_attribute_no] = max(obj.gain(1:end - 1));
            obj.split_attribute_name = obj.metadata.attribute_names{obj.split_attribute_no};
        end
        
        function populate_children(obj, m)
            are_attributes_numeric = obj.metadata.is_attribute_numeric;
            if ~are_attributes_numeric(obj.split_attribute_no) % Non numerical features
                children_data_sets = split_data_sets(obj.data, obj.metadata,...
                    obj.splits, obj.split_attribute_no);
            else
                all_possible_child_data_sets = split_data_sets(obj.data, obj.metadata,...
                    obj.splits, obj.split_attribute_no);
                
                % construct the correct 2 children data sets here
                children_data_sets(1).data = repmat({''}, 1, length(obj.data(1, :)));
                children_data_sets(2).data = repmat({''}, 1, length(obj.data(1, :)));
                
                for j = 1:length(all_possible_child_data_sets)
                    if j <= obj.splitting_value_index(obj.split_attribute_no)
                        children_data_sets(1).data  = ...
                            combine_data_sets(children_data_sets(1).data, all_possible_child_data_sets(j).data);
                    else
                        children_data_sets(2).data =...
                            combine_data_sets(children_data_sets(2).data, all_possible_child_data_sets(j).data);
                    end
                end
            end
            obj.children_labels = obj.metadata.attribute_values{obj.split_attribute_no};
            for i = 1:length(children_data_sets)
                obj.children(i) = make_subtree(children_data_sets(i).data, obj.metadata, m);
            end
        end

        function label = find_correct_child(obj, test_data_point)
            if obj.is_leaf
                label = obj.class_label;
            elseif ~obj.metadata.is_attribute_numeric(obj.split_attribute_no) % Non Numeric Attribute
                child_number = find(strcmp(test_data_point{obj.split_attribute_no}, obj.children_labels));
                label = obj.children(child_number).find_correct_child(test_data_point);
            else % Numeric Attribute
                possible_splits_for_attribute = obj.splits{obj.split_attribute_no};
                split_value = possible_splits_for_attribute(obj.splitting_value_index(obj.split_attribute_no));
                test_attribute_value = str2num(test_data_point{obj.split_attribute_no});
                if (test_attribute_value <= split_value)
                    % here we just have 2 children - less than value and
                    % more than value
                    label = obj.children(1).find_correct_child(test_data_point);
                else
                    label = obj.children(2).find_correct_child(test_data_point);
                end
            end
        end
    end
end

