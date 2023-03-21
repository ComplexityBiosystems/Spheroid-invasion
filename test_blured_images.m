% main computation of profile is done here

the_fldr = '/Users/oleksandrchepizhko/workspace/Gattinoni/DATA/mix_thick/';

for zindx=30
    disp(zindx)
    total_intensities = zeros(length(data_channel_1),1);
    histograms=cell(length(data_channel_1),1);
    
    for t=1:length(data_channel_1)
        disp(['t=' num2str(t) ' of ' num2str(length(data_channel_1))])
        I = data_channel_1{t}(:,:,zindx);
        
        J=I;
        
        %intImage = integralImage(I);
        %avgH = integralKernel([1 1 5 5], 1/(5*5));
        %J = integralFilter(intImage, avgH);
        
        [~,threshold] = edge(J,'sobel');
        fudgeFactor = 0.01;
        J = edge(J,'sobel',threshold * fudgeFactor);
        se90 = strel('line',5,90);
        se0 = strel('line',5,0);
        J = imdilate(J,[se90 se0]);
        
        J = imfill(J,'holes');
        
        J = imclearborder(J,4);
        
        J = bwareaopen(J,12000);
        
        % se90 = strel('line',20,90);
        % se0 = strel('line',20,0);
        %
        % J = imdilate(J,[se90 se0]);
        
        
        BWoutline = bwperim(J);
        
        I0 = data_channel_0{t}(:,:,zindx);
        pborder = analyse_one_snapshot(BWoutline);
        immune_cells = analyse_one_snapshot(I0);
        %I03=zeros(1024,1024,3,'uint8');
        
        min_distances_all = zeros(length(immune_cells),1);
        for i=1:length(immune_cells)
            min_distances_all(i)=...
                nearest_distance(immune_cells(i,:),...
                pborder);
            if min_distances_all(i)<0
                total_intensities(t)=total_intensities(t)+...
                    I0(round(immune_cells(i,2)/0.618546072336379),...
                    round(immune_cells(i,1)/0.618546072336379));
            end
        end
        
        h=histogram(min_distances_all,linspace(-200,200,100));
        
        histograms{t}.edges = h.BinEdges(1:end-1);
        histograms{t}.vls = h.Values;
        redChannel=I0;
        greenChannel=I0;
        blueChannel=I0;
        
        
        BW2 = imdilate(BWoutline, strel('disk',3));
        
        redChannel(BW2)=0;
        greenChannel(BW2)=255;
        blueChannel(BW2)=0;
        
        rgbImage = cat(3, redChannel, greenChannel, blueChannel);
        
        redChannel_1 = I;
        greenChannel_1 = I;
        blueChannel_1 = I;
        
        
        
        redChannel_1(BW2)=0;
        greenChannel_1(BW2)=255;
        blueChannel_1(BW2)=0;
        
        rgbImage_1 = cat(3, redChannel_1, greenChannel_1, blueChannel_1);
        
        % I=imadjust(I);
        % I(BWoutline)=255;
        image_out = imfuse(rgbImage_1,rgbImage,'montage');
        
        imwrite(image_out, [the_fldr  'thick_border_montage_zindx_'...
            num2str(zindx,'%03d') '_time_' num2str(t,'%03d' )...
            '.tif'])
        
        imshow(image_out)
        
        drawnow
        
        hold on
        
    end
end

figure 
for i=1:length(data_channel_1)
plot(histograms{i}.edges, histograms{i}.vls./histograms{i}.edges, ...
    'Color', i/length(data_channel_1)*[1 1 1])
write_2_column_table(['distance_distribution_zindx_'...
    num2str(zindx, '%02d') '_t_' num2str(i, '%03d')...
    '.dat'],histograms{i}.edges, histograms{i}.vls )
hold on
drawnow
end

disp('all done')
load gong.mat

sound(y);
