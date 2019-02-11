function wsig = whisperme(insig, fs, uvlpc, lpcorder, wp, errs)
%	This function takes a signal and reconstructs it using lpc analysis
%	according to the functionality flag wp. It can reconstruct the signal
%	as it was, as a whisper, with a custom error sequence, or with a
%	sinusoid. To reconstruct as a whisper, uvlpc must contain the lpc
%	analysis coeifficients of some whispered speech.
%
%	wsig = whisperme(insig, fs, uvlpc, lpcorder, wp, errs)
%	INPUTS:	insig	- signal to be mimicked
%			fs		- sample frequency
%			uvlpc	- unvoiced lpc coeiffs			
%			lpcorder- order of lpc analysis
%			wp		- functionality flag
%						0: reconstruct original signal
%						1: reconstruct as a whisper
%						2: reconstruct using custom error sequence
%						3: reconstruct using single sinusoid @ 880 HZ
%			errs	- custom error sequence for wp = 2

	[lpca, err] = lpc(insig, lpcorder); %get lpc coeiffs
	
	%% part3
	if wp == 1 %whisper
	awgn = randn(length(insig), 1); %generate white noise
	[b, a] = butter(8, 600/(fs/2), 'high'); %highpass filter noise
	awgn = filter(b, a, awgn);	
	awgn = filter(uvlpc, 1, awgn); %filter noise to match whispered speech error sequence
	%% part4
	%This does not work. I can get the message to reconsturct poorly with
	%just one sinusoid, but usng a scale doesnt seem to work by itself. I
	%cannot figure out how to fix it.
	
	elseif wp == 2 %reconstruct with error seq
	awgn = errs ./ std(insig); %scale to input signal
	[b, a] = butter(8, [300 3000]/(fs/2)); %bandpass filter in feeble attemmpt to make this work
	awgn = filter(b, a, awgn);
	elseif wp == 3 %use sinnusoid: works better than part 4
	tax = (0:length(insig)-1)/fs;
	awgn = cos(2*pi*880*tax);
	awgn = awgn'
	%% part 1
	else
	awgn = filter(lpca, 1, insig) % reconstruct orginal
	end
	%awgn = filter(lpca, 1, awgn);
	wsig = filter(1, lpca, awgn); %output reconstructed signal
end