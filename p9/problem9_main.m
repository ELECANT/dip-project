% DIP problem 9
% Image Segmentation
% Edge dectection: Roberts, Prewitt, Sobel, Marr-Hildreth, Canny
% Threshold segmentation: Otsu's method
% author: wang.yiqing
% Dependent function: TODO

%=========================================================================
% read in image 
fp = 'building.tif';
f_orig = imread(fp);
[M, N] = size(f_orig);
figure, imshow(f_orig);
f_orig(100:110, 100:110)
%=========================================================================
% Sobel
