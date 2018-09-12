clc
clear
%  y=[207 206 177 203 204 203 183 201 173 208 207 194 205 207 176 206 198 ... 
%      205 208 207 191 184 201 206 208 185 193 205 204 202 189 205 207 198 ...
%      185 194 209 210 197 201 208 208 191 204 209 209 199 205 210 211 203 ...
%      194 196 206 194 194 208 208 212 196 203 210 204 192 193 209 210 207 ...
%      202 209 206 194 194 197 205 197 197 207 201 206 192 192 196 196 196 ...
%      199 205 205];
%     y = detrend(y,0);
%    npad = 2*length(y);
%    ydft = fft(y,npad);
%    freq = 0:30/npad:15;
%    plot(freq,abs(ydft(1:npad/2+1)))
%    xlabel('Hz'); ylabel('Magnitude');


% I1 = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
% 
t = -124:1:124;
ph = t(:,:);
[t,ph] = meshgrid(t,ph);
r = sin((3*t)-ph) + sin((7*t)-ph) + sin((12*t)-ph);
r_f = sin((-1*(3*t)-ph)) + sin(-1*((7*t)-ph)) + sin(-1*((12*t)-ph));

r1 = ((((fft2(r)))));
r_1 = abs(r1);
r2 = fft2(r1);

% r2_inv = real((ifft2(r1)));
r3 = fft2(r2);
r4 = fft2(r3);
% r5 = fft(r4);

% r_1 = fftshift(r1);
% r_2 = fft2(r_1);
% 
r_1 = log(1+abs(r_1));

% % plot(t,ph);
figure
subplot(2,2,1),mesh(t,ph,r_1);
subplot(2,2,2),mesh(t,ph,log(1+abs(r2)));
subplot(2,2,3),mesh(t,ph,log(1+abs(r3)));
subplot(2,2,4),mesh(t,ph,log(1+abs(r4)));

% 
% H = fftshift((fft2(fftshift(I1)))); 
% I2 = fftshift(ifft2(fftshift(exp(1j.*angle(H)))));

