classdef TreeNode < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data
        metadata
        split_attribute_no
        children TreeNode;
        splits
        gain = [];
        is_leaf = false;
        class_label
        label_count
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
            class_labels = obj.data(:, end);
            unique_class_labels = obj.metadata.attribute_values{end};
            [~, label_index] = max(obj.label_count);
            obj.class_label = unique_class_labels{label_index};
        end
        
        function are_criteria_met = are_stopping_criteria_met(obj)
            class_labels = obj.data(:, end);
            unique_class_values = unique(class_labels);
            m = 1;
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
            for i = 1:length(obj.metadata.attribute_names)
                attribute_number = i;
                obj.gain(i) = info_gain(obj.data, obj.metadata, obj.splits, attribute_number);
            end
            [~, obj.split_attribute_no] = max(obj.gain(1:end - 1));
        end
        
        function populate_children(obj)
            children_data_sets = split_data_sets(obj.data, obj.metadata,...
                obj.splits, obj.split_attribute_no);
            for i = 1:length(children_data_sets)
                obj.children(i) = make_subtree(children_data_sets(i).data, obj.metadata);
            end
        end
    end
end

