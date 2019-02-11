function [b] = noisefilt(insig, psd, psdax, numpoints, fs)
	i = 1
	order = 30;
	coeiffs = [0];
	mags = [psd(2)];
	psd = envelope(psd, 50, 'peak');
	while i < length(psdax)
		coeiffs = [coeiffs (psdax(i)/(fs/2))];
		mags = [mags abs(psd(i))];
		i = i + round(length(insig)/numpoints);
	end
	coeiffs = [coeiffs 1];
	mags = [mags mags(end)];
	
	b = fir2(order, coeiffs, mags)
	
end