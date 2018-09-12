clc
clear
x1 =[
    22 23 24 23
    24 23 24 22
    22 23 23 23];
% 
% x1 =[
%     22 155 24 23
%     24 156 24 22
%     22 155 23 23];

x = double(imnoise(uint8(x1),'gaussian'));
% x1 = double(imnoise(uint8(x1),'gaussian'));


x_1 =  floor(mean2(x));
xl_flat_var = sum(sum(((x-x_1).^2)));


% x1_1 =  floor(mean2(x1));
% xl_edge_var = sum(sum(((x1-x1_1).^2)));

fil = (1/9)*ones(3,3);
im = double(imfilter(x,fil));

% fil = (1/4)*ones(2,2);
% im_2 = double(imfilter(x1,fil));

l1 = abs(im-x);
% l2 = abs(im_2-x1);

x_2 =  floor(mean2(abs(im-x)));
% x1_2 =  floor(mean2(abs(im_2-x1)));

x_noise_var_flat = floor(sum(sum(((l1-x_2).^2))));
% x1_noise_var_edge = floor(sum(sum(((l2-x1_2).^2))));
