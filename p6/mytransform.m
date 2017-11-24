function [ imgg ] = mytransform( imgf, matT, interpolation, varargin )
%MYTRANSFORM 
%  
ip = inputParser;
ip.addParameter('boundX', 0);
ip.addParameter('boundY', 0);
ip.addParameter('fillValue', 0);
ip.parse(varargin{:});
para=ip.Results;
    
boundX = para.boundX;
boundY = para.boundY;
fillValue = para.fillValue;
if (boundX==0 || boundY==0)
    setBound=0;
end

[M, N] = size(imgf);
X = [1 N N 1];
Y = [1 1 M M];
tmp = zeros(4, 3);
for i=(1:4)
    tmp(i) = matT * [X(i);Y(i);1];
end
minX = floor(min(tmp(1)));
minY = floor(min(tmp(2))-0.5);
maxX = ceil(max(tmp(1))+0.5);
maxY = ceil(max(tmp(2))+0.5);

if(setBound==1)
    minX = boundX(1);
    maxX = boundX(2);
    minY = boundY(1);
    maxY = boundY(2);
end
imgg = zeros(maxY-minY, maxX-minX);
tmp = zeros(3,1);
for i=(minY:maxY)
    for j=(minX:maxX)
        tmp = matT \ [i;j;1];
        u = tmp(1);
        v = tmp(2);    
        if(isequal('bilinear', interpolation))
            [X, Y, out] = bilinear(tmp);
            if(out==1)
            	imgg(i, j) = fillValue;
            	continue;
            end
            g_12 = (X(2)-u)/(X(2)-X(1))*imgf(X(1),Y(1)) + (u-X(1))/(X(2)-X(1))*imgf(X(1),Y(1));
            g_34 = (X(3)-u)/(X(3)-X(4))*imgf(X(4),Y(4)) + (u-X(4))/(X(3)-X(4))*imgf(X(3),Y(3));
            imgg(i, j) = (Y(3)-v)/(Y(3)-Y(2))*g_12 + (v-Y(2))/(Y(3)-Y(2))*g_34;
        end
        if(isequal('nearest', interpolation))
        	if(round(u)>=1 && round(u)<=N && round(v)>=1 && round(v)<=N)
            	imgg(i, j) = imgf(round(u), round(v))
            end
        end
    end
end
end

function [ X, Y, out ] = bilinear_rect(orig_p)
u = orig_p(1);
v = orig_p(2);
X = zeros(1,4);
Y = zeros(1,4);
X(1) = floor(u);
X(3) = ceil(u);
if(X(1)==X(3))
	X(3) = X(1)+1;
end
Y(1) = floor(v);
Y(3) = ceil(v);
if(Y(1)==Y(3))
	Y(3) = Y(1)+1;
end
out = 0;
if(X(1)<1 || X(3)>N || Y(1)<1 || Y(3)>M)
	out = 1;
end
X(4) = X(1);
X(2) = X(3);
Y(4) = Y(3);
Y(2) = Y(1);
end



