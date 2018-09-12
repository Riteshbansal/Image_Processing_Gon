clc
clear all
close all

z = 5i;

x = -2:0.25:2;
z1 = exp(x);
% z2 = 2*x.^exp(-x.^2);


real_z1 = real(z1);
imag_z1 = imag(z1);

% real_z2 = real(z2);
% imag_z2 = imag(z2);

plot(real_z1,imag_z1,'g*')
% % x = -pi:0.01:pi;
% % y = cos(x);
% % z = sin(x);
% % 
% % plot(x,y,x,z);
% % grid on
% % axis equal
% % 
% % xlabel('x-axis');
% % ylabel('y-axis');

% syms x y
% ezsurf(x^2+y^2-2, [-pi, pi, -pi, pi])

% e = 1+-1i;


% 
% x = -10:0.01:10;
% a1 = exp(x);
% plot(x,abs(a1));


% 
% n=1;
% e = -1i;
% d = e*(0:n-1);
% c = d*pi;
% b = c/(2*n);
% a = exp(b);
% ww = (a/sqrt(2*n)).';