function [ imgg ] = scale255( imgf )
%SCALE255 
% return is uint8 type

%imgf = double(imgf);
[M, N] = size(imgf);
K = 255;

minf = zeros(M, N) + min(min(imgf));
maxf = zeros(M, N) + max(max(imgf));
imgg = K * (imgf-minf) ./ (maxf - minf);
imgg = uint8(imgg);

end

