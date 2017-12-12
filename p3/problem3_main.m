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

H_ILPF_2 = double(D2 <= 2*2);
[g_ILPF_2, ratio_ILPH_2] = dft_filter_func(f_orig, H_ILPF_2);
figure, imshow(g_ILPF_2);
imwrite(g_ILPF_2, 'ILPF_2.png');
fprintf('ILPF_2 %f\n', ratio_ILPH_2);

H_ILPF_5 = double(D2 <= 5*5);
[g_ILPF_5, ratio_ILPH_5] = dft_filter_func(f_orig, H_ILPF_5);
figure, imshow(g_ILPF_5);
imwrite(g_ILPF_5, 'ILPF_5.png');
fprintf('ILPF_5 %f\n', ratio_ILPH_5);

H_ILPF_10 = double(D2 <= 10*10);
[g_ILPF_10, ratio_ILPF_10] = dft_filter_func(f_orig, H_ILPF_10);
figure, imshow(g_ILPF_10);
imwrite(g_ILPF_10, 'ILPF_10.png');
fprintf('ILPF_10 %f\n', ratio_ILPF_10);

H_ILPF_30 = double(D2 <= 30*30);
[g_ILPF_30, ratio_ILPF_30] = dft_filter_func(f_orig, H_ILPF_30);
figure, imshow(g_ILPF_30);
imwrite(g_ILPF_30, 'ILPF_30.png');
fprintf('ILPF_30 %f\n', ratio_ILPF_30);

H_ILPF_100 = double(D2 <= 100*100);
[g_ILPF_100, ratio_ILPF_100] = dft_filter_func(f_orig, H_ILPF_100);
figure, imshow(g_ILPF_100);
imwrite(g_ILPF_100, 'ILPF_100.png');
fprintf('ILPF_100 %f\n', ratio_ILPF_100);

H_ILPF_400 = double(D2 <= 400*400);
[g_ILPF_400, ratio_ILPH_400] = dft_filter_func(f_orig, H_ILPF_400);
figure, imshow(g_ILPF_400);
imwrite(g_ILPF_400, 'ILPF_400.png');
fprintf('ILPF_400 %f\n', ratio_ILPH_400);

%=========================================================================
% Butterworth lowpass filter

H_BLPF_2 = 1 ./ (1+D2.^2 ./ (2^4));
[g_BLPF_2, ratio_BLPF_2] = dft_filter_func(f_orig, H_BLPF_2);
figure, imshow(g_BLPF_2);
imwrite(g_BLPF_2, 'BLPF_2.png');
fprintf('BLPF_2 %f\n', ratio_BLPF_2);

H_BLPF_5 = 1 ./ (1+D2.^2 ./ (5^4));
[g_BLPF_5, ratio_BLPF_5] = dft_filter_func(f_orig, H_BLPF_5);
figure, imshow(g_BLPF_5);
imwrite(g_BLPF_5, 'BLPF_5.png');
fprintf('BLPF_5 %f\n', ratio_BLPF_5);

H_BLPF_10 = 1 ./ (1+D2.^2 ./ (10^4));
[g_BLPF_10, ratio_BLPF_10] = dft_filter_func(f_orig, H_BLPF_10);
figure, imshow(g_BLPF_10);
imwrite(g_BLPF_10, 'BLPF_10.png');
fprintf('BLPF_10 %f\n', ratio_BLPF_10);

H_BLPF_30 = 1 ./ (1+D2.^2 ./ (30^4));
[g_BLPF_30, ratio_BLPF_30] = dft_filter_func(f_orig, H_BLPF_30);
figure, imshow(g_BLPF_30);
imwrite(g_BLPF_30, 'BLPF_30.png');
fprintf('BLPF_30 %f\n', ratio_BLPF_30);

H_BLPF_100 = 1 ./ (1+D2.^2 ./ (100^4));
[g_BLPF_100 , ratio_BLPF_100] = dft_filter_func(f_orig, H_BLPF_100);
figure, imshow(g_BLPF_100);
imwrite(g_BLPF_100, 'BLPF_100.png');
fprintf('BLPF_100 %f\n', ratio_BLPF_100);

H_BLPF_400 = 1 ./ (1+D2.^2 ./ (400^4));
[g_BLPF_400, ratio_BLPF_400] = dft_filter_func(f_orig, H_BLPF_400);
figure, imshow(g_BLPF_400);
imwrite(g_BLPF_400, 'BLPF_400.png');
fprintf('BLPF_400 %f\n', ratio_BLPF_400);

%=========================================================================
% Gaussian lowpass filter 

H_GLPF_2 = exp(-D2/(2*2*2));
[g_GLPF_2, ratio_GLPF_2] = dft_filter_func(f_orig, H_GLPF_2);
figure, imshow(g_GLPF_2);
imwrite(g_GLPF_2, 'GLPF_2.png');
fprintf('GLPF_2 %f\n', ratio_GLPF_2);

