%----------------------------------------------------------------
% restoration in the presence of noise only - spatial filtering
%----------------------------------------------------------------
fp_circuit = input('Input the image path: ', 's');
f_origin = imread(fp_circuit);
%figure, imshow(f_origin);
[M, N] = size(f_origin);
%figure, imhist(f_origin);

% graph 5.7 - add gaussian, 3x3 arithmic mean, 3x3 geometric mean
gaussian_mean = 80;
gaussian_variance = 25;
n_gaussian = gen_gaussian(gaussian_mean, gaussian_variance, M, N);
f_gaussian = scale255(double(f_origin) + n_gaussian);
%figure, imshow(f_gaussian);
f_gau_arimean = arithmetic_mean(f_gaussian, 3);
f_gau_geomean = geometric_mean(f_gaussian, 3);
%figure, imshow(f_gau_arimean);
%figure, imshow(f_gau_geomean);

% graph 5.8 - pepper noise and salt noise, contraharmonic Q=1.5 and Q=-1.5
pepper = -255;
salt = 255;
p_pepper = 0.1;
p_salt = 0.1;
n_pepper = gen_saltpepper(0, pepper, 0, p_pepper, M, N);
n_salt = gen_saltpepper(salt, 0, p_salt, 0, M, N);
f_pepper = uint8(double(f_origin) + n_pepper);
f_salt = uint8(double(f_origin) + n_salt);
%figure, imshow(f_pepper);
%figure, imshow(f_salt);
%f_pepper_contraharmo = contra_harmonic(f_pepper, 3, 1.5);
%f_salt_contraharmo = contra_harmonic(f_salt, 3, -1.5);
%figure, imshow(f_pepper_contraharmo);
%figure, imshow(f_salt_contraharmo);

% graph 5.10 - pepper&salt noise, median 3 times
pepper = -255;
salt = 255;
p_pepper = 0.1;
p_salt = 0.1;
n_peppersalt = gen_saltpepper(salt, pepper, p_salt, p_pepper, M, N);
f_peppersalt = uint8(double(f_origin) + n_peppersalt);
%figure, imshow(f_peppersalt);
%f_pepsalt_median_1 = median_spatial(f_peppersalt, 3);
%f_pepsalt_median_2 = median_spatial(f_pepsalt_median_1, 3);
%f_pepsalt_median_3 = median_spatial(f_pepsalt_median_2, 3);
%figure, imshow(f_pepsalt_median_1);
%figure, imshow(f_pepsalt_median_2);
%figure, imshow(f_pepsalt_median_3);

% graph 5.11 - pepper noise max filtering, salt noise min filtering
f_pepper_max = max_spatial(f_pepper, 3);
f_salt_min = min_spatial(f_salt, 3);
%figure, imshow(f_pepper_max);
%figure, imshow(f_salt_min);

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


