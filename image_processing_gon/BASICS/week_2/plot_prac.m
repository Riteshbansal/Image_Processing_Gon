clc
clear
% t= -1:0.01:1;
% y=sin((2*pi*5*t)+pi/6);
% 
% plot(t,y);
% 
% stem(t,y);
%% 3d plot
w1 = -pi:0.01:pi;
w2 = -pi:0.01:pi;
% w1 = linspace(-pi,pi);
% w2 = linspace(-pi,pi);

[x,y] = meshgrid(w1,w2);

z = (1/3)*(1+cos(x)+cos(y));
z1 = (0.204)+(2*0.124*cos(x))+(2*0.124*cos(y))+(0.075*2*cos(x+y))+(0.075*2*cos(x-y));
z1 = 10*log10(z1);
% syms x y
% 
% ezsurf((1/3)*(1+cos(x)+cos(y)), [-pi, pi, -pi, pi])

% mesh(x,y,z);
mesh(x,y,z1);
% figure
% surf(x,y,z);
%% complex

% % x = linspace(-4,4);
% % y = sqrt(9-x.^2);
% % plot(x,abs(y));
% % 
% % grid on
% % axis equal

%%
% w = pi/8;
% t = 0:0.1:4*pi;
% y = cos(w*t);
% 
% stem(t,y);
% grid on
% axis equal