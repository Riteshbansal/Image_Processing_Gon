clc
clear all

Fs = 100;
T = 1/Fs;
L = 100000;
t = (0:L-1);
t = t*T;
freq =5;
X = sin(2*pi*freq*t);
figure
subplot(2,1,1)
plot(t(1:100),real(X(1,1:100)),'b','linewidth',3);
title('Time Domain','fontsize',20,'color',[0 0 255]/255)
xlabel('Time in Seconds','fontsize',20,'color',[0 0 255]/255)
ylabel('Amplitude','fontsize',20,'color',[0 0 255]/255)


n = length(X);
Y = fftshift(fft2(X)/n);


P1 = abs(Y);
subplot(2,1,2)
x = -(Fs-Fs/n)/2:(Fs/n):(Fs-Fs/n)/2;
[P12 , X1] = meshgrid(P1,X);


plot(x,P1,'r','linewidth',3)
title('Frequency Domain','fontsize',20,'color',[255 0 0]/255)
xlabel('Frequency in Hertz','fontsize',20,'color',[255 0 0]/255)
ylabel('Amplitude','fontsize',20,'color',[255 0 0]/255)


mesh(t,X1,P12);

