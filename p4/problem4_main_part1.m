% DIP problem 4 part 1
% Generating different types of noisy
% author: wang.yiqing
% Dependent function: scale255, unifrnd, gen_gaussian, gen_rayleigh,
% gen_exp, gen_gamma, gen_saltpepper

% ========================================================================

% generate noise
fp = 'Fig0503.tif';
f_origin = imread(fp, 1);
imshow(f_origin);
figure, imhist(f_origin);
[M, N] = size(f_origin);

% uniform noise
n_uniform = unifrnd(0, 70, M, N);
f_uniform = scale255(double(f_origin) + n_uniform);
figure, imshow(f_uniform);
figure, imhist(f_uniform);

% gaussian noise
gaussian_mean = 80;
gaussian_variance = 25;
n_gaussian = gen_gaussian(gaussian_mean, gaussian_variance, M, N);
f_gaussian = scale255(double(f_origin) + n_gaussian);
figure, imshow(f_gaussian);
figure, imhist(f_gaussian);

% rayleigh noise
rayleigh_lowbound = 90;
rayleigh_variance = 30;
n_rayleigh = gen_rayleigh(rayleigh_lowbound, rayleigh_variance, M, N);
f_rayleigh = scale255(double(f_origin) + n_rayleigh);
figure, imshow(f_rayleigh);
figure, imhist(f_rayleigh);

% gamma noise
gamma_a = 0.07;
gamma_b = 2;
n_gamma = gen_gamma(gamma_a, gamma_b, M, N);
f_gamma = scale255(double(f_origin) + n_gamma);
figure, imshow(f_gamma);
figure, imhist(f_gamma);

% exponential noise
exp_lambda = 0.07;
n_exp = gen_exp(exp_lambda, M, N);
f_exp = scale255(double(f_origin) + n_exp);
figure, imshow(f_exp);
figure, imhist(f_exp);

% salt and pepper noise
salt = 250;
p_salt = 0.05;
pepper = -250;
p_pepper = 0.05;
n_saltpepper = gen_saltpepper(salt, pepper, p_salt, p_pepper, M, N);
f_saltpepper = uint8(double(f_origin) + n_saltpepper);
figure, imshow(f_saltpepper);
figure, imhist(f_saltpepper);

% save image files
imwrite(f_origin, '41-orig.png');
imwrite(f_uniform, '41-uniform.png');
imwrite(f_rayleigh, '41-rayleigh.png');
imwrite(f_gamma, '41-gamma.png');
imwrite(f_saltpepper, '41-saltpepper.png');
imwrite(f_exp, '41-exp.png');
imwrite(f_exp, '41-gaussian.png');

fhist = figure;
imhist(f_origin);
saveas(fhist, '41-orig-hist.png', 'png');
fhist = figure;
imhist(f_uniform);
saveas(fhist, '41-uniform-hist.png', 'png');
fhist = figure;
imhist(f_gaussian);
saveas(fhist, '41-gaussian-hist.png', 'png');
fhist = figure;
imhist(f_exp);
saveas(fhist, '41-exp-hist.png', 'png');
fhist = figure;
imhist(f_rayleigh);
saveas(fhist, '41-rayleigh-hist.png', 'png');
fhist = figure;
imhist(f_gamma);
saveas(fhist, '41-gamma-hist.png', 'png');
fhist = figure;
imhist(f_saltpepper);
saveas(fhist, '41-saltpepper-hist.png', 'png');
