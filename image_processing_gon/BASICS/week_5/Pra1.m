clc
clear all
I1 = (imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week4/motion1.jpg'));
bpp=class(I1);
I1= double(I1);
%% Negative Image

I2 = 255-I1;

%% Logarithmic
c = 1;
I3 = c*log(I1+1);

%% Power Law
c1= 1;
Lamda = 0.5;
I4 = c1*(I1.^Lamda);
Lamda = 1/Lamda;
I5 = c1*(I4.^Lamda);

%% Contrast stretching

x_min = min(I1(:));
x_max = max(I1(:));

I6 = (255/(x_max-x_min))*(I1-x_min);

%% DYnamic range Expansion
[row,col] = size(I1);
I7 = zeros(row,col);
for i = 1:1:row
    for j = 1:1:row
        pix = I1(i,j);
        if (pix>50 && pix <150 )
            I7(i,j) = 255;
        else
            I7(i,j) = 0;  
        end
        
    end
    
end



figure
subplot(3,3,1), imshow(mat2gray(I1));
subplot(3,3,2), imshow(mat2gray(I2));
subplot(3,3,3), imshow(mat2gray(I3));
subplot(3,3,4), imshow(mat2gray(I4));
subplot(3,3,5), imshow(mat2gray(I5));
subplot(3,3,6), imshow(mat2gray(I6));
subplot(3,3,7), imshow(mat2gray(I7));


