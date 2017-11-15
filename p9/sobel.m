function [ imgg ] = sobel( imgf )
%SOBEL 

[M, N] = size(imgf);

f = replicate_padding(imgf, 2);
f = double(f); % double f

% Sobel
maskx = [-1 -2 -1; 0 0 0; 1 2 1];
masky = [-1 0 1; -2 0 2; -1 0 1];
gx = zeros(M+4, N+4);
gy = zeros(M+4, N+4);
for x = (2 : M+3)
    for y = (2 : N+3)
        gx(x-1:x+1, y-1:y+1) = sum(sum(f(x-1:x+1, y-1:y+1) .* maskx));
        gy(x-1:x+1, y-1:y+1) = sum(sum(f(x-1:x+1, y-1:y+1) .* masky));
    end
end

% new image: using abs
gx = abs(gx(3:M+2, 3:N+2));
gy = abs(gy(3:M+2, 3:N+2));
imgg = scale255(gx+gy);

end
