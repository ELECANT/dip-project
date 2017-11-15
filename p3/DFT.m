function [ imgg ] = DFT( imgf )
%DFT 
%   
f = double(imgf);
[M, N] = size(f);
for u = 1:M
    for v = 1:N
        sum = 0;
        for x = 1:M
            for y = 1:N
                sum = sum + f(x,y)*exp(-1i*2*3.1416*((u*x/M)+(v*y/N)));
            end
        end
        imgg(u,v) = sum;
    end
end

end

