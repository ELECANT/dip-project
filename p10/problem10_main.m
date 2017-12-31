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
figure, imshow(f_orig);
imwrite(f_orig, 'noisy_stroke.png');

% 9x9 mean filter
f_mean = arithmetic_mean(f_orig, 9);
figure, imshow(f_mean);
imwrite(f_mean, '10_mean.png');

% otsu thresholding
[f_otsu, ~, ~] = otsu_thresholding(f_mean);
figure, imshow(f_otsu);
imwrite(f_otsu, '10_otsu.png');

% longest outer boundary

[f_long_chain, long_chain_code] = border_following(f_otsu);
figure, imshow(f_long_chain);
long_chain_code;
imwrite(f_long_chain, '10_long_chain.png');

% large grid outer boundary

[f_large_grid, f_highlight_grid, chain_code, first_diff, f_straight_border] = border_following_resample(f_otsu, 50);
figure, imshow(f_large_grid);
figure, imshow(f_highlight_grid);
figure, imshow(f_straight_border);
imwrite(f_large_grid, '10_large_grid.png');
imwrite(f_large_grid, '10_highlight_grid.png');
imwrite(f_straight_border,'10_straight_border.png');
chain_code
first_diff

%{
chain_code =
  1 至 22 列
     0     0     0     7     7     6     6     6     6     6     5     5     4     4     3     4     3     3     2     1     2     1
  23 至 24 列
     2     1

first_diff =
  1 至 22 列
     7     0     0     7     0     7     0     0     0     0     7     0     7     0     7     1     7     0     7     7     1     7
  23 至 24 列
     1     7
%}

%=========================================================================
% PART2 - Principle component analysis

% readin images
imgpath = './washingtonDC/';
m = 564;
n = 564;
img_set = zeros(6, m*n);
for i = (1:6)
    imgf = imread([imgpath 'WashingtonDC_Band' num2str(i) '.tif']);
    imgf = reshape(imgf, m*n, 1); % reshape to col vector
    img_set(i, :) = imgf;
    imwrite(imgf, [imgpath 'WashingtonDC_Band' num2str(i) '.png']);
end
img_set = double(img_set);

% use all components
[eigenval_6, pc_6, ~] = pca(img_set, 6);
for i = (1:6)
    imgf = uint8(reshape(pc_6(i,:), m, n));
    %figure, imshow(imgf);
    imwrite(imgf, ['10_components_' num2str(i) '.png']);
end
eigenval_6
%{
eigenval_6 =

   1.0e+04 *

    1.0344
    0.2966
    0.1401
    0.0203
    0.0094
    0.0031
%}
% use two components for reconstruction
[~, ~, rec_2] = pca(img_set, 2);
for i = (1:6)
    imgf = uint8(scale255(reshape(rec_2(i,:), m, n)));
    figure, imshow(imgf);
    imwrite(imgf, ['10_reconstruct_' num2str(i) '.png']);
    % calculate the difference
    diff = uint8(scale255(reshape(rec_2(i,:)-img_set(i,:), m, n)));
    figure, imshow(diff);
    imwrite(diff, ['10_different_' num2str(i) '.png']);
end



