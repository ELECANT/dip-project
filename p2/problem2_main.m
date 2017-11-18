% DIP problem 2
% Spatial Enhancement Methods
% author: wang.yiqing
% Dependent function: scale255, relicate_padding, 5x5_average,
% sobel, laplacian_scale

% ========================================================================

% image should be skeleton_orig
% read in the image a : the original image
fp = 'skeleton_orig.tif';
a = imread(fp, 1);
imshow(a);
imwrite(a, '2-a.png');

% get image b : conduct laplacian and scaling
[b, lap_a] = b_laplacian_scale(a);
figure, imshow(b);
imwrite(b, '2-b.png');

% get image c : add laplacian for sharpening   
cc = double(a) + lap_a;
c = scale255(cc);
figure, imshow(c);
imwrite(c, '2-c.png');

% get image d : apply Sobel on a
d = d_sobel(a);
figure, imshow(d);
imwrite(d, '2-d.png');

% get image e : apply 5x5 average filter on d
e = e_5x5_average(d);
figure, imshow(e);
imwrite(e, '2-e.png');

% get image f : f = c*e
% note that trans to double to avoid truncation
f = scale255(double(c) .* double(e));
figure, imshow(f);
imwrite(f, '2-f.png');

% get image g : g = a + f
% note that trans to double to avoid truncation
g = scale255(double(a) + double(f));
figure, imshow(g);
imwrite(g, '2-g.png');

% get image h : h = c*g^gamma, c=1.0, gamma=0.5
h = scale255(double(g) .^ 0.5);
figure, imshow(h);
imwrite(h, '2-h.png');
