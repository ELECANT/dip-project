% DIP problem 5
% Restoration in frequency domain
% inverse filtering and wiener filtering
% author: wang.yiqing
% Dependent function: dft_filter_func, gen_filter, scale255, 
%                     wiener_filer, gen_gaussian

%=========================================================================
warning('off');
% read in image 
fp = 'book_cover.jpg';
f_orig = imread(fp);
figure, imshow(f_orig);
imwrite(f_orig, 'book_cover.png');
% display frequency spectrum
F = fftshift(fft2(f_orig));  
imF = scale255(log10(abs(F)+1));
figure, imshow(imF, []);
imwrite(imF, 'book_spectrum.png');

%=========================================================================
% (a) implement degradation function H
% generate basic filter
f_orig = double(f_orig);
[M, N] = size(f_orig);
% generate meshgrid
[V, U] = meshgrid(1:N, 1:M);
U = U - M/2;
V = V - N/2;
% define degradation function H
T = 1; a = 0.1; b = 0.1;
uavb = pi*( U*a + V*b + eps);
H = T./uavb .* sin( uavb ) .* exp( -1j*uavb );
H = ifftshift(H);

%=========================================================================
% (b) use H to degragete f_orig
f_blur = dft_filter_func(f_orig, H);
figure, imshow(f_blur);
imwrite(f_blur, '5_blur.png');

%=========================================================================
% (c)(e) add Gaussian noise of different variances
noise_gaussian_650 = gen_gaussian(0, sqrt(650), M, N);
f_blur_gaussian_650 = scale255(double(f_blur) + noise_gaussian_650);
figure, imshow(f_blur_gaussian_650);
imwrite(f_blur_gaussian_650, '5_blur_gaussian_650.png');

noise_gaussian_65 = gen_gaussian(0, sqrt(65), M, N);
f_blur_gaussian_65 = scale255(double(f_blur) + noise_gaussian_65);
figure, imshow(f_blur_gaussian_65);
imwrite(f_blur_gaussian_65, '5_blur_gaussian_65.png');

noise_gaussian_006 = gen_gaussian(0, sqrt(0.06), M, N);
f_blur_gaussian_006 = scale255(double(f_blur) + noise_gaussian_006);
figure, imshow(f_blur_gaussian_006);
imwrite(f_blur_gaussian_006, '5_blur_gaussian_006.png');

%=========================================================================
% (d)(e) restoration
% restoration blurred-only image with inverse filter(wiener filter with K=0)
f_inverse_blur = wiener_filter(H, 0, zeros(M, N), f_orig);
figure, imshow(f_inverse_blur);
imwrite(f_inverse_blur, '5_inverse_blur.png');
f_inverse_650 = wiener_filter(H, 0, noise_gaussian_650, f_orig); %0.01
figure, imshow(f_inverse_650);
imwrite(f_inverse_650, '5_inverse_650.png');
f_inverse_65 = wiener_filter(H, 0, noise_gaussian_65, f_orig); % 0.008
figure, imshow(f_inverse_65);
imwrite(f_inverse_65, '5_inverse_65.png');
f_inverse_006 = wiener_filter( H, 0, noise_gaussian_006, f_orig); %0.002
figure, imshow(f_inverse_006);
imwrite(f_inverse_006, '5_inverse_006.png');

% restoration blurred noise image with Wiener filter
f_wiener_blur = wiener_filter(H, 0, zeros(M, N), f_orig); %0
figure, imshow(f_wiener_blur);
imwrite(f_wiener_blur, '5_wiener_blur.png');
f_wiener_650 = wiener_filter(H, 0.01, noise_gaussian_650, f_orig); %0.01
figure, imshow(f_wiener_650);
imwrite(f_wiener_650, '5_wiener_650.png');
f_wiener_65 = wiener_filter(H, 0.008, noise_gaussian_65, f_orig); % 0.008
figure, imshow(f_wiener_65);
imwrite(f_wiener_65, '5_wiener_65.png');
f_wiener_006 = wiener_filter( H, 0.002, noise_gaussian_006, f_orig); %0.002
figure, imshow(f_wiener_006); 
imwrite(f_wiener_006, '5_wiener_006.png');

