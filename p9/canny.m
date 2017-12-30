function [ imgg, imgt ] = canny( imgf, sigma, n, TL, TH )
%CANNY canny's algorithm
%   sigma - gaussian variance, n - size of filter, TH TL - thresholds

% generate gaussian filter
x = (1:n) - (n+1)/2;
y = x';
x = repmat(x, n, 1);
y = repmat(y, 1, n);
D2 = x.^2 + y.^2;
gau_filter = exp(-D2 / (2*sigma*sigma));

% preprocess
[M, N] = size(imgf);
imgf = double(imgf) ./ 255;
f = replicate_padding(imgf, n-1);
f = double(f); % double f

% gaussian smoothing
g = zeros(M+2*n, N+2*n);
for x = (n : M+n-1)
    for y = (n : N+n-1)
        xlow = fix(x - fix((n-1)/2));
        xhigh = fix(x + fix((n-1)/2));
        ylow = fix(y - fix((n-1)/2));
        yhigh = fix(y + fix((n-1)/2));
        g(x,y) = sum(sum(f(xlow:xhigh,ylow:yhigh) .* gau_filter));
    end
end

% restore to original size
f = g(n:M+n-1, n:N+n-1);
minf = min(min(f));
maxf = max(max(f));
f = (f - minf)./(maxf-minf); % normalization to (0,1)

% calculate magnitude and angle image
magnitude = zeros(M, N);
angle = zeros(M, N);
for x = (1:M-1)
    for y = (1:N-1)
        py = f(x,y) - f(x,y+1) + f(x+1,y) - f(x+1,y+1);
        px = f(x,y) - f(x+1,y) + f(x,y+1) - f(x+1,y+1);
        magnitude(x, y) = sqrt(px*px + py*py);
        angle(x, y) = atand(py/px);
    end
end

% obtain thresholding-only image
imgt = zeros(M, N);
for x = (1:M)
    for y = (1:N)
        if magnitude(x,y)>=TL 
            imgt(x,y) = magnitude(x,y);
        end
    end
end
imgt = uint8(scale255(imgt));


% nonmaximum suppression
suppres = zeros(M, N);

for x = (2:M-1)
    for y = (2:N-1)
        if angle(x,y)>=-22.5 && angle(x,y)<22.5 % horizontal
            if magnitude(x,y)>magnitude(x-1,y) && magnitude(x,y)>magnitude(x+1,y)
                suppres(x, y) = magnitude(x,y);
            end
        elseif angle(x,y)>=22.5 && angle(x,y)<67.5 % leftbottom-righttop
            if magnitude(x,y)>magnitude(x-1,y-1) && magnitude(x,y)>magnitude(x+1,y+1)
                suppres(x, y) = magnitude(x,y);
            end
        elseif angle(x,y)>=-67.5 && angle(x,y)<-22.5 % lefttop-rightbottom
            if magnitude(x,y)>magnitude(x-1,y+1) && magnitude(x,y)>magnitude(x+1,y-1)
                suppres(x, y) = magnitude(x,y);
            end
        else % vertical
            if magnitude(x,y)>magnitude(x,y+1) && magnitude(x,y)>magnitude(x,y-1)
                suppres(x, y) = magnitude(x,y);
            end
        end
    end
end


% double thresholding
imgg = zeros(M, N);

for x = (1:M)
    for y = (1:N)
        if suppres(x,y)>TH % strong edge pixel
            imgg(x,y) = 1;
        elseif suppres(x,y)>TL 
            if max(max(suppres(x-1:x+1,y-1:y+1)))>TH % 8-connectivity
                imgg(x,y) = 1;
            end
        end            
    end
end


end

