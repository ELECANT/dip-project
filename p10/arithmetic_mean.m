function [ imgg ] = arithmetic_mean( imgf, p )
%ARITHMIC_MEAN 
%   
[M, N] = size(imgf);
f = replicate_padding(imgf, p-1);
f = double(f);
g = zeros(M+p-1, N+p-1);
for i = ((p+1)/2:M+p-1+(p-1)/2)
    for j = ((p+1)/2:N+p-1+(p-1)/2)
        g(i, j) = sum(sum(f(i-(p-1)/2:i+(p-1)/2, j-(p-1)/2:j+(p-1)/2))) / p / p;
    end
end
imgg = uint8(g(p:M+p-1, p:N+p-1));
end

