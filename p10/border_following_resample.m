function [ img_grid, highlight_grid, chain_code, first_diff, straight_border ] = border_following_resample( imgf, grid_size )
%BORDER_FOLLOWING_RESAMPLE 
%   img_grid: grid points, chain_code, first_diff, straight_border

[M, N] = size(imgf);
M = round(M/grid_size)+1;
N = round(N/grid_size)+1;
imgff = zeros(M*grid_size, N*grid_size);
[m, n] = size(imgf);
imgff(1:m, 1:n) = imgf;

f = zeros(M, N);
for x = (1:M)
    for y = (1:N)
        if calc_overlap(imgff, x, y, grid_size)>0.3*grid_size^2
            f(x,y) = 255;
        end
    end
end

[g, chain_code] = border_following(f);

img_grid = zeros(M*grid_size, N*grid_size);
highlight_grid = zeros(M*grid_size, N*grid_size);
foundOne = 0;
for x = (1:M)
    for y = (1:N)
        if g(x, y) == 255
            tmpx = (x-1)*grid_size+1;
            tmpy = (y-1)*grid_size+1;
            img_grid(tmpx, tmpy) = 255;
            highlight_grid(tmpx-1:tmpx+1, tmpy-1:tmpy+1) = 255;
            if foundOne == 0
                foundOne = 1;
                b0 = [tmpx, tmpy];
            end
        end
    end
end

first_diff = cal_first_diff(chain_code, 8);
straight_border = img_grid;
[~, len_chain] = size(chain_code);

dir = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];

x = b0(1);
y = b0(2);
for i = (1:len_chain)
    for j = (1:grid_size)
        x = x+ dir(chain_code(i)+1,1);
        y = y+ dir(chain_code(i)+1,2);
        straight_border(x,y) = 255;
    end
end

img_grid = img_grid(1:m, 1:n);
highlight_grid = highlight_grid(1:m, 1:n);
straight_border = straight_border(1:m, 1:n);

end

% =======================================================================

function [ ret ] = calc_overlap( f, x, y, grid_size )
f = f((x-1)*grid_size+1:x*grid_size, (y-1)*grid_size+1:y*grid_size);
ret = 0;
for i = (1:grid_size)
    for j = (1:grid_size)
        if f(i,j) ~= 0
            ret = ret + 1;
        end
    end
end
end

% =======================================================================

function [first_diff] = cal_first_diff(chain_code, dir_num)

[~, N] = size(chain_code);
first_diff = zeros(1, N);
for i = (2:N)
    first_diff(i) = chain_code(i) - chain_code(i-1);
    if first_diff(i)<0
        first_diff(i) = first_diff(i)+dir_num;
    end
end
first_diff(1) = chain_code(1) - chain_code(N);
if first_diff(1)<0
    first_diff(1) = first_diff(1)+dir_num;
end

end

