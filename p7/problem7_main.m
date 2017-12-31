% DIP problem 7
% Transform Image Compression
% DCT block coding, wavelet compression
% author: wang.yiqing
% Dependent function: dct_mask, zonal_coding, thresholding_coding

% ========================================================================
% DCT compression
% ========================================================================

% read in test image
fp = 'lenna.tif';
f_orig = imread(fp, 1);
imshow(f_orig);
imwrite(f_orig, 'lenna.png');

% generate general DCT mask
dctmask = dct_mask(8);

% zonal mask

[f_zonal_5, f_zonal_5_diff] = zonal_coding(f_orig, 8, dctmask, dctmask', 5);
figure, imshow(f_zonal_5);
figure, imshow(f_zonal_5_diff);
imwrite(f_zonal_5, '7_zonal_5.png');
imwrite(f_zonal_5_diff, '7_zonal_5_diff.png');
[f_zonal_2, f_zonal_2_diff] = zonal_coding(f_orig, 8, dctmask, dctmask', 2);
figure, imshow(f_zonal_2);
figure, imshow(f_zonal_2_diff);
imwrite(f_zonal_2, '7_zonal_2.png');
imwrite(f_zonal_2_diff, '7_zonal_2_diff.png');

% threshold mask
[f_threshold_median, f_threshold_median_diff] = threshold_coding(f_orig, 8, dctmask, dctmask');
figure, imshow(f_threshold_median);
figure, imshow(f_threshold_median_diff);
imwrite(f_threshold_median, '7_threshold_median.png');
imwrite(f_threshold_median_diff, '7_threshold_median_diff.png');

