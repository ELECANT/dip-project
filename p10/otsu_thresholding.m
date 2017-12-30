function [ imgg, kstar, eta ] = otsu_thresholding( imgf )
%OTSU_THRESHOLDING 
%   kstar: threshold, eta: separability

[M, N] = size(imgf);
histf = zeros(1, uint32(256)); % (0:255)
for x=(1:M)
    for y=(1:N)
        histf(fix(imgf(x,y)+1)) = histf(fix(imgf(x,y)+1)) + 1;
    end
end
histf = double(histf)/double(M*N);

P = zeros(1, uint32(256));
P(1) = histf(1);
for i = (2:256)
    P(i) = P(i-1) + histf(i);
end

m = double(zeros(1, uint32(256)));
m(1) = 0*double(histf(1));
for i = (2:256)
    m(i) = m(i-1) + double(i-1)*histf(i);
end
mG = m(256);

size(P)
size(m)
size(mG)
size(1-P)

sigmaB2 = (mG .* P - m) .^2 ./(P .* (1-P));
size(sigmaB2)
kall = find(sigmaB2==max(sigmaB2));
kstar = mean(kall) - 1;
sigmaG = sum(((0:255)-mG).^2 .* histf);

eta = sigmaB2(int32(kstar)) / sigmaG;
imgg = thresholding(imgf, kstar);

end

function [ imgg ] = thresholding( imgf, T )    
[M, N] = size(imgf);
imgg = zeros(M, N);
for x = (1:M)
    for y = (1:N)
        if imgf(x,y)>T
            imgg(x,y)=255;
        else
            imgg(x,y)=0;
        end
    end
end

imgg = uint8(imgg);
end