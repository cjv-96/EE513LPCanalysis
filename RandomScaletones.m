clear all; close all; clc;

%% scale definitions
minorPentScale = [0 3 5 7 10 12 15 17 19 22 24 ];% scale tones of the Minor Pentatonic scale
durations = [.05, .1, .15, .2, .25];%possible durations for randomly generated "song"
majorScale = [0 2 4 5 7 9 11 12];%scale tones of the Major scale
minorScale = [0 2 3 5 7 8 11 12];%scale tones of the Minor scale

%% initialize
Fs = 8000;%sample frequency
Fr = 440;%reference tone frequency
dur = .1;%duration of tone
output = 0;%initialize output to be written to file
%% Generate, play, and write 50 random tones of random durations
output2 = 0; %initialize output array
numtones = 50; %50 tones in "song"
for ii = 1:numtones %generate 50 tones
   duration = durations(randi(size(durations))); %generate a random duration from durations array
   ind = minorPentScale(randi(size(minorPentScale)));%pick a tone from minorPentatonicScale
   result = tonegen(Fr, ind, duration, Fs);%call tonegen with random parameters
   output2 = [output2, result]; %concatenate tones into single array
end
output2 = [output2, tonegen(0, 0, 1, Fs)];
soundsc(output2, Fs);
audiowrite('randomsong.wav', output2, Fs);

