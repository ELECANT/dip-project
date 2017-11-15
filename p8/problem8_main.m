% DIP problem 8
% Morphological reconstruction
% 3 Tasks part in main
% author: wang.yiqing
% Dependent function: erosion, dilatoin, opening_reconstruction,
%                     dilation_reconstruction

%=========================================================================

% read in the image a : the original image
fp = 'Fig0929(a).tif';
f_orig = imread(fp, 1);
figure, imshow(f_orig);
B = ones(51,1);
[M, N] = size(f_orig);

%=========================================================================
% Task 1 - Opening by reconstruction

% image 9.29(b) erosion of 9.29(a)
f_one_erosion = erosion(f_orig, B);
figure, imshow(f_one_erosion); 
% image 9.29(c) opening of 9.29(a)
f_open = dilation(f_one_erosion, B);
figure, imshow(f_open);
% image 9.29(d) opening by reconstruction
n_size = 1;
[f_open_reconstruction, k_times] = opening_reconstruction(f_orig, B, n_size);
k_times
figure, imshow(f_open_reconstruction);

%=========================================================================
% Task 2 - Filling holes

% image 9.31(b) completion of 9.31(a)
f_completion = 1-f_orig;
figure, imshow(f_completion);
% image 9.31(c) marker for dilation reconstruction
f_board_marker = f_completion;
f_board_marker(2:M-1, 2:N-1) = 0;
figure, imshow(f_board_marker);
% image 9.31(d) hole filling
[f_hole_filling, k_times] = dilation_reconstruction(f_board_marker, f_completion, ones(3, 3));
k_times
f_hole_filling = 1 - f_hole_filling;
figure, imshow(f_hole_filling);

%=========================================================================
% Task 3 - Border clearing

% image 9.32(a) marker image
f_marker = f_orig;
f_marker(2:M-1, 2:N-1) = 0;
[f_dilation_reconstruction, k_times] = dilation_reconstruction(f_marker, f_orig, ones(3, 3));
k_times
figure, imshow(f_dilation_reconstruction);
% image 9.32(b) without letter on border 
f_no_border = f_orig - f_dilation_reconstruction;
figure, imshow(f_no_border);

