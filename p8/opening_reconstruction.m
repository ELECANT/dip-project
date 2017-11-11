function [ imgg, k_times ] = opening_reconstruction( imgf, B, n_size )
%OPENING_RECONSTRUCTION 
%   n_size - the size of opening reconstruction

f_erosion = imgf;
for i=(1:n_size)
    f_erosion = erosion(f_erosion, B);
end
[imgg, k_times] = dilation_reconstruction(f_erosion, imgf, ones(3,3));

end

