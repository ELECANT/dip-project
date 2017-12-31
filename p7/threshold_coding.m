function [ imgg, diff ] = threshold_coding( imgf, bsize, rx, ry )
%THRESHOLD_CODING 
%   bsize: size of subimage; rx, ry: transform mask;

[M, N] = size(imgf);
bm = fix(M/bsize);
bn = fix(N/bsize);
imgf = double(imgf);

% transform T
T = zeros(M, N);
for i = (1:bm)
    for j = (1:bn)
        xrange = (bsize*(i-1)+1 : bsize*i);
        yrange = (bsize*(j-1)+1 : bsize*j);
        T(xrange, yrange) = rx * imgf(xrange,yrange) * ry;
    end
end

% generate threshold 
mask = zeros(bsize, bsize);
med = median(rx(:));
for i = (1:bsize)
    for j = (1:bsize)
        if rx(i,j)>=med
            mask(i,j) = 1;
        end
    end
end

% threshold mask
T_mask = zeros(M, N);
for i = (1:bm)
    for j = (1:bn)
        xrange = (bsize*(i-1)+1 : bsize*i);
        yrange = (bsize*(j-1)+1 : bsize*j);
        T_mask(xrange, yrange) = T(xrange,yrange) .* mask;
    end
end

% inverse transform
imgg = zeros(M, N);
for i = (1:bm)
    for j = (1:bn)
        xrange = (bsize*(i-1)+1 : bsize*i);
        yrange = (bsize*(j-1)+1 : bsize*j);
        imgg(xrange, yrange) = ry * T_mask(xrange,yrange) * rx;
    end
end

% calculcate difference
diff = abs(imgg - imgf);
diff = uint8(4*diff);

imgg = uint8(scale255(imgg));

end

