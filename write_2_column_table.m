function [] = write_2_column_table(filename,arr1, arr2)
% write_2_column_table(filename,arr1, arr2)
% writes to filename a table with two columns arr1' and arr2'
t_out=table(arr1', arr2');
writetable(t_out, filename, 'WriteVariableNames', false, ...
    'Delimiter', '\t')
end