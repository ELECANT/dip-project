function [ n_rayleigh ] = gen_rayleigh( lowbound, variance, M, N )
%GEN_RAYLEIGH 
%   generate rayleigh distribution from uniform distribution
n_rayleigh = zeros(M, N);
for i = (1:M)
    for j = (1:N)
        x = rand();
        n_rayleigh(i, j) = sqrt(-2 * variance^2 * log(1-x));
    end
end
n_rayleigh = n_rayleigh + lowbound;
end

