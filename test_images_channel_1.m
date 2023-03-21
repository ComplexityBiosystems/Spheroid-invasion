
the_fldr = '/Users/oleksandrchepizhko/workspace/Gattinoni/DATA/Channel_1/';

data_channel_1=cell(31,1);

for t=1:31
    disp(t)
    data_channel_1{t} = zeros(1024,1024,94);
    for iz = 1:94
        img_h = imread([the_fldr...
            'B16_Serie1_channel1_8bit_t0' num2str(t,'%02d')...
            '_z0' num2str(iz,'%02d')  '.tif']);
        
        data_channel_1{t}(:,:,iz) = img_h;
        
    end
end

    