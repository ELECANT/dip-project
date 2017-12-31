% DIP problem 4 part 2
% Restoration in the presence of noisy only
% author: wang.yiqing
% Dependent function: all dependency listed in part1,
% min_spatial, max_spatial, geometric_mean, arithmetic_meam, 
% contra_harmonic, median_spatial, alpha_trimmed, replicate_padding 

% ========================================================================

fp_circuit = 'Fig0507.tif';
f_origin = imread(fp_circuit);
figure, imshow(f_origin);
[M, N] = size(f_origin);
figure, imhist(f_origin);

% graph 5.7 - add gaussian, 3x3 arithmic mean, 3x3 geometric mean
gaussian_mean = 80;
gaussian_variance = 25;
n_gaussian = gen_gaussian(gaussian_mean, gaussian_variance, M, N);
f_gaussian = scale255(double(f_origin) + n_gaussian);
figure, imshow(f_gaussian);
f_gau_arimean = arithmetic_mean(f_gaussian, 3);
f_gau_geomean = geometric_mean(f_gaussian, 3);
figure, imshow(f_gau_arimean);
figure, imshow(f_gau_geomean);
imwrite(f_gaussian, '42-gaussian.png');
imwrite(f_gau_arimean, '42-gau-arimean.png');
imwrite(f_gau_geomean, '42-gau-geomean.png');

% graph 5.8 - pepper noise and salt noise, contraharmonic Q=1.5 and Q=-1.5
pepper = -255;
salt = 255;
p_pepper = 0.1;
p_salt = 0.1;
n_pepper = gen_saltpepper(0, pepper, 0, p_pepper, M, N);
n_salt = gen_saltpepper(salt, 0, p_salt, 0, M, N);
f_pepper = uint8(double(f_origin) + n_pepper);
f_salt = uint8(double(f_origin) + n_salt);
figure, imshow(f_pepper);
figure, imshow(f_salt);
f_pepper_contraharmo = contra_harmonic(f_pepper, 3, 1.5);
f_salt_contraharmo = contra_harmonic(f_salt, 3, -1.5);
figure, imshow(f_pepper_contraharmo);
figure, imshow(f_salt_contraharmo);
imwrite(f_pepper, '42-pepper.png');
imwrite(f_salt, '42-salt.png');
imwrite(f_salt_contraharmo, '42-salt-contraharmo.png');
imwrite(f_pepper_contraharmo, '42-pepper-contraharmo.png');

% graph 5.9 - pepper noise and salt noise contraharmonic Q=-1.5 and Q=1.5
f_pepper_contraharmo_bad = contra_harmonic(f_pepper, 3, -1.5);
f_salt_contraharmo_bad = contra_harmonic(f_salt, 3, 1.5);
figure, imshow(f_pepper_contraharmo_bad);
figure, imshow(f_salt_contraharmo_bad);
imwrite(f_salt_contraharmo_bad, '42-salt-contraharmo_bad.png');
imwrite(f_pepper_contraharmo_bad, '42-pepper-contraharmo_bad.png');

% graph 5.10 - pepper&salt noise, median 3 times
pepper = -255;
salt = 255;
p_pepper = 0.1;
p_salt = 0.1;
n_peppersalt = gen_saltpepper(salt, pepper, p_salt, p_pepper, M, N);
f_peppersalt = uint8(double(f_origin) + n_peppersalt);
figure, imshow(f_peppersalt);
f_pepsalt_median_1 = median_spatial(f_peppersalt, 3);
f_pepsalt_median_2 = median_spatial(f_pepsalt_median_1, 3);
f_pepsalt_median_3 = median_spatial(f_pepsalt_median_2, 3);
figure, imshow(f_pepsalt_median_1);
figure, imshow(f_pepsalt_median_2);
figure, imshow(f_pepsalt_median_3);
imwrite(f_peppersalt, '42-peppersalt.png');
imwrite(f_pepsalt_median_1, '42-pepsalt-median-1.png');
imwrite(f_pepsalt_median_2, '42-pepsalt-median-2.png');
imwrite(f_pepsalt_median_3, '42-pepsalt-median-3.png');

% graph 5.11 - pepper noise max filtering, salt noise min filtering
f_pepper_max = max_spatial(f_pepper, 3);
f_salt_min = min_spatial(f_salt, 3);
figure, imshow(f_pepper_max);
figure, imshow(f_salt_min);
imwrite(f_pepper_max, '42-pepper-max.png');
imwrite(f_salt_min, '42-salt-min.png');

% graph 5.12 - uniform noise, then add pepper0.1salt0.1
% 5x5 arithmetic mean, 5x5 geometric mean, 5x5 median, 5x5 alpha-trimmed mean
pepper = -255;
salt = 255;
p_pepper = 0.1;
p_salt = 0.1;
n_uniform = unifrnd(0, 70, M, N);
f_uniform = scale255(double(f_origin) + n_uniform);
n_peppersalt = gen_saltpepper(salt, pepper, p_salt, p_pepper, M, N);
f_unipepsalt = uint8(double(f_uniform) + n_peppersalt);
f_unipepsalt_arimean = arithmetic_mean(f_unipepsalt, 5);
f_unipepsalt_geomean = geometric_mean(f_unipepsalt, 5);
f_unipepsalt_median = median_spatial(f_unipepsalt, 5);
f_unipepsalt_alpha = alpha_trimmed(f_unipepsalt, 5, 5);
figure, imshow(f_uniform);
figure, imshow(f_unipepsalt);
figure, imshow(f_unipepsalt_arimean);
figure, imshow(f_unipepsalt_geomean);
figure, imshow(f_unipepsalt_median);
figure, imshow(f_unipepsalt_alpha);
imwrite(f_uniform, '42-uniform.png');
imwrite(f_unipepsalt, '42-unipepsalt.png');
imwrite(f_unipepsalt_arimean, '42-unipepsalt-arimean.png');
imwrite(f_unipepsalt_geomean, '42-unipepsalt-geomean.png');
imwrite(f_unipepsalt_median, '42-unipepsalt-median.png');
imwrite(f_unipepsalt_alpha, '42-unipepsalt-alpha.png');
