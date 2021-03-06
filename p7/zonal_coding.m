function [ imgg, diff ] = zonal_coding( imgf, bsize, rx, ry, mask_num )
%ZONAL_CODING
%   bsize: size of subimage; rx, ry: transform mask; mask: zonal mask

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

% generate mask
mask = zeros(bsize, bsize);
for i = (1:bsize)
    for j = (1:bsize)
        if i+j<=mask_num+1
            mask(i,j) = 1;
        end
    end
end

% zonal mask
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

