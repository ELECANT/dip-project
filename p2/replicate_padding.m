function [ imgg ] = replicate_padding( imgf, pad )
%REPLIACTE_PADDING
% imgf - img to be padded, pad - amount of padding 

[M, N] = size(imgf);

% repmat(mat, row_rep, col_rep);
top = repmat(imgf(1, :), pad, 1);
button = repmat(imgf(M, :), pad, 1);
left = repmat(imgf(:, 1), 1, pad);
right = repmat(imgf(:, N), 1, pad);
lt = repmat(imgf(1,1), pad, pad);
rt = repmat(imgf(1,N), pad, pad);
lb = repmat(imgf(M,1), pad, pad);
rb = repmat(imgf(M,N), pad, pad);

imgg = [lt, top, rt; left, imgf, right; lb, button, rb];

end

