function [ n_saltpepper ] = gen_saltpepper( salt, pepper, p_salt, p_pepper, M, N )
%GEN_SALTPEPPER 
%   
n_saltpepper  = zeros(M, N);
for i = (1:M)
    for j = (1:N)
        x = rand();
        if x < p_salt
            n_saltpepper(i, j) = salt;
        else
            if x < p_salt + p_pepper
                n_saltpepper(i, j) = pepper;
            end
        end
    end
end

end

