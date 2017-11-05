function [ imgg ] = alpha_trimmed( imgf, p, d )
%ALPHA_TRIMMED 
%   
[M, N] = size(imgf);
f = replicate_padding(imgf, p-1);
f = double(f);
g = zeros(M+p-1, N+p-1);
for i = ((p+1)/2:M+p-1+(p-1)/2)
    for j = ((p+1)/2:N+p-1+(p-1)/2)
        t = f(i-(p-1)/2:i+(p-1)/2, j-(p-1)/2:j+(p-1)/2);
        tt = sort(t(:));
        if i==100 && j==100
            tt
            tt(fix(d/2)+1 : p*p-(d-fix(d/2)))
        end
        g(i, j) = sum(tt( fix(d/2)+1 : p*p-(d-fix(d/2)) )) / (p*p - d);
    end
end
imgg = uint8(g(p:M+p-1, p:N+p-1));

end

