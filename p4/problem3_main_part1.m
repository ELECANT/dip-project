% problem 3 
% generate noise
oo = 0;
fp = input('Input the image path: ', 's');
f_origin = imread(fp, 1);
%imshow(f_orign);
%figure, imhist(f_origin);
[M, N] = size(f_origin);

% uniform noise
n_uniform = unifrnd(0, 70, M, N);
f_uniform = scale255(double(f_origin) + n_uniform);
oo = oo+1;
fprintf('Uniform noise %d\n', oo);
%figure, imshow(f_uniform);
%figure, imhist(f_uniform);

% gaussian noise
gaussian_mean = 80;
gaussian_variance = 25;
n_gaussian = gen_gaussian(gaussian_mean, gaussian_variance, M, N);
f_gaussian = scale255(double(f_origin) + n_gaussian);
oo = oo + 1;
fprintf('Gaussian noise %d\n', oo);
%figure, imshow(f_gaussian);
%figure, imhist(f_gaussian);

% rayleigh noise
rayleigh_lowbound = 90;
rayleigh_variance = 30;
n_rayleigh = gen_rayleigh(rayleigh_lowbound, rayleigh_variance, M, N);
f_rayleigh = scale255(double(f_origin) + n_rayleigh);
oo = oo + 1;
fprintf('Rayleigh noise %d\n', oo);
%figure, imshow(f_rayleigh);
%figure, imhist(f_rayleigh);

% gamma noise
gamma_a = 0.07
gamma_b = 2;
%n_gamma = gamrnd(gamma_a, gamma_b, M, N);
n_gamma = gen_gamma(gamma_a, gamma_b, M, N);
f_gamma = scale255(double(f_origin) + n_gamma);
oo = oo + 1;
fprintf('Gamma noise %d\n', oo);
%figure, imshow(f_gamma);
%figure, imhist(f_gamma);

% exponential noise
exp_lambda = 0.07;
n_exp = gen_exp(exp_lambda, M, N);
f_exp = scale255(double(f_origin) + n_exp);
oo = oo + 1;
fprintf('Exponential noise %d\n', oo);
%figure, imshow(f_exp);
%figure, imhist(f_exp);

% salt and pepper noise
salt = 250;
p_salt = 0.05;
pepper = -250;
p_pepper = 0.05;
n_saltpepper = gen_saltpepper(salt, pepper, p_salt, p_pepper, M, N);
f_saltpepper = uint8(double(f_origin) + n_saltpepper);
oo = oo + 1;
fprintf('Salt and pepper noise %d\n', oo);
%figure, imshow(f_saltpepper);
%figure, imhist(f_saltpepper);


