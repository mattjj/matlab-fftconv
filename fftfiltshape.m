function c = fftfiltshape(B,X,shape)
% Returns the same as fftfilt(B,X) except the output follows the 'shape'
% semantics of conv(). See 'help conv' for details on the 'shape' argument.
%
% B should be a column vector, X should be a column vector or a matrix (of
% column vectors to be filtered).

if nargin < 3, shape = 'full'; end

if strcmp(shape,'full')
    c = fftfilt(B,[X;zeros(length(B),size(X,2))]);
elseif strcmp(shape,'valid')
    c = fftfilt(B,X);
    c = c(size(B,1):end,:);
elseif strcmp(shape,'same')
    c = fftfilt(B,[X;zeros(length(B),size(X,2))]);
    rounded = ceil(size(B,1)/2) + mod(size(B,1)+1,2);
    c = c(rounded:rounded+size(X,1)-1,:);
else
    error('invalid shape argument to fftfiltshape: %s',shape);
end

end