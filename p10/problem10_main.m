% DIP problem 10
% Image Representation and Description
% Border following: Freeman chain code, first difference
% Description: PCA
% author: wang.yiqing
% Dependent function: arithmetic_mean, otsu_thresholding, 

%=========================================================================
% PART1 - Border following

% read in image 
fp = 'noisy_stroke.tif';
f_orig = imread(fp);
[M, N] = size(f_orig);
%figure, imshow(f_orig);
%imwrite(f_orig, 'noisy_stroke.png');

% 9x9 mean filter
f_mean = arithmetic_mean(f_orig, 9);
%figure, imshow(f_mean);
%imwrite(f_mean, '10_mean.png');

% otsu thresholding
[f_otsu, ~, ~] = otsu_thresholding(f_mean);
%figure, imshow(f_otsu);
%imwrite(f_otsu, '10_otsu.png');

% longest outer boundary
%{
[f_long_chain, long_chain_code] = border_following(f_otsu);
figure, imshow(f_long_chain);
long_chain_code;
imwrite(f_long_chain, '10_long_chain.png');
%}

% large grid outer boundary

[f_large_grid, f_highlight_grid, chain_code, first_diff, f_straight_border] = border_following_resample(f_otsu, 50);
figure, imshow(f_large_grid);
figure, imshow(f_highlight_grid);
figure, imshow(f_straight_border);
%imwrite(f_large_grid, '10_large_grid.png');
%imwrite(f_straight_border);
chain_code
%first_diff



