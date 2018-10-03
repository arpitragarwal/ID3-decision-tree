clear; clc; close all; format compact;

%case_name = 'diabetes';
case_name = 'heart';
training_filename = ['data/', case_name, '_train.arff.txt'];
test_filename = ['data/', case_name, '_test.arff.txt'];

[training_data, training_metadata] = read_arff_file(training_filename);
[test_data, test_metadata] = read_arff_file(test_filename);
fclose all;

m_values = [2, 5, 10, 20];
for i = 1:length(m_values)
    m = m_values(i);
    tree = make_subtree(training_data, training_metadata, m);
    [number_correctly_classified(i), total_no_of_test_instances] = ...
        make_predictions(test_data, tree);
end
percent_n_correct = 100*number_correctly_classified./total_no_of_test_instances;
%%
figure()
plot(m_values, percent_n_correct, 'o-')
xlabel('m')
ylabel('% accuracy')
ylim([50 100])
grid on
legend(case_name)
savefig(gcf, ['../figures/accuracy_vs_sizeTree_', case_name,'.fig'])