function node = make_subtree(data, metadata, m, parent_label_count)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

node = TreeNode(data, metadata, parent_label_count);
node.determine_candidate_splits
node.find_best_split
node.count_class_labels
if(node.are_stopping_criteria_met(m))
    node.determine_class_label
else
    node.populate_children(m)
end
end

