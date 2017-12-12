function [ U, V ] = gen_filter( P, Q )
%GEN_FILTER generate filter

u = (0:P-1);
v = (0:Q-1);
idx = find(u > P/2);
u(idx) = u(idx) - P;
idy = find(v > Q/2);
v(idy) = v(idy) - Q;

[V, U] = meshgrid(v, u);
end

