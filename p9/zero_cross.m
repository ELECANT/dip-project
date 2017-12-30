function [ imgg ] = zero_cross( imgf, threshold )
%ZERO_CROSS 
%   threshold - a threshold value

[M, N] = size(imgf);
imgg = zeros(M, N);

for x=(2:M-1)
    for y=(2:N-1)
        imgg(x,y) = check_threshold(imgf, x, y, threshold);
    end
end

end

function [ ret ] = check_threshold(imgf, x, y, threshold)
ret = 0;
if (imgf(x-1, y)*imgf(x+1, y)<0) || (imgf(x, y-1)*imgf(x, y+1)<0) ...
   || (imgf(x-1, y-1)*imgf(x+1, y+1)<0) || (imgf(x+1, y-1)*imgf(x-1, y+1)<0)
    ret = 255;
end
if threshold==0 
    return
else
    if ret ~= 0
        if (abs(imgf(x-1, y)-imgf(x+1, y))>threshold) || ...
           (abs(imgf(x, y+1)-imgf(x, y-1))>threshold) || ...
           (abs(imgf(x-1, y-1)-imgf(x+1, y+1))>threshold) || ...
           (abs(imgf(x-1, y+1)-imgf(x+1, y-1))>threshold)
            ret = 255;
        else
            ret = 0;
        end
    end
end
end

