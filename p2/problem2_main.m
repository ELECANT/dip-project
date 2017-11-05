% image should be skeleton_orig
oo=0;
% read in the image a : the original image
fp = input('Input the image path: ', 's');
a = imread(fp, 1);
oo=oo+1;
fprintf('Display the image a %d\n', oo);
imshow(a);

% get image b : conduct laplacian and scaling
[b, lap_a, oo] = b_laplacian_scale(a, oo);
oo=oo+1;
fprintf('Display the image b (scaled Laplacian) %d\n', oo);
figure, imshow(b);

% get image c : add laplacian for sharpening   
cc = double(a) + lap;
c = scale255(cc);
oo=oo+1;
fprintf('Display the image c ((a) after Laplacian sharpening) %d\n', oo);
figure, imshow(c);

% get image d : apply Sobel on a
d = d_sobel(a);
oo=oo+1;
fprintf('Display the image d ((a) after Sobel and scale) %d\n', oo);
figure, imshow(d);

% get image e : apply 5x5 average filter on d
e = e_5x5_average(d);
oo=oo+1;
fprintf('Display the image e ((d) after Sobel and scale) %d\n', oo);
figure, imshow(e);

% get image f : f = c*e
% note that trans to double to avoid truncation
f = scale255(double(c) .* double(e));
oo=oo+1;
fprintf('Display the image f (f = c*e) %d\n', oo);
figure, imshow(f);

% get image g : g = a + f
% note that trans to double to avoid truncation
g = scale255(double(a) + double(f));
oo=oo+1;
fprintf('Display the image g (g = a+f) %d\n', oo);
figure, imshow(g);

% get image h : h = c*g^gamma, c=1.0, gamma=0.5
h = scale255(double(g) .^ 0.5);
oo=oo+1;
fprintf('Display the image h (h = g^0.5) %d\n', oo);
figure, imshow(h);