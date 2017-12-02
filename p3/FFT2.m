%----------------------------------------------------------------
function [Xk] = dft(xn)
N=length(xn);
n = 0:1:N-1; % row vector for n
k = 0:1:N-1; % row vecor for k
WN = exp(-j*2*pi/N); % Twiddle factor (w)
nk = n' * k; % creates a N by N matrix of nk values
WNnk = WN .^ nk; % DFT matrix
Xk = (WNnk*xn );
%----------------------------------------------------------------
%----------------------------------------------------------------
function out=dft2(x)
y=zeros(size(x));
y1=y;
C=size(x,2); %number of columns
for c=1:C
y(:,c)=dft(x(:,c));
end
R=size(x,1); %number of rows
for r=1:R
y1(r,:)=dft(y(r,:).');
end
out=y1;
%----------------------------------------------------------------