H_GLPF_5 = exp(-D2/(2*5*5));
[g_GLPF_5, ratio_GLPF_5] = dft_filter_func(f_orig, H_GLPF_5);
figure, imshow(g_GLPF_5);
imwrite(g_GLPF_5, 'GLPF_5.png');
fprintf('GLPF_5 %f\n', ratio_GLPF_5);

H_GLPF_10 = exp(-D2/(2*10*10));
[g_GLPF_10, ratio_GLPF_10] = dft_filter_func(f_orig, H_GLPF_10);
figure, imshow(g_GLPF_10);
imwrite(g_GLPF_10, 'GLPF_10.png');
fprintf('GLPF_10 %f\n', ratio_GLPF_10);

H_GLPF_30 = exp(-D2/(2*30*30));
[g_GLPF_30, ratio_GLPF_30] = dft_filter_func(f_orig, H_GLPF_30);
figure, imshow(g_GLPF_30);
imwrite(g_GLPF_30, 'GLPF_30.png');
fprintf('GLPF_30 %f\n', ratio_GLPF_30);

H_GLPF_100 = exp(-D2/(2*100*100));
[g_GLPF_100 , ratio_GLPF_100] = dft_filter_func(f_orig, H_GLPF_100);
figure, imshow(g_GLPF_100);
imwrite(g_GLPF_100, 'GLPF_100.png');
fprintf('GLPF_100 %f\n', ratio_GLPF_100);

H_GLPF_400 = exp(-D2/(2*400*400));
[g_GLPF_400, ratio_GLPF_400] = dft_filter_func(f_orig, H_GLPF_400);
figure, imshow(g_GLPF_400);
imwrite(g_GLPF_400, 'GLPF_400.png');
fprintf('GLPF_400 %f\n', ratio_GLPF_400);

%=========================================================================
% Ideal highpass filter 

H_IHPF_10 = (D2 > 10*10);
[g_IHPF_10, ratio_ILPH_10] = dft_filter_func(f_orig, H_IHPF_10);
figure, imshow(g_IHPF_10);
imwrite(g_IHPF_10, 'IHPF_10.png');
fprintf('IHPF_10 %f\n', ratio_ILPH_10);

H_IHPF_30 = (D2 > 30*30);
[g_IHPF_30, ratio_IHPF_30] = dft_filter_func(f_orig, H_IHPF_30);
figure, imshow(g_IHPF_30);
imwrite(g_IHPF_30, 'IHPF_30.png');
fprintf('IHPF_30 %f\n', ratio_IHPF_30);

H_IHPF_100 = double(D2 > 100*100);
[g_IHPF_100, ratio_IHPF_100] = dft_filter_func(f_orig, H_IHPF_100);
figure, imshow(g_IHPF_100);
imwrite(g_IHPF_100, 'IHPF_100.png');
fprintf('IHPF_100 %f\n', ratio_IHPF_100);

%=========================================================================
% Butterworth highpass filter 

H_BHPF_10 = 1 ./ (1 + (10^4) ./ (D2.^2) );
[g_BHPF_10, ratio_BHPF_10] = dft_filter_func(f_orig, H_BHPF_10);
figure, imshow(g_BHPF_10);
imwrite(g_BHPF_10, 'BHPF_10.png');
fprintf('BHPF_10 %f\n', ratio_BHPF_10);

H_BHPF_30 = 1 ./ (1 + (30^4) ./ (D2.^2) );
[g_BHPF_30 , ratio_BHPF_30] = dft_filter_func(f_orig, H_BHPF_30);
figure, imshow(g_BHPF_30);
imwrite(g_BHPF_30, 'BHPF_30.png');
fprintf('BHPF_30 %f\n', ratio_BHPF_30);

H_BHPF_100 = 1 ./ (1 + (100^4) ./ (D2.^2) );
[g_BHPF_100 , ratio_BHPF_100] = dft_filter_func(f_orig, H_BHPF_100);
figure, imshow(g_BHPF_100);
imwrite(g_BHPF_100, 'BHPF_100.png');
fprintf('BHPF_100 %f\n', ratio_BHPF_100);

%=========================================================================
% Gaussian highpass filter 

H_GHPF_10 = 1 - exp(-D2/(2*10*10));
[g_GHPF_10, ratio_GHPF_10] = dft_filter_func(f_orig, H_GHPF_10);
figure, imshow(g_GHPF_10);
imwrite(g_GHPF_10, 'GHPF_10.png');
fprintf('GHPF_10 %f\n', ratio_GHPF_10);

H_GHPF_30 = 1 - exp(-D2/(2*30*30));
[g_GHPF_30 , ratio_GHPF_30] = dft_filter_func(f_orig, H_GHPF_30);
figure, imshow(g_GHPF_30);
imwrite(g_GHPF_30, 'GHPF_30.png');
fprintf('GHPF_30 %f\n', ratio_GHPF_30);

H_GHPF_100 = 1 - exp(-D2/(2*100*100));
[g_GHPF_100 , ratio_GHPF_100] = dft_filter_func(f_orig, H_GHPF_100);
figure, imshow(g_GHPF_100);
imwrite(g_GHPF_100, 'GHPF_100.png');
fprintf('GHPF_100 %f\n', ratio_GHPF_100);

