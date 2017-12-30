clear all;
clear
clc;
%读进图像
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif'}, '选择图片');

%没有图像
if filename == 0
    return;
end

imgsrc = imread([pathname, filename]);
[y, x, dim] = size(imgsrc);

%转换为灰度图
if dim>1
    imgsrc = rgb2gray(imgsrc);
end

sigma = 1;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');

zz = double(img);

 %----------------------------------------------------------
 %自己的边缘检测函数
 [m theta sector canny1  canny2 bin] = canny1step(img, 22);
  [msrc thetasrc sectorsrc c1src  c2src binsrc] = canny1step(imgsrc, 22);
 %Matlab自带的边缘检测
 ed = edge(img, 'canny', 0.5); 


[xx, yy] = meshgrid(1:x, 1:y);

figure(1)
    %mesh(yy, xx, zz);
    surf(yy, xx, zz);
    xlabel('y');
    ylabel('x');
    zlabel('Grayscale');
    axis tight

figure(2)    
    subplot(4,2,1);
        imshow(imgsrc);%原图
    subplot(4,2,2);
        imshow(img);%高斯滤波后
    subplot(4,2,3);
        imshow(uint8(m));%导数
    subplot(4,2,4);
        imshow(uint8(canny1));%非极大值抑制
    subplot(4,2,5);
        imshow(uint8(canny2));%双阈值
    subplot(4,2,6);
        imshow(ed);%Matlab自带边缘检测
    subplot(4,2,8);
        imshow(bin);%我自己的bin

figure(3)
    edzz = 255*double(ed);
    mesh(yy,xx,edzz);
    xlabel('y');
    ylabel('x');
    zlabel('Grayscale');
    axis tight 



figure(4)
    mesh(yy,xx,m);%画偏导数
    xlabel('y');
    ylabel('x');
    zlabel('Derivative');
    axis tight 

figure(5)
    mesh(yy,xx,theta);
    xlabel('y');
    ylabel('x');
    zlabel('Theta');
    axis tight

figure(6)
    mesh(yy,xx,sector);
    xlabel('y');
    ylabel('x');
    zlabel('Sector');
    axis tight

figure(7)
    mesh(yy,xx,canny2);
    xlabel('y');
    ylabel('x');
    zlabel('Sector');
    axis tight



function [ m, theta, sector, canny1,  canny2, bin] = canny1step( src,  lowTh)
%canny函数第一步，求去x，y方向的偏导，模板如下：
% Gx
% 1  -1
% 1  -1
% Gy
% -1  -1
%  1    1
%------------------------------------
% 输入：
% src：图像，如果不是灰度图转成灰度图
% lowTh：低阈值
% 输出：
% m： 两个偏导的平方差，反映了边缘的强度
% theta：反映了边缘的方向
% sector：将方向分为3个区域，具体如下
% 2 1 0
% 3 X 3
% 0 1 2
% canny1：非极大值
% canny2：双阈值抑制
% bin ：     二值化
%--------------------------------------- 


[Ay Ax dim ] = size(src);
%转换为灰度图
if dim>1
    src = rgb2gray(src);
end


src = double(src);
m = zeros(Ay, Ax); 
theta = zeros(Ay, Ax);
sector = zeros(Ay, Ax);
canny1 = zeros(Ay, Ax);%非极大值抑制
canny2 = zeros(Ay, Ax);%双阈值检测和连接
bin = zeros(Ay, Ax);
for y = 1:(Ay-1)
    for x = 1:(Ax-1)
        gx =  src(y, x) + src(y+1, x) - src(y, x+1)  - src(y+1, x+1);
        gy = -src(y, x) + src(y+1, x) - src(y, x+1) + src(y+1, x+1);
        m(y,x) = (gx^2+gy^2)^0.5 ;
        %--------------------------------
        theta(y,x) = atand(gx/gy)  ;
        tem = theta(y,x);
        %--------------------------------
        if (tem<67.5)&&(tem>22.5)
            sector(y,x) =  0;    
        elseif (tem<22.5)&&(tem>-22.5)
            sector(y,x) =  3;    
        elseif (tem<-22.5)&&(tem>-67.5)
            sector(y,x) =   2;    
        else
            sector(y,x) =   1;    
        end
        %--------------------------------        
    end    
end
%-------------------------
%非极大值抑制
%------> x
%   2 1 0
%   3 X 3
%y  0 1 2
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if 0 == sector(y,x) %右上 - 左下
            if ( m(y,x)>m(y-1,x+1) )&&( m(y,x)>m(y+1,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 1 == sector(y,x) %竖直方向
            if ( m(y,x)>m(y-1,x) )&&( m(y,x)>m(y+1,x)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 2 == sector(y,x) %左上 - 右下
            if ( m(y,x)>m(y-1,x-1) )&&( m(y,x)>m(y+1,x+1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 3 == sector(y,x) %横方向
            if ( m(y,x)>m(y,x+1) )&&( m(y,x)>m(y,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        end        
    end%end for x
end%end for y

%---------------------------------
%双阈值检测
ratio = 2;
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if canny1(y,x)<lowTh %低阈值处理
            canny2(y,x) = 0;
            bin(y,x) = 0;
            continue;
        elseif canny1(y,x)>ratio*lowTh %高阈值处理
            canny2(y,x) = canny1(y,x);
            bin(y,x) = 1;
            continue;
        else %介于之间的看其8领域有没有高于高阈值的，有则可以为边缘
            tem =[canny1(y-1,x-1), canny1(y-1,x), canny1(y-1,x+1);
                       canny1(y,x-1),    canny1(y,x),   canny1(y,x+1);
                       canny1(y+1,x-1), canny1(y+1,x), canny1(y+1,x+1)];
            temMax = max(tem);
            if temMax(1) > ratio*lowTh
                canny2(y,x) = temMax(1);
                bin(y,x) = 1;
                continue;
            else
                canny2(y,x) = 0;
                bin(y,x) = 0;
                continue;
            end
        end
    end%end for x
end%end for y




end%end of function