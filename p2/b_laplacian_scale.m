function [ scale_imgg, imgg] = b_laplacian_scale( imgf )
%B_LAPLACIAN_SCALE 

[M, N] = size(imgf);

% padding
f = replicate_padding(imgf, 2);
f = double(f);

% laplacian
mask = [-1 -1 -1; -1 8 -1; -1 -1 -1];
g = zeros(M+4, N+4);
for x = (2 : M+3)
    for y = (2 : N+3)
        g(x, y) = sum(sum(f(x-1:x+1, y-1:y+1) .* mask));
    end
end

imgg = g(3:M+2, 3:N+2); % laplacian result without scale

% scale
scale_imgg = scale255(imgg);

end

