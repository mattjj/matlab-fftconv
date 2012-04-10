function c = fftconv(x,y,shape)
% Computes the same thing as conv(x,y,shape) up to numerical errors but uses the
% FFT for nlogn computation time instead of n^2. Unlike conv, also works on
% matrices (where each column is a signal).
%
% Each input (x or y) can be a column vector or a matrix:
%  - if given two column vectors, it returns their convolution
%  - if given one column vector and one matrix, must have size(matrix,1) ==
%  size(colvec,1), it returns the colvec convolved against each of the matrix
%  columns
%  - if given two matrices, it returns a matrix of the same shape which contains
%  the convolutions of corresponding columns
%
% See 'help conv' for description of the shape argument.
%
% Output reserves the right to go crazy if you give row vectors.
%
% This computation may not be what you want; fftfilt is a much smarter function.
% See blogs.mathworks.com/steve/2009/11/03/the-conv-function-and-implementation-tradeoffs/

    if nargin < 3, shape = 'full'; end

    padded = length(x) + length(y) - 1; % for zero padding, otherwise fft computes circular convolution
    k = 2^nextpow2(padded);
    c = real(ifft(bsxfun(@times,fft(x,k),fft(y,k)))); % the only real work in this function!

    smaller = min(size(x,1),size(y,1));
    if strcmp(shape,'valid')
        c = c(smaller:padded-smaller+1,:);
    elseif strcmp(shape,'same')
        rounded = ceil(smaller/2) + mod(smaller+1,2);
        c = c(rounded:rounded+max(size(x,1),size(y,1))-1,:);
    elseif strcmp(shape,'full')
        c = c(1:padded,:);
    else
        error('invalid shape argument to fftconv: %s',shape);
    end

end
