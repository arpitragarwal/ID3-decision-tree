function combined_data_set = combine_data_sets(data_set_1, data_set_2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if(isempty(data_set_1{1,1}))
    combined_data_set = data_set_2;
elseif(isempty(data_set_2{1,1}))
    combined_data_set = data_set_1;
else
    combined_data_set = [data_set_1; data_set_2];
end
end

