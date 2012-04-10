% adapted from 
% blogs.mathworks.com/steve/2009/11/03/the-conv-function-and-implementation-tradeoffs/
% requires the timeit function from 
% www.mathworks.com/matlabcentral/fileexchange/18798-timeit-benchmarking-function

x = rand(1000, 1);
nn = 25:250:10000;

t_normal = zeros(size(nn));
t_fft = zeros(size(nn));
t_fftfs = zeros(size(nn));

for k = 1:numel(nn)
    n = nn(k);
    y = rand(n, 1);
    t_normal(k) = timeit(@() conv(x, y));
    t_fft(k) = timeit(@() fftconv(x, y));
    t_fftfs(k) = timeit(@() fftfiltshape(x, y));
end
plot(nn, t_normal, nn, t_fft, nn, t_fftfs)
legend({'conv computation', 'fftconv computation', 'fftfiltshape computation'})
xlabel('signal length');
ylabel('time (sec)');
