function [ imgg ] = n_geodesic_dilation( imgf, G, B, n_size )
%N_GEODESIC 
%   B - structuring element, n_size - size of geodesic dilation

if n_size == 0
    imgg = imgf;
    return;
else
    imgg = dilation( n_geodesic_dilation( imgf, G, B, n_size-1), B ) & G; 
       
end

