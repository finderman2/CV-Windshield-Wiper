%function [] = raindetect(photo)

    %% Convert to grayscale then binary
    %image = snapshot(cam);
    image = RainCar;
    figure;

    %Show image before processing
    subplot(2,2,1);
    imshow(image), title('Original');
    %convert to grayscale
    imggray = rgb2gray(image);
    %then binary and show
    imgbw = im2bw(imggray);
    subplot(2,2,2);
    imshow(imgbw), title('Binary');


    %% Apply edge detection and show result
    clean = bwareaopen(imgbw, 10);
    edges = edge(clean,'sobel', .23);
    subplot(2,2,3);
    imshow(edges),title('After Sobel mask');

    %% Dilate Image
    final = imdilate(edges, strel('disk', 3));
    subplot(2,2,4);
    imshow(final), title('After Dilation');
    
    %% Run Image Statistics
    %disp(mean2(final(:)));
    stats = double(final);
    ImgConv = sum(sum(conv2(stats, ones(3)/9, 'same' )));
    disp(ImgConv);
    
    %% Write Message out to console
    if ImgConv > 100000
        disp('Raining, Wipers On');
    else
        disp('Not Raining');
    end
