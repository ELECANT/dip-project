function [ imgg ] = dilation( imgf, B )
%OPENING 
%   B - structuring element

[M, N] = size(imgf);
[m, n] = size(B);

downshift = fix((m-1)/2);
rightshift = fix((n-1)/2);
f = zeros(M+2*m, N+2*n);
f(m+1:m+M, n+1:n+N) = imgf;
g = zeros(M, N);
xx = zeros(m, n);
allzeros = zeros(m, n);
for i = (1:M)
    for j = (1:N)
        xx = f(i-downshift+m:i+downshift+m, j-rightshift+n:j+rightshift+n);
        if isequal(xx.*B, allzeros) == 0
            g(i, j) = 1;
        end
    end
end

imgg = g;

end

