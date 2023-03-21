all_vals_ch_1=cell(31,1);
all_edgs_ch_1=cell(31,1);

for t = 1:31
    disp(t)
    points = analyse_one_stack(data_channel_1{t});
    xs_mean = mean(points(:,1));
    ys_mean = mean(points(:,2));
    zs_mean = mean(points(:,3));
    
    rs2 = (points(:,1)-xs_mean).^2 + ...
        (points(:,2)-ys_mean).^2 + ...
        (points(:,3)-zs_mean).^2;
    
    rs=sqrt(rs2);
    
    h = histogram(rs,linspace(0,500,100),'Normalization', 'pdf');
    
    all_vals_ch_1{t}=h.Values;
    all_edgs_ch_1{t}=h.BinEdges;
    
end

close all

for t=1:3:31
    plot(all_edgs_ch_1{t}(1:end-1), all_vals_ch_1{t}./all_edgs_ch_1{t}(1:end-1),...
        'DisplayName', num2str(t),...
        'Color', colors(t,:))
    hold on
end

legend()