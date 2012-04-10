shapes = {'full','same','valid'};
% should try with both even and odd length filters by setting gausswin(#)
filter = gausswin(33);
filter = filter / sum(sum(filter));

%% test fftconv code matches conv for vector signals
signal = [1:100]' + randn(100,1);

for idx=1:length(shapes)
    shape = shapes{idx};
    figure()
    
    convout = conv(signal,filter,shape);
    plot(convout,'gx');
    hold on
    
    fftconvout = fftconv(signal,filter,shape);
    plot(fftconvout,'b-');
    hold off
    
    legend('conv','fftconv');
    if length(fftconvout) == length(convout)
        title(sprintf('%s, error=%0.3f',shape,sum(sum((convout-fftconvout).^2))));
    else
        title(sprintf('%s, len(conv) = %d, len(fftconv) = %d',shape,length(convout),length(fftconvout)));
    end
    
end

%% test fftconv code matches conv for matrix inputs
signal = repmat([1:100]',1,3) + 5*randn(100,3);

for idx=1:length(shapes)
    shape = shapes{idx};
    figure()
    
    convout = [];
    for jj=1:size(signal,2)
        convout = [convout,conv(signal(:,jj),filter,shape)];
    end
    plot(convout,'gx');
    hold on
    
    fftconvout = fftconv(signal,filter,shape);
    plot(fftconvout,'b-');
    hold off
    
end
