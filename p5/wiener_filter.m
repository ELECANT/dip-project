function [ imgf ] = wiener_filter( H, K, noise, imgo )
%WIENER_FILTER wiener filter used for blurred image with noise
%   original image - imgo, degradation function H, 
%   constant of signal-to-noise ratio - K, additive noise - noise

Sn = abs(fft2(noise)).^2;
Sf = abs(fft2(imgo)).^2;

%nfr = mean(mean(Sn ./Sf));
%nfr

%G = fft2(imgg);
G = fft2(imgo).*H + fft2(noise);
H2 = abs(H) .^ 2;
%F = (H2 ./ (H .* (H2 + Sn./Sf))) .* G;
F = (H2 ./ (H .* (H2 + K))) .* G;
imgf = real(ifft2(F));
imgf = uint8(scale255(imgf));

end