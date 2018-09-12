
clc
clear


% a= [155,152,154;161,163,170;255,155,160];
% b= [155,210,154;255,163,250;0,155,0];

a= [1,128,255;54,155,210;255,254,123];
c= floor(mean2(a));


% c1= floor(mean2(b));
[M,N] = size(a);
Image_change = a(:,:);
Image_change(1,1) = bitxor(c,Image_change(1,1));
% Image_change = confusion_impl2(Image_change,0.6);

for i = 1:1:M
    if(i~=1)
        %         temp = bitxor(Image_change(i-1,N), xsin(i,1));
        %         Image_change(i,1) = bitxor(temp,Image_change(i,1));
        Image_change(i,1) = bitxor(Image_change(i-1,N),Image_change(i,1));
        
    end
    for j = 2:1:N
        %         temp = bitxor(Image_change(i,j-1), xsin(i,j));
        %         Image_change(i,j) = bitxor(temp,Image_change(i,j));
        Image_change(i,j) = bitxor(Image_change(i,j-1),Image_change(i,j));
        
    end
end
% Image_change = confusion_impl2(Image_change,0.6);

c2= floor(mean2(Image_change));

% b = [129, 128, 129;129, 128, 129];

% d= mean2(b);
%
% corr2(a,b)
%
% x = c*((a.'+a)/(a.*a.'));
%
% b = x.*a;
% b = floor(b);


% a = a - mean2(a);
% b = b - mean2(b);
% r = sum(sum(a.*b))/sqrt(sum(sum(a.*a))*sum(sum(b.*b)));
% % r = sum(sum(a.*b));
% r1 = sum(sum((a.*b)./sqrt((a.*a).*(b.*b))));
% b = bitxor(a);

% [x,y] = corelation(a,b);
[x1,y1] = corelation(a,Image_change);
% mat = 1:256;
% mat = reshape(mat,16,16)';
% mat2 = bitxor(mat,c);
% imhist(mat2)
% imhist(uint8(mat2))
% corr2(mat,mat2)
