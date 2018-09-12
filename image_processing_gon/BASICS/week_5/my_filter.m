clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.
fontSize = 15;

% Read in a standard MATLAB color demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'peppers.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
% Display the original color image.
% subplot(3, 4, 1);
% imshow(rgbImage);
% title('Original Color Image', 'FontSize', fontSize);
% % Enlarge figure to full screen.
% set(gcf, 'Position', get(0,'Screensize')); 
% % Give a name to the title bar.
% set(gcf,'name','Salt and Pepper Noise Removal Demo','numbertitle','off') 

% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Display the individual red, green, and blue color channels.
% subplot(3, 4, 2);
% imshow(redChannel);
% title('Red Channel', 'FontSize', fontSize);
% subplot(3, 4, 3);
% imshow(greenChannel);
% title('Green Channel', 'FontSize', fontSize);
% subplot(3, 4, 4);
% imshow(blueChannel);
% title('Blue Channel', 'FontSize', fontSize);

% Generate a noisy image.  This has salt and pepper noise independently on
% each color channel so the noise may be colored.
noisyRGB = imnoise(rgb2gray(rgbImage),'salt & pepper', 0.05);
% subplot(3, 4, 5);
% imshow(noisyRGB);
% title('Color Image with Salt and Pepper Noise', 'FontSize', fontSize);

% Extract the individual red, green, and blue color channels.
% redChannel = noisyRGB(:, :, 1);
% greenChannel = noisyRGB(:, :, 2);
% blueChannel = noisyRGB(:, :, 3);
blocksize = 16;
 [row,col] = size(noisyRGB);

clearvars -except noisyRGB  
I = noisyRGB(1:4,1:4);

for i=1:10000
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x+1,y);
    p(i)=CiI(x,y);
    q(i)=CiI(x+1,y);
end
rmn=[];rpq=[];
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(1)=Cmn/(Dm*Dn);rpq(1)=Cpq/(Dp*Dq);
% figure,suptitle('correlation of horizontal adjacent pixels');
% subplot(1,2,1),plot(m,n,'k.');
% subplot(1,2,2),plot(p,q,'k.');

for i=1:10000
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x,y+1);
    p(i)=CiI(x,y);
    q(i)=CiI(x,y+1);
end
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(2)=Cmn/(Dm*Dn);rpq(2)=Cpq/(Dp*Dq);
% figure,suptitle('correlation of vertical adjacent pixels');
% subplot(1,2,1),plot(m,n,'k.');
% subplot(1,2,2),plot(p,q,'k.');

for i=1:10000
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x+1,y+1);
    p(i)=CiI(x,y);
    q(i)=CiI(x+1,y+1);
end
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(3)=Cmn/(Dm*Dn);rpq(3)=Cpq/(Dp*Dq);


% end



% for i = 1:blocksize:row-blocksize+1
%     for j = 1:blocksize:col-blocksize+1
%         out = noisyRGB(i:i+blocksize-1,j:j+blocksize-1);
%         z = fft2(out);
%         h = ones(5,5);
%         h = h/25;
%         M= size(out,1);
%         N= size(out,2);
%         h1 = fft2(h,M,N);
%         out1 = z.*h1;
%         out1 = ifft2(out1);
%         out1 = floor(out1);
%         out_img(i:i+blocksize-1,j:j+blocksize-1) = out1(:,:);
%     end
% end
% figure
% subplot(2, 2, 1),imshow(rgb2gray(rgbImage));
% subplot(2, 2, 2),imshow(noisyRGB);
% subplot(2, 2, 3),imshow(uint8(out_img));

%  [row,col] = size(out);
%  x1 = zeros(row,1);
% out1 = [x1,out];
% %  x1 = zeros(row,1);
% z = diff(out1,1,2);
% 
% me = mean(z(:,1));




