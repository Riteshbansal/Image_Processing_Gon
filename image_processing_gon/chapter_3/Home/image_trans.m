function g = image_trans(f, varargin)
% INTRANPS performs intensity (gray-level) transformations.
% G = INTRANS(F,'neg' ) computes the negative of Input Image F .

% G = INTRANS(F, 'log', C, CLASS) computes C*log(1 + F) and
% multlplies the result by (positive) constant C. If the last two
% parameters are omitted, C defaults to 1 . Because the log is used
% frequently to display Fourier spectra, parameter CLASS offers the
% option to speclfy the class of the output as 'uint8' or
% 'uintl6'. If parameter CLASS 1s omitted, the output is of the
% same class as the lnput.

% G = INTRANS(F, 'gamma', GAM) performs a gamma transformatlon on
% the Input Image using parameter GAM (a requlred input)

% G = INTRANS(F, 'stretch', M, E) computes a contrast-stretching
% transformation uslng the expression 1./(I + (M. I(F+eps)).^E).
% Parameter M must be l n the range [0, I]. The default value for
% M IS mean2(im2double(F)),and the default value for E is 4.


% For the 'neg' , 'gamma', and 'stretch' transformatlons, double input
% images whose maximum value 1s greater than 1 are scaled first using
% MAT2GRAY. Other lmages are converted to double flrst uslng IM2DOUBLE.
% For the ' log ' transformatlon, double lmages are transformed wlthout
% being scaled; other Images are converted to double flrst uslng IM2DOUBLE

% The output 1s of the same class as the input,except if a
% different class 1s speclfled for the 'log' option

% Verlfy the correct number of inputs.
error(nargchk(2, 4 ,nargin));

% Store the class of the input for use later
classin = class(f);

% If the input is of class double, and it is outside the range
% [O, 1] , and the specified transformation is not 'log', convert the "input to the range [0, 1].

if strcmp(class(f), 'double') & max(f(:))> 1 & strcmp(varargin{1}, 'log')
    f = mat2gray(f);
else % Convert to double, regardless of class(f).
    f = im2double(f);
end
% Determine the type of transformation specified.
method = varargin{1};
% Perform the intensity transformation specified.
switch method
    case 'neg'
        g = imcomplement(f);
    case 'log'
        if length(varargin) == 1
            c = 1;
        elseif length(varargin) == 2
            c = varargin{2};
        elseif length(varargin) == 3
            c = varargin{2};
            classin = varargin{3};
        else
            error('Incorrect number of inputs for the log option.')
        end
        g = c*(log(l+ double(f)));
    case 'gamma'
        if length(varargin) < 2
            error('Not enough inputs for the gamma option.')
        end
        gam = varargin{2};
        g = imadjust(f, [ ], [ ], gam);
    case 'stretch'
        if length(varargin) == 1
            % Use defaults.
            m = mean2(f);
            E=4.0;
        elseif length(varargin) == 3
            m = varargin{2};
            E = varargin{3};
        else error('Incorrect number of inputs for the stretch option.')
        end
        g = 1./(1 + (m./(f+ eps)).^E);
    otherwise
        error('Unknown enhancement method.')
end
% Convert to the class of the input image.
g = changeclass(classin, g);
end