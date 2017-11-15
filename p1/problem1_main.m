% DIP problem 1
% Histogram euqlization
% author: wang.yiqing
% Dependent function: histShow, histEqual

% =========================================================================
fp1 = 'Fig1.jpg';
fp2 = 'Fig2.jpg';
f1 = imread(fp1);
f2 = imread(fp2);
% =======================================================================
% process Fig1.jpg
figure, imshow(f1);
[fx1, fy1] = histShow(f1);
figure, bar(fx1, fy1);
g1 = histEqual(f1);
figure, imshow(g1);
[gx1, gy1] = histShow(g1);
figure, bar(gx1, gy1);

% process Fig2.jpg
figure, imshow(f2);
[fx2, fy2] = histShow(f2);
figure, bar(fx2, fy2);
g2 = histEqual(f2);
figure, imshow(g2);
[gx2, gy2] = histShow(g2);
figure, bar(gx2, gy2);

% =======================================================================
imwrite(g1, 'g1.png');
imwrite(g2, 'g2.png');

