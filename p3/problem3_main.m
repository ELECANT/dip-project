% DIP problem 3
% Filtering in frequency domian
% ideal, Gaussian, Butterworth lowpass/highpass
% author: wang.yiqing
% Dependent function: dft_filter_func, gen_filter, scale255

%=========================================================================
% read in image 
warning('off');
fp = 'characters_test_pattern.tif';
f_orig = imread(fp, 1);
[M, N] = size(f_orig);
[U, V] = gen_filter(M, N);
D2 = U.^2 + V.^2;
imshow(f_orig);
imwrite( f_orig, 'characters_test_pattern.png');
% display the origin spectrum image
F = fftshift(fft2(f_orig));  
imF = scale255(log10(abs(F)+1));
figure, imshow(imF, []);
imwrite(imF, 'spectrum.png');

%=========================================================================
% Ideal lowpass filter 

% 1. radius = 10
H_ILPF_10 = (D2 <= 10*10);
[g_ILPF_10, ratio_ILPH_10] = dft_filter_func(f_orig, H_ILPF_10);
figure, imshow(g_ILPF_10);
imwrite(g_ILPF_10, 'ILPF_10.png');
fprintf('ILPF_10 %f\n', ratio_ILPH_10);
% 2. radius = 100
H_ILPF_100 = double(D2 <= 100*100);
[g_ILPF_100, ratio_ILPF_100] = dft_filter_func(f_orig, H_ILPF_100);
figure, imshow(g_ILPF_100);
imwrite(g_ILPF_100, 'ILPF_100.png');
fprintf('ILPF_100 %f\n', ratio_ILPF_100);
% 3. radius = 1000
H_ILPF_1000 = (D2 <= 1000*1000);
[g_ILPF_1000, ratio_ILPF_1000] = dft_filter_func(f_orig, H_ILPF_1000);
figure, imshow(g_ILPF_1000);
imwrite(g_ILPF_1000, 'ILPF_1000.png');
fprintf('ILPF_1000 %f\n', ratio_ILPF_1000);
% 4. radius = 4000
H_ILPF_4000 = (D2 <= 4000*4000);
[g_ILPF_4000, ratio_ILPF_4000] = dft_filter_func(f_orig, H_ILPF_4000);
figure, imshow(g_ILPF_4000);
imwrite(g_ILPF_4000, 'ILPF_4000.png');
fprintf('ILPF_4000 %f\n', ratio_ILPF_4000);

%=========================================================================
% Gaussian lowpass filter 

H_GLPF_10 = exp(-D2/(2*10*10));
[g_GLPF_10, ratio_GLPF_10] = dft_filter_func(f_orig, H_GLPF_10);
figure, imshow(g_GLPF_10);
imwrite(g_GLPF_10, 'GLPF_10.png');
fprintf('GLPF_10 %f\n', ratio_GLPF_10);

H_GLPF_100 = exp(-D2/(2*100*100));
[g_GLPF_100 , ratio_GLPF_100] = dft_filter_func(f_orig, H_GLPF_100);
figure, imshow(g_GLPF_100);
imwrite(g_GLPF_100, 'GLPF_100.png');
fprintf('GLPF_100 %f\n', ratio_GLPF_100);

H_GLPF_1000 = exp(-D2/(2*1000*1000));
[g_GLPF_1000 , ratio_GLPF_1000] = dft_filter_func(f_orig, H_GLPF_1000);
figure, imshow(g_GLPF_1000);
imwrite(g_GLPF_1000, 'GLPF_1000.png');
fprintf('GLPF_1000 %f\n', ratio_GLPF_1000);

H_GLPF_4000 = exp(-D2/(2*4000*4000));
[g_GLPF_4000, ratio_GLPF_4000] = dft_filter_func(f_orig, H_GLPF_4000);
figure, imshow(g_GLPF_4000);
imwrite(g_GLPF_4000, 'GLPF_4000.png');
fprintf('GLPF_4000 %f\n', ratio_GLPF_4000);


%=========================================================================
% Butterworth lowpass filter 

H_BLPF_10 = 1 ./ (1+D2.^2 ./ (10^4));
[g_BLPF_10, ratio_BLPF_10] = dft_filter_func(f_orig, H_BLPF_10);
figure, imshow(g_BLPF_10);
imwrite(g_BLPF_10, 'BLPF_10.png');
fprintf('BLPF_10 %f\n', ratio_BLPF_10);

H_BLPF_100 = 1 ./ (1+D2.^2 ./ (100^4));
[g_BLPF_100 , ratio_BLPF_100] = dft_filter_func(f_orig, H_BLPF_100);
figure, imshow(g_BLPF_100);
imwrite(g_BLPF_100, 'BLPF_100.png');
fprintf('BLPF_100 %f\n', ratio_BLPF_100);

