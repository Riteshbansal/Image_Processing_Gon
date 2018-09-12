clc
clear all
close all
K = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
subplot(3,5,1),
imshow(K),
title('original image');
% I=imnoise(K,'gaussian');
K = imnoise(K,'salt & pepper', 0.2);
I = imnoise(K,'gaussian',0,0.1);
subplot(3,5,2),
imshow(I),title('Image with gaussian noise');

%arithmetic meanfilter
h = ones(5,5) / 25;
I2 = imfilter(I,h);
subplot(3,5,3),imshow(I2),title('arithmetic mean filtered image');

%geometric mean filter
x=double(I);
y(1,: )=x(1,: );
y(1:512,1)=x(1:512,1);
y(512,: )=x(512,: );
y(1:512,512)=x(1:512,512);
for k=2:511
    for j=2:511
        y(k,j)=(x(k-1,j-1)*x(k,j-1)*....
            x(k-1,j)*x(k+1,j)*x(k,j)*....
            x(k,j-1)*x(k-1,j)*x(k+1,j+1)*....
            x(k,j+1))^(1/9);
    end
end
W=uint8(y);
subplot(3,5,4),imshow(W),title('geometric mean filtered image');

%harmonic mean filter
I1 = imfilter(I, (1/9)*ones(3, 3), 'symmetric');

x=double(I1);

y(1,: )=x(1,: );
y(1:512,1)=x(1:512,1);
y(512,: )=x(512,: );
y(1:512,512)=x(1:512,512);
for k=2:511
    for j=2:511
        y(k,j)=9/(1/(x(k-1,j-1))+1/(x(k,j-1))+....
            1/(x(k-1,j))+1/(x(k+1,j))+1/(x(k,j))+....
            1/(x(k,j-1))+1/(x(k-1,j))+1/(x(k+1,j+1))+....
            1/(x(k,j+1)));
    end
end
Z=uint8(y);
subplot(3,5,5),imshow(Z),title('harmonic mean filtered image');

%contrahormonic filter
data=im2double(I);
Q=-2;
sumn=[];
sumd=[];
pixln=0;
pixld=0;
ro=512;
col=512;
for i=1:ro;
    for j=1:col;
        for m=-1:1;
            for n=-1:1;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ...% To keep indices in limit
                        1+m>0 && 1+m<ro && ...
                        1+n>0 && 1+n<col)
                    pixl1=(data(i+m,j+n)).^(Q+1);
                    % Application of Formula
                    pixl2= (data(i+m,j+n)).^Q;
                    pixln=pixln+pixl1;
                    % Application of Summation
                    pixld=pixld+pixl2;
                end
            end
        end
        reformedimage(i,j)=(pixln/pixld);
        pixln=0;pixld=0;
    end
end

subplot(3,5,6),imshow(reformedimage),title('contra-harmonic mean (Q=-ve)');
data=im2double(I);
Q=2;
sumn=[];sumd=[];
pixln=0;pixld=0;ro=512;col=512;
for i=1:ro;
    for j=1:col;
        for m=-1:1;
            for n=-1:1;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ... % To keep indices in limit
                        1+m>0 && 1+m<ro && ...
                        1+n>0 && 1+n<col)pixl1=(data(i+m,j+n)).^(Q+1); 
                    % Application of Formula
                    pixl2= (data(i+m,j+n)).^Q;
                    pixln=pixln+pixl1; 
                    % Application of Summation
                    
                    pixld=pixld+pixl2;
                end
            end
        end
        reformedimage(i,j)=(pixln/pixld);
        pixln=0;pixld=0;
    end
end
subplot(3,5,7),imshow(reformedimage),title('contra-harmonic mean (Q=+ve)');


%median filter
A = medfilt2(I,[3 3]);
subplot(3,5,8),imshow(A),title('median filtered image');

%maxfilter

[m n]=size(I);
c=ones(3,3)/9;
[p q]=size(c);
p=(p-1)/2;
q=(q-1)/2;z=I;
for i=p+1:m-p
    for j=q+1:n-q
        mask1=zeros(3,3);
        for k=-p: p
            for l=-q:q
                
                mask1(p+1-k,q+1-l)=I(i-k,j-l);
            end
        end
        max1=mask1( : );
        max1=max(max1);
        z(i,j)=max1;
    end
end
subplot(3,5,9),imshow(uint8(z)),title('max filtered image');
%min filter
[m n]=size(I);
c=ones(3,3)/9;
[p q]=size(c);
p=(p-1)/2;
q=(q-1)/2;
v=I;
for i=p+1:m-p
    for j=q+1:n-q
        mask1=zeros(3,3);
        for k=-p: p
            for l=-q:q
                mask1(p+1-k,q+1-l)=I(i-k,j-l);
            end
        end
        min1=mask1( : );
        min1=min(min1);
        v(i,j)=min1;
    end
end
subplot(3,5,10),imshow(uint8(v)),title('min filtered image');
[m n]=size(I);
c=ones(3,3)/9;
[p q]=size(c);
p=(p-1)/2;
q=(q-1)/2;z=I;
for i=p+1:m-p
    for j=q+1:n-q
        mask1=zeros(3,3);
        for k=-p: p
            for l=-q: q
                mask1(p+1-k,q+1-l)=I(i-k,j-l);
            end
        end
        mid1=mask1(: );
        mid1=(min(mid1)+max(mid1))/2;
        z(i,j)=mid1;
    end
end
subplot(3,5,11),imshow(uint8(z)),title('mid point filtered image');

%alpha-trimmed filter
m = 3; n = 3; d = 2;
if (d <= 0) || (d/2 ~= round(d/2))
    error('d must be a positive, even integer.')
end
inclass = class(I);
g = im2double(I);
f = imfilter(I, 9*ones(m, n), 'symmetric');
for k = 1:d/2
    f = imsubtract(f, ordfilt2(I, k, ones(m, n), 'symmetric'));
end
for k = (m*n - (d/2) + 1):m*n
    f = imsubtract(f, ordfilt2(I, k, ones(m, n), 'symmetric'));
end
f = f / (m*n - d);
subplot(3,5,12),imshow(f),title('alpha-trimmed filtered image');