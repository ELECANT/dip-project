function [ lamb, pc_img, rec_img ] = pca( img_set, rec_num )
%PCA 
%   img_set: comp_num x MN; rec_num: use this number of components
%   lamb: eigen vector, from max to min; pc_img: principle components
%   image; rec_img: reconstruction image

[m, n] = size(img_set); % 6 x pix

% calculate mean vector
mx = mean((img_set')); 
mx = mx'; % 6x1

% calculate covariance
sum = zeros(m, m);
for i = (1:n)
    sum = sum + img_set(:,i) * img_set(:,i)' - mx * mx';
end
cov = sum ./ n;

% eigenvector, eigenvalue
[evector, evalue] = eig(cov);
%[evector, evalue] = cdf2rdf(evector, evalue); % convert complex to real
evector = fliplr(evector)'; % max to min, row vector
lamb = wrev(diag(evalue));


% calculate PC images
A = evector(1:rec_num, :); % rec_num x 6
pc_img = A*(img_set - repmat(mx, 1, n)); % rec_num x 6 , 6 x mn

% reconstruct images
rec_img = A'*pc_img + repmat(mx, 1, n); % 6 x rec_num, rec_num x mn

end

