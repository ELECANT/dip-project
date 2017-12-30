function [ imgg, T ] = basic_global_thresholding( imgf, T0, deltaT )
%BASIC_GLOBAL_THRESHOLDING 
%   T0: init esitimatation threshold, deltaT: the stopping difference

while 1
    [~, mean_0, mean_1] = thresholding(imgf, T0);
    T1 = (mean_0+mean_1)/2;
    if abs(T1-T0) <= deltaT
        T = T1;
        break
    end
    T0 = T1;
end
[imgg, ~, ~] = thresholding(imgf, T);

end

function [ imgg, mean_0, mean_1 ] = thresholding( imgf, T )    
[M, N] = size(imgf);
imgg = zeros(M, N);
mean_0 = double(0);
mean_1 = double(0);
cnt_0 = 0;
cnt_1 = 0;
for x = (1:M)
    for y = (1:N)
        if imgf(x,y)>T
            imgg(x,y)=250;
            mean_1 = mean_1+double(imgf(x,y));
            cnt_1 = cnt_1+1;
        else
            imgg(x,y)=5;
            mean_0 = mean_0+double(imgf(x,y));
            cnt_0 = cnt_0+1;
        end
    end
end

imgg = uint8(imgg);
if mean_0 == 0
    cnt_0 = 1;
end
if mean_1 == 0
    cnt_1 = 1;
end

mean_0 = mean_0 / cnt_0;
mean_1 = mean_1 / cnt_1;

end
