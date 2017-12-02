% DIP problem 6
% Geometric transformation and interpolation
% author: wang.yiqing
% Dependent functions: TODO

% ========================================================================

fp = 'ray_trace_bottle.tif';
f_orig = mat2gray(imread(fp));
figure, imshow(f_orig);
[M, N] = size(f_orig);

% translation - right 200 and down 100 
T_translation = [1 0 100; 0 1 200; 0 0 1];
%f_translation_bi = mytransform(f_orig, T_translation, 'bilinear', 'boundX', [1,M], 'boundY', [1,N], 'fillValue', 0.5);
%f_translation_ne = mytransform(f_orig, T_translation, 'nearest', 'boundX', [1,M], 'boundY', [1,N], 'fillValue', 0.5);
%figure, imshow(f_translation_bi);
%figure, imshow(f_translation_ne);
%imwrite(f_translation_bi, 'translation_bi.png');
%imwrite(f_translation_ne, 'translation_ne.png');

% rotation - pi/6
theta = pi/6;
T_rotation = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
f_rotation_bi = mytransform(f_orig, T_rotation, 'bilinear', 'fillValue', 0.5);
f_rotation_ne = mytransform(f_orig, T_rotation, 'nearest', 'fillValue', 0.5);
figure, imshow(f_rotation_bi);
figure, imshow(f_rotation_ne);
%imwrite(f_rotation_bi, 'rotation_bi.png');
%imwrite(f_rotation_ne, 'rotation_ne.png');

% rescale - horizontal 1.5, vertical 2
s1 = 1.5; s2 = 2;
T_scale = [s1 0 0; 0 s2 0; 0 0 1];
%f_scale_bi = mytransform(f_orig, T_scale, 'bilinear', 'boundX', [1,M], 'boundY', [1,N], 'fillValue', 0.5);
%f_scale_ne = mytransform(f_orig, T_scale, 'nearest', 'boundX', [1,M], 'boundY', [1,N], 'fillValue', 0.5);
%figure, imshow(f_scale_bi);
%figure, imshow(f_scale_ne);
%imwrite(f_scale_bi, 'scale_bi.png');
%imwrite(f_scale_ne, 'scale_ne.png');



