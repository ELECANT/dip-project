function [ imgg ] = erosion( imgf, B )
%EROSION 
%   B - structuring element

[M, N] = size(imgf);
[m, n] = size(B);
downshift = fix((m-1)/2);
rightshift = fix((n-1)/2);
g = zeros(M, N);
x = zeros(m, n);
allones = ones(m, n);
for i = (1:M-m+1)
    for j = (1:N-n+1)
        x = imgf(i:i+m-1, j:j+n-1);
        if isequal(x.*B, allones) == 1
            g(i+downshift, j+rightshift) = 1;
        end
    end
end

imgg = g;

end

