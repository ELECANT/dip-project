function [ n_gamma ] = gen_gamma( gamma_a, gamma_b, M, N )
%GEN_GAMMA
%   generate gamma distribution from uniform distribution
n_gamma = zeros(M, N);
for i = (1:M)
    for j = (1:N)
        x = rand(1, gamma_b);
        x = log(1-x);
        n_gamma(i,j) = -1/gamma_a * sum(x);
    end
end
end

