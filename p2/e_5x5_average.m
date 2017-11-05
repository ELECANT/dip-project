function [ imgg ] = e_5x5_average( imgf )
%E_5X5_AVERAGE

[M, N] = size(imgf);

% padding
f = replicate_padding(imgf, 4);
f = double(f);

% 5x5 average
g = zeros(M+8, N+8);
for x = (3 : M+6)
    for y = (3 : N+6)
        g(x, y) = sum(sum(f(x-2:x+2, y-2:y+2))) / 25;
    end
end

imgg = g(5:M+4, 5:N+4); % laplacian result without scale
imgg = uint8(imgg);

end

