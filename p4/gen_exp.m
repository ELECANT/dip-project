function [ n_exp ] = gen_exp( exp_lambda, M, N )
%GEN_EXP 
%   generate exponential distribution from uniform distribution
n_exp = zeros(M, N);
for i = (1:M)
    for j = (1:N)
        x = rand();
        n_exp(i, j) = -1.0 / exp_lambda * log(1-x);
    end
end
end

