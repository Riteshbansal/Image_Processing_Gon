clc
clear
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
f= (rgb2gray(im));
%% Histogram
%bar
h = imhist(f);
hl = h(1:10:256);
horz = 1:10:256;
bar(horz, hl)
axis([0 255 0 1500])
set(gca, 'xtick', 0:50:255)
set(gca, 'ytick', 0:2000:15000)

%stem
horz = 1:10:256;
stem(horz,hl, 'fill')
axis([0 255 0 1500])
set(gca, 'xtick', [0:50:255])
set(gca, 'ytick',[0:2000:15000])
plot(horz, hl, 'color','g', 'linestyle','none','marker','s')

%% Histogram eq

j = histeq(f);
figure;
subplot(3,3,1),imshow(f),title('Plain image');
subplot(3,3,2),imshow(j),title('histeq image');
