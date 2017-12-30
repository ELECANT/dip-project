function [ imgg, imgcross ] = marr_hildreth( imgf, sigma, n, threshold )
%MARR_HILDRETH 
%   sigma - variance of Gaussian, n - size of gaussiain lowpass filter

% generate gaussian filter
x = (1:n) - (n+1)/2;
y = x';
x = repmat(x, n, 1);
y = repmat(y, 1, n);
D2 = x.^2 + y.^2;
gau_filter = exp(-D2 / (2*sigma*sigma));

% preprocess
[M, N] = size(imgf);
imgf = double(imgf) ./ 255;
f = replicate_padding(imgf, n-1);
f = double(f); % double f

% convolution
g = zeros(M+2*n, N+2*n);
for x = (n : M+n-1)
    for y = (n : N+n-1)
        xlow = fix(x - fix((n-1)/2));
        xhigh = fix(x + fix((n-1)/2));
        ylow = fix(y - fix((n-1)/2));
        yhigh = fix(y + fix((n-1)/2));
        g(x,y) = sum(sum(f(xlow:xhigh,ylow:yhigh) .* gau_filter));
    end
end

f = g(n:M+n-1, n:N+n-1) * 255;
% laplacian
f = replicate_padding(f, 2);
mask = [1 1 1; 1 -8 1; 1 1 1];
g = zeros(M+4, N+4);
for x = (2 : M+3)
    for y = (2 : N+3)
        g(x, y) = sum(sum(f(x-1:x+1, y-1:y+1) .* mask));
    end
end

% do zero cross
g = g(3:M+2, 3:N+2);
imgcross = zero_cross(g, threshold*max(max(g)));

imgg = g; % laplacian result without scale
imgg = scale255(imgg); % this is the image to show
imgcross = scale255(imgcross);


end

