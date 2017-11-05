fp = input('Input the image path: ', 's');
f = imread(fp);
fprintf('----------------------\n');
fprintf('Display the image %s\n', fp);
imshow(f);

fprintf('Display the histogram graph\n');
figure, imhist(f);

fprintf('Display the equlized graph of using default histeq\n');
newf = histeq(f);
figure, imshow(newf);

fprintf('Display the equlized histogram\n');
figure, imhist(newf);

fprintf('Using self-defined function to process\n');

fprintf('Self-defined histogram function\n');
g = f(:)';
n = length(g);
x = (1 : 256);
y = zeros(1, 256);
for i = (1 : n)
    y(g(i)) = y(g(i)) + 1;
end
figure, bar(x, y);

fprintf('Self-defined histogram equalization\n');
T = zeros(1, 256);
a = 0;
for i = (1 : 256)
    T(i) = a + y(i);
    a = T(i);
end
T = round(255 * T / n);
for i = (1 : n)
    g(i) = T(g(i)+1);
end
newf2 = reshape(g, size(f));
figure, imshow(newf2);

figure, imhist(newf2);