H_BLPF_1000 = 1 ./ (1+D2.^2 ./ (1000^4));
[g_BLPF_1000 , ratio_BLPF_1000] = dft_filter_func(f_orig, H_BLPF_1000);
figure, imshow(g_BLPF_1000);
imwrite(g_BLPF_1000, 'BLPF_1000.png');
fprintf('BLPF_1000 %f\n', ratio_BLPF_1000);

H_BLPF_4000 = 1 ./ (1+D2.^2 ./ (4000^4));
[g_BLPF_4000, ratio_BLPF_4000] = dft_filter_func(f_orig, H_BLPF_4000);
figure, imshow(g_BLPF_4000);
imwrite(g_BLPF_4000, 'BLPF_4000.png');
fprintf('BLPF_4000 %f\n', ratio_BLPF_4000);


%=========================================================================
% Ideal highpass filter 

% 1. radius = 10
H_IHPF_10 = (D2 > 10*10);
[g_IHPF_10, ratio_ILPH_10] = dft_filter_func(f_orig, H_IHPF_10);
figure, imshow(g_IHPF_10);
imwrite(g_IHPF_10, 'IHPF_10.png');
fprintf('IHPF_10 %f\n', ratio_ILPH_10);
% 2. radius = 100
H_IHPF_100 = double(D2 > 100*100);
[g_IHPF_100, ratio_IHPF_100] = dft_filter_func(f_orig, H_IHPF_100);
figure, imshow(g_IHPF_100);
imwrite(g_IHPF_100, 'IHPF_100.png');
fprintf('IHPF_100 %f\n', ratio_IHPF_100);
% 3. radius = 1000
H_IHPF_1000 = (D2 > 1000*1000);
[g_IHPF_1000, ratio_IHPF_1000] = dft_filter_func(f_orig, H_IHPF_1000);
figure, imshow(g_IHPF_1000);
imwrite(g_IHPF_1000, 'IHPF_1000.png');
fprintf('IHPF_1000 %f\n', ratio_IHPF_1000);

%=========================================================================
% Gaussian highpass filter 

H_GHPF_10 = 1 - exp(-D2/(2*10*10));
[g_GHPF_10, ratio_GHPF_10] = dft_filter_func(f_orig, H_GHPF_10);
figure, imshow(g_GHPF_10);
imwrite(g_GHPF_10, 'GHPF_10.png');
fprintf('GHPF_10 %f\n', ratio_GHPF_10);

H_GHPF_100 = 1 - exp(-D2/(2*100*100));
[g_GHPF_100 , ratio_GHPF_100] = dft_filter_func(f_orig, H_GHPF_100);
figure, imshow(g_GHPF_100);
imwrite(g_GHPF_100, 'GHPF_100.png');
fprintf('GHPF_100 %f\n', ratio_GHPF_100);

H_GHPF_1000 = 1 - exp(-D2/(2*1000*1000));
[g_GHPF_1000 , ratio_GHPF_1000] = dft_filter_func(f_orig, H_GHPF_1000);
figure, imshow(g_GHPF_1000);
imwrite(g_GHPF_1000, 'GHPF_1000.png');
fprintf('GHPF_1000 %f\n', ratio_GHPF_1000);


%=========================================================================
% Butterworth highpass filter 

H_BHPF_10 = 1 ./ (1 + (10^4) ./ (D2.^2) );
[g_BHPF_10, ratio_BHPF_10] = dft_filter_func(f_orig, H_BHPF_10);
figure, imshow(g_BHPF_10);
imwrite(g_BHPF_10, 'BHPF_10.png');
fprintf('BHPF_10 %f\n', ratio_BHPF_10);

H_BHPF_100 = 1 ./ (1 + (100^4) ./ (D2.^2) );
[g_BHPF_100 , ratio_BHPF_100] = dft_filter_func(f_orig, H_BHPF_100);
figure, imshow(g_BHPF_100);
imwrite(g_BHPF_100, 'BHPF_100.png');
fprintf('BHPF_100 %f\n', ratio_BHPF_100);

H_BHPF_1000 = 1 ./ (1 + (1000^4) ./ (D2.^2) );
[g_BHPF_1000 , ratio_BHPF_1000] = dft_filter_func(f_orig, H_BHPF_1000);
figure, imshow(g_BHPF_1000);
imwrite(g_BHPF_1000, 'BHPF_1000.png');
fprintf('BHPF_1000 %f\n', ratio_BHPF_1000);
