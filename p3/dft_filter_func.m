function [ imgg, energy_ratio ] = dft_filter_func( imgf, H )
%DFT_FILTER_FUNC 
%   DFT_FILTER_FUNC accept an image imgf, and a filter H
%   output the filtered image imgg and enegy_ratio

% automatically pad imgf: pad_f
imgf = double(imgf);
% fast fourier transform 
F = fft2(imgf);
% filtered by H
G = H .* F;
% inverse fft and obtain the real part
imgg = real(ifft2(G));
% cut out the original size
imgg = uint8(imgg);
% calculate energy ratio
energy_f = sum(sum( abs(F).^2 ));
energy_g = sum(sum( abs(G).^2 ));
energy_ratio = energy_g / energy_f;

end

