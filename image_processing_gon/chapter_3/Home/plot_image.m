clc
clear
gama = 0.5;
a(:,:,1) = (1:256);


b = mod((46.1*log(1+a)),256);
plot(a,b)
xlabel('input');
ylabel('output');

% % a = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% 
% c = a.^gama;
% % c = mod(c,256);
% c = uint8(c);
% plot(a,c)
