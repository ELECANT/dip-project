function [ dct_mask ] = dct_mask( n )
%DCT_MASK 
%   m, n: the size of dct mask

dct_mask = zeros(n);
for u = (1:n)
    for x = (1:n)
        if u==1
            alphau = sqrt(1/n);
        else
            alphau = sqrt(2/n);
        end
        dct_mask(u,x) = alphau * cos(pi*(2*x-1)*(u-1)/2/n);
    end
end

end

