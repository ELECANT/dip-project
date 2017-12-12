function [ imgg ] = dft_filter_func( imgf, H )
%DFT_FILTER_FUNC 
%   DFT_FILTER_FUNC accept an image imgf, and a filter H
%   output the filtered image imgg 

imgf = double(imgf);
% fast fourier transform 
F = fft2(imgf);
% filtered by H
G = H .* F;
imgg = real(ifft2(G));
% cut out the original size
imgg = uint8(scale255(imgg));

end

