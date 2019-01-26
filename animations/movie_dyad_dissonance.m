% create movie with dissonance measure for two tones
%
%
% (c) Sebastian Jiro Schlecht:  16. January 2019
clear; clc; close all;

filename = mfilename;
%% video setup
VideoFrameRate = 30;
videoFWriter = vision.VideoFileWriter([ filename '.avi'], 'FileFormat', 'AVI', 'FrameRate', VideoFrameRate, 'AudioInputPort', true);

%% audio setup
fs = 48000;
AudioStep = fs / VideoFrameRate;

%% video signal setup
example_dyad_dissonanceMeasureFromPartials;
set(gcf,'Position',[600 600 400 200])
set(gcf,'color','w');
intervalPlot = plot(0,0,'r-x'); 

%% audio signal setup
durationOfSweep = 20; % seconds
time = linspace(0,durationOfSweep,fs*durationOfSweep); 
f0 = LowerToneFrequency;
f1 = LowerToneFrequency*MaximumRatio;

chirpLow = 0;
chirpHigh = 0;
for partialNumber=1:NumberOfPartials
    chirpLow = chirpLow + PartialAmplitudes(partialNumber) * chirp(time,f0*partialNumber,durationOfSweep,f0*partialNumber+1,'logarithmic');
    chirpHigh = chirpHigh + PartialAmplitudes(partialNumber) * chirp(time,f0*partialNumber,durationOfSweep,f1*partialNumber,'logarithmic');
end

highF0 = f0 * (f1/f0).^(time/durationOfSweep);

audioSignal = chirpLow + chirpHigh;
audioSignal = audioSignal / 4 / NumberOfPartials;

audioFrames = reshape(audioSignal, [AudioStep, length(audioSignal)/AudioStep]);
highF0Frames = reshape(highF0, [AudioStep, length(highF0)/AudioStep]);


%% content setup
numberOfConfigurations = 12;
delays = 2.^( 1 + (numberOfConfigurations:-1:1));

for frameNumber = 1:durationOfSweep*VideoFrameRate
    
    % create plot
    currentHighF0 = highF0Frames(1,frameNumber);
    currentRatio = currentHighF0 / LowerToneFrequency;
    currentDissonance = interp1(Ratios, levelOfDissonance, currentRatio);
    set(intervalPlot,'XData',[1 1]*rat2cent(currentRatio),'YData',[0 currentDissonance]);
    
    % retrieve plot
    F = getframe(gcf);
    [I,map] = frame2im(F);

    % audio data
    
   
    % write video
    videoFWriter(I, audioFrames(:,frameNumber).*[1 1] );
end


%% clean up
release(videoFWriter);