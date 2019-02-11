%% -----------------------------------------------------------------------------------------

%funtion: tonegen generates a tone defined by a base frequency, a scale
%degree, a duration, and a sample frequency.
%inputs: freq- the frequency of the reference tone( the tonic of the scale)
%        ind- the number of half steps above or below the reference tone
%        dur- the duration the the tone in seconds
%        Fs- sample frequency

function y = tonegen(freq, ind, dur, Fs)
    %% generate tones
    t = (0:round(dur*Fs)-1)/Fs; %can be replaced with    t = (0:1/Fs:round(dur*Fs)-1)
    s = cos(2*pi*(freq*(2^(ind/12)))*t); %generate waveform using reference tone multiplied by the corrosponding index in equal temperment tuning
    %plot(t,s);%plot the waveform
    
    %% for testing
    %soundsc(s, Fs);%play it
    %audiowrite('t440.wav', s, Fs);
    %% output
    y=s;
end
