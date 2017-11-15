% DIP problem 3
% Filtering in frequency domian
% ideal, Gaussian, Butterworth lowpass/highpass
% author: wang.yiqing
% Dependent function: TODO

%=========================================================================
% read in image 
fp = 'characters_test_pattern.tif';
f_orig = imread(fp, 1);
[M, N] = size(f_orig);
%figure, imshow(f_orig);

%=========================================================================
% 
P=2*M;
Q=2*N;
f_pad = zeros(P, Q);
f_pad(1:M, 1:N)=double(f_orig);
for i=1:P
    for j=1:Q
        f_pad(i,j)=f_pad(i,j)*((-1)^(i+j));
    end
end
f_dft = DFT(f_pad);
figure, imshow(f_dft);
