clc
clear

x_noise = imnoise(uint8(x),'gaussian');
x1_noise = imnoise(uint8(x1),'gaussian');

x =[
    22 23 24 23
    24 23 24 22
    22 23 23 23];


%     fil = (1/9)*ones(3,3);
%     im = imfilter(x,fil);


x_1 =  floor(mean2(x));
% x_1 = floor( sum(sum((1/numel(x))*(x))));

% x_1_var = sum(sum(((x-x_1).^2)));
xl_flat_var = sum(sum(((x-x_1).^2)));




x1 =[
    22 155 24 23
    24 156 24 22
    22 155 23 23];


x1_1 =  floor(mean2(x1));
% x1_1 =  floor(sum(sum((1/numel(x1))*(x1))));

% x1_1_var = sum(sum(((x1-x1_1).^2)));
xl_edge_var = sum(sum(((x1-x1_1).^2)));

% x =[
% 22 23 24
% 24 23 24
% 22 23 23 ];


flat = evar(x);
edge = evar(x1);

fil = (1/4)*ones(2,2);
im = double(imfilter(x_noise,fil));

fil = (1/4)*ones(2,2);
im_2 = double(imfilter(x1_noise,fil));
l1 = abs(im-x);
l2 = abs(im-x1);

x_2 =  floor(mean2(abs(im-x)));
x1_2 =  floor(mean2(abs(im-x1)));

x_noise_var_flat = sum(sum(((l1-x_2).^2)));
x1_noise_var_edge = sum(sum(((l2-x1_2).^2)));

%     fil = (1/9)*ones(3,3);
%     im2 = imfilter(x1,fil);
