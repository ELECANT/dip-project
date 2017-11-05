function [ n_gaussian ] = gen_gaussian( mean, variance, M, N )
%GEN_GAUSSIAN 
%   generate gaussian distribution from uniform distribution
n_gaussian = zeros(M, N);
for i = (1:M)
    for j = (1:N)
        x1 = rand();
        x2 = rand();
        n_gaussian(i,j) = sqrt(-2 * log(x1))*cos(2*pi*x2);
    end
end
n_gaussian = n_gaussian * variance + mean;
end

