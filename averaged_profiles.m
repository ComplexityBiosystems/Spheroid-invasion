%z-levels, time-steps, bins
datas_profiles=zeros(19,31,99);

for zindx=18:36
    for t=1:length(data_channel_1)
        data_h = importdata(...
            ['distance_distribution_zindx_'...
            num2str(zindx, '%02d')...
            '_t_' num2str(t, '%03d') '.dat']);
        edgs = data_h(:,1);
        datas_profiles(zindx-18+1, t, :) = data_h(:,2);
    end
end


cmap_here = parula(31);

axis square
line([0 0], [0 30000], 'Color', 'k', 'LineStyle' , '--')
hold on
for t=1:31
    plot(edgs, nanmean( squeeze(datas_profiles(:,t,:)))',...
        'Color', cmap_here(t,:), 'LineWidth', 2)
    %     write_2_column_table(['distance_distribution_averaged_over_z_time_'...
    %         num2str(t, '%03d') '.dat'],...
    %         edgs, nanmean( squeeze(datas_profiles(:,t,:)))')
    hold on
    
    
end


text(-150,10000,'Inside', 'Interpreter', 'Latex', 'FontSize', 20)
text(100,10000,'Outside', 'Interpreter', 'Latex', 'FontSize', 20)

xlabel('Distance ($\mu m$)', 'Interpreter', 'latex')
ylabel('Count', 'Interpreter', 'latex')

c=colorbar;
c.TickLabelInterpreter='LaTeX';
c.Label.String='Time, hours';
c.Label.Interpreter='LaTeX';
c.Label.FontSize=20;
caxis([1/31  1]*2/3*31)
set(gca,'FontSize',20)
set(gca,'TickLabelInterpreter','LaTeX')
set(gcf,'color','w');
export_fig('averaged_over_z_versus_time_new_version.pdf')