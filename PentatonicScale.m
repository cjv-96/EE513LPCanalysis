function [mp] = PentatonicScale(time, refton, fs)

%% scale definitions
%minorPentScale = [0 3 5 7 10 12 15 17 19 22 24 ];% scale tones of the Minor Pentatonic scale
minorPentScale = [0 3 5 7 10 12 10 7 5 3 0 ]
durations = [.05, .1, .15, .2, .25];%possible durations for randomly generated "song"
majorScale = [0 2 4 5 7 9 11 12];%scale tones of the Major scale
minorScale = [0 2 3 5 7 8 11 12];%scale tones of the Minor scale

%% initialize
Fs = fs;%sample frequency
Fr = refton;%reference tone frequency
dur = time/length(minorPentScale);%duration of tone
output = 0;%initialize output to be written to file

%% generate, play, and write 2 octaves of a minor pentatonic scale
for ii = 1:length(minorPentScale)%step through the Minor pentatonic
   result = tonegen(Fr, minorPentScale(ii), dur, Fs);%wrte reults of tonegen function to an array
   output = [output,result];%concatenate tones into one array
end
   %output = [output, tonegen(0,0, .1, 8000)];%add silent tone to the end of array
 %(patches an issue that causes the last not to be cut off when exporting to a .wav file)
mp = output; 
%soundsc(output, Fs);%preview file by sending output array to speakers
%audiowrite('minorPent.wav', output, Fs);%write to file
%pause(3);
end