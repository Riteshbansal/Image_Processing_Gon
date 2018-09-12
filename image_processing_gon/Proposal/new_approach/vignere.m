function [ Image_change2 ] = vignere( Image_change,xlog )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%matrix vignor 2
size_matrix = size(Image_change);
vig2 = zeros(256,256);
for i=1:1:256
vig2(1,i) =  i;
end

xlog = 1+floor(mod(xlog*10^6,255));

vig2(1,:) = circshift(vig2(1,:),-xlog(1),2);
% count = 1;
for i = 2:1:256
    temp(1,:) = vig2(1,:);
    temp = circshift(temp,-xlog(i),2); 
    vig2(i,:) = temp(1,:); 
%     count= count+1;
end
 
%  [xsin,xlog] = chaotic_map(0.6,Image_change);
% xlog = 1+floor(mod(xlog*10^6,255));
% xsin = reshape(xsin,size(x,1),size(x,2))';
xlog = reshape(xlog,size(Image_change,1),size(Image_change,2))';
% 
Image_change = 1+Image_change;

Image_change2(:,:) = Image_change(:,:);
Image_change2(1,1) = vig2(xlog(1,1),Image_change(1,1));
for i = 1:1:size_matrix(1);
    if(i~=1)
    Image_change2(i,1) = vig2(xlog(i,1),Image_change(i,1));
    end
   for j = 2:1:size_matrix(2)
        Image_change2(i,j) = vig2(xlog(i,j),Image_change(i,j));
   end    
end

Image_change2 = Image_change2-1;

end

