% DIP problem 6
% Geometric transformation and interpolation
% author: wang.yiqing
% Dependent functions: TODO

% ========================================================================

fp = 'ray_trace_bottle.tif';
f_orig = imread(fp);
figure, imshow(f_orig);
[M, N] = size(f_orig);
T1 = [1 0 3; 0 1 3; 0 0 1]
g = mytransform(f_orig, T1, 'boundX', 100, 'boundY', 200, 'fillValue', 0.5);
% transition 