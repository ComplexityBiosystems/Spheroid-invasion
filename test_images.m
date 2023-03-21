%% reads files from Channel_0 folder to a Matlab cell-data-structure: 
% data_channel_0 has dimensions of time 
% and matrix(es) of 3 spatial dimensions.


the_fldr = '/Users/oleksandrchepizhko/workspace/Gattinoni/DATA/Channel_0/';

data_channel_0=cell(31,1);

for t=1:31
    disp(t)
    data_channel_0{t} = zeros(1024,1024,94);
    for iz = 1:94
        img_h = imread([the_fldr...
            'B16_Serie1_channel0_8bit_t0' num2str(t,'%02d')...
            '_z0' num2str(iz,'%02d')  '.tif']);
        
        data_channel_0{t}(:,:,iz) = img_h;
        
    end
end

    

