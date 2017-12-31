% DIP problem 9
% Image Segmentation
% Edge dectection: Roberts, Prewitt, Sobel, Marr-Hildreth, Canny
% Threshold segmentation: Otsu's method
% author: wang.yiqing
% Dependent function: roberts, prewitt, sobel, marr_hildreth, zero_cross, canny 
% 					  otsu_thresholding, basic_global_thresholding

%=========================================================================

% read in image 
fp = 'building.tif';
f_orig = imread(fp);
[M, N] = size(f_orig);
figure, imshow(f_orig);
imwrite(f_orig, 'building.png');

%=========================================================================
% 1). Edge detection

% Roberts filter
f_roberts = roberts(f_orig);
figure, imshow(f_roberts);
imwrite(f_roberts, '9_roberts.png');

% Prewitt filter
f_prewitt = prewitt(f_orig);
figure, imshow(f_prewitt);
imwrite(f_prewitt, '9_prewitt.png');

% Sobel filter
f_sobel = prewitt(f_orig);
figure, imshow(f_sobel);
imwrite(f_sobel, '9_sobel.png');

% Marr-Hildreth
[~, f_zerocross_0] = marr_hildreth(f_orig, 4, 25, 0);
[~, f_zerocross_4] = marr_hildreth(f_orig, 4, 25, 0.04);
[~, f_zerocross_8] = marr_hildreth(f_orig, 4, 25, 0.08);
[f_marrhildreth, f_zerocross_12] = marr_hildreth(f_orig, 4, 25, 0.12);
figure, imshow(f_marrhildreth);
figure, imshow(f_zerocross_0);
figure, imshow(f_zerocross_4);
figure, imshow(f_zerocross_8);
figure, imshow(f_zerocross_12);
imwrite(f_marrhildreth, '9_marrhildreth.png');
imwrite(f_zerocross_0, '9_zerocross_0.png');
imwrite(f_zerocross_4, '9_zerocross_4.png');
imwrite(f_zerocross_8, '9_zerocross_8.png');
imwrite(f_zerocross_12, '9_zerocross_12.png');

% Canny
[f_canny, f_threshold_only] = canny(f_orig, 4, 25, 0.01, 0.02);
figure, imshow(f_canny);
imwrite(f_canny, '9_canny.png');
figure, imshow(f_threshold_only);
imwrite(f_canny, '9_threshold_only.png');


%=========================================================================
% 2). Global thresholding

% read in original image
fp = 'polymersomes.tif';
f_orig = imread(fp);
[M, N] = size(f_orig);
figure, imshow(f_orig);
imwrite(f_orig, 'polymersomes.png');
% histogram
fhist = figure;
imhist(f_orig);
saveas(fhist, '9_polymersomes_hist.png', 'png');

% basic global thresholding
[f_basic_threshold, T_basic] = basic_global_thresholding(f_orig, mean(mean(f_orig)), 1);
fprintf('T_basic %f', T_basic); % T_basic 169.394997
figure, imshow(f_basic_threshold);
imwrite(f_basic_threshold, '9_threshold_basic.png');

% Otsu's method
[f_otsu, kstar, eta] = otsu_thresholding(f_orig);
figure, imshow(f_otsu);
imwrite(f_otsu, '9_threshold_otsu.png');
fprintf('Otsu threshold = %f, Seperability = %f', kstar, eta);
%Otsu threshold = 181.000000, Seperability = 0.465212




