function [ imgg, chain_code ] = border_following( imgf )
%CHAIN_CODE 
%   
[M, N] = size(imgf);
imgg = zeros(M, N);

dir = [0 -1; -1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1];
code = [4 3 2 1 0 7 6 5];
chain_code = zeros(1, M*N);
foundOne = 0;
len_chain = 0;

for x = (2:M-1)
    for y = (2:N-1)
        if imgf(x,y)==255 
            c = [x, y-1];
            b0 = [x, y];
            foundOne = 1;
            break
        end
    end
    if foundOne == 1
        break
    end
end

for z = (1:8)
    tmpx = x+dir(z, 1);
    tmpy = y+dir(z, 2);
    if imgf(tmpx, tmpy)==255
        imgg(tmpx, tmpy) = 255;
        b1 = [tmpx, tmpy];
        len_chain = len_chain + 1;
        chain_code(len_chain) = code(z);
        break
    else
        c = [tmpx, tmpy];
    end
end

b = b1;

while 1
    startc = get_c_dir(b, c);
	for i = (1:8)
        di = fix(mod(startc+i+7, 8)+1);
        tmpx = b(1)+dir(di, 1);
        tmpy = b(2)+dir(di, 2);
        if imgf(tmpx, tmpy)==255
            imgg(tmpx, tmpy) = 255;
            newb = [tmpx, tmpy];
            len_chain = len_chain + 1;
            chain_code(len_chain) = code(di);
            break
        else
            c = [tmpx, tmpy];
        end
    end     
    if isequal(newb, b1) && isequal(b, b0)
        break
    end
    b = newb; 
end

imgg = uint8(imgg);
chain_code = chain_code(1:len_chain-1);

end

function [ ret ] = get_c_dir( b, c )
dir = [0 -1; -1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1];
dif = int32(c-b);
for z = (1:8)
    if dif(1)==dir(z, 1) && dif(2)==dir(z,2)
        ret = z;
        return
    end
end
end