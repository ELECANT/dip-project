function [ imgg, k_times ] = dilation_reconstruction( imgf, G, B )
%dilation_reconstruction 
%   for efficiency issue, not use n_geodesic_dilation here.

[M, N] = size(imgf);
f1 = imgf;
f0 = ones(M, N);
k_times = 0;

while( ~isequal(f0, f1) )
    k_times = k_times + 1;
    f0 = f1;
    f1 = geodesic_dilation(f1, G, B);
    %if mod(k_times, 20) == 0
    %    figure, imshow(f1);
    %end
end

imgg = f1;
end


function [ imgg ] = geodesic_dilation( imgf, G, B )
imgg = dilation(imgf, B) & G;

end
