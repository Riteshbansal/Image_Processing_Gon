function [qs, qm, qmaps] = imageQualityIndex(x, y, ws, p, o1, o2, o3)


% Universal Image Quality Index for 3D images/arrays (m*n*z)

% 06/12/2012     -  Version 1.0
% 09/12/2012     -  Version 1.2
% 26/01/2013     -  Version 2.2 - based on imfilter, precision option

% Author:           Aristidis D. Vaiopoulos


% Default Values
if nargin == 2
   ws = 8;
   p  = 1;
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 3
   p = 1;
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 4
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 5
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 6
   o3 = 'corr';
end

% Find dimensions
sizex = size(x);
sizey = size(y);
if ~isequal(sizex,sizey)
    error('Images must have equal dimensions.')
end
% Number of bands
nb = size(x,3);
% Preallocate mean qs
qs = zeros(nb,1);
if nargout == 3
    % Preallocate qmaps (memory voracious)
    qmaps = single(zeros(sizex));
    for b = 1:nb
        [qs(b), qmaps(:,:,b)] = q_fs( x(:,:,b),y(:,:,b),ws,p, o1, o2, o3);
    end
else
    for b = 1:nb
        qs(b) = q_fs( x(:,:,b),y(:,:,b),ws, p, o1, o2, o3 );
    end
end
% Average quality 
qm = mean(qs);

end