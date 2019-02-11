function [out] = reconstructme(sig, winlen,  fso);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This script uses a moving window to perform analisis and reconstruct a
%signal using the techniques implemented in whisperme.m. the main
%functionality, reconstrcuting a signal as a whisper, requires the variable
%sigw to contain a signal of any whispered speech that also spoke the
%signal of interest.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%% debug
%fs = 8000;% sample frequency
%dur = 5;% duration in seconds
% f0 = 440; 
% samps = fs * dur;
%tax = (0:samps)/fs;
%sig = cos(2*pi*f0*tax);
%sig = ones(1, samps);

%% read files
%[sig, fso] = audioread('voicedshakesp2.wav'); %signal to be analyzed and reconstructed
%lpcorder = 10;
%[sigw, fsow] = audioread('unvoicedshakesp.wav'); %any whispered speech (should be more than a few seconds long)
%[noisea, err] = lpc(sigw, lpcorder); %get lpc coeiffs of whispered speech
%noisea = [1,-0.899394212958918,0.455298240682548,-0.0181287552638906,0.0149920737255827,-0.157097326384877,0.433359509183491,-0.321737926260731,0.0183532994986199,-0.125543970565014,0.0389120855378956]
%pause;
%% filter parameters
%cncut = 10/(fs*2);  % colored noise filter cutoff
%recut = 300/(fs*2);	% recoding noise cutoff
%% window parameters
winlen = 157;
winover = round(winlen/2)-1;
winshape = tukeywin(winlen, 1);
nfft = 1064;
[psd, psdax] = pwelch(sig, winshape, winover, nfft, fs);
%figure;
%plot(psdax, psd);
%pause;
%% create colored noise
cnb = fir1(20, cncut, 'high');%coeifficients for colored noise filter for whisper recreation
% freqs = [0 67.67	180.5	 308.3	  391	   571.4	819.5    1203	 1353     1714	   2098		fs/2] / (fs/2)
% mags  = [0 8.902e-6 4.066e-5 5.209e-5 1.663e-5 2.664e-6 1.609e-4 4.72e-6 2.134e-5 3.93e-5 1.015e-5	0]
% noiseb = fir2(20, freqs, mags);
%% filter low frequency noise from recording
%if fs ~= fso
%	sig = resample(sig, fs, fso);
%end
%recorder = 4;
%[rcb, rca] = butter(recorder, recut, 'high');
%[rcb2, rca2] = butter(recorder, 2*recut, 'high');
%sig = filtfilt(rcb, rca, sig);

%% slide window
% initialize while loop
first = 1; %start window at begining
last = first+winlen-1; %initalize last index of window
count = 0;

sigout = zeros(1, length(sig));% initialize output
figure(35);
subplot(2, 1, 1);
plot(sig);title('Original Signal');
xlabel('Time (sec)'); ylabel('Amplitude');
disp('Press Any Key to Hear Original Signal');
pause;

soundsc(sig, fs);
[mp] = PentatonicScale(length(sig)/fs, scalestart, fs)'; %generate pentatonic scale
while last < length(sig)
	dataseg  = sig(first:last) .* winshape; %evaluate window
	sigout(first:last) = sigout(first:last) + dataseg'; %accumulate results
	
	%% bookeeping
	count = count + 1;
	first = first + winover;
	last  = first + winlen - 1;
	%% animation
	%figure(444); uncomment to see the signal accumulation animation
	%plot(sigout);
end
figure(35);
subplot(2, 1, 2);
plot(sigout);title('Reconstructed Signal');
xlabel('Time (sec)'); ylabel('Amplitude');
disp('Press Any Key To Hear Reconstructed Signal');
pause;

%soundsc(sigout, fs);








end