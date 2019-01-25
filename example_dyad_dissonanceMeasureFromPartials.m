% Compute the dissonance measure for two tones with partials 
%
% (c) Sebastian Jiro Schlecht:  23. November 2018
clear; clc; close all;

NumberOfPartials = 7;
LowerToneFrequency = 500; % Hz
PartialFrequencies=LowerToneFrequency*(1:NumberOfPartials); 
PartialAmplitudes = 0.8 .^ (1:NumberOfPartials);

MaximumRatio = 2.3; 
Ratios = linspace(1,MaximumRatio,100);

levelOfDissonance=[];
for alpha = Ratios
    f = [PartialFrequencies alpha*PartialFrequencies];
    a = [PartialAmplitudes, PartialAmplitudes];
    d = dissonanceMeasureFromPartials(f, a);
    levelOfDissonance(end+1) = d;
end

%% plot
figure(1); hold on; grid on;
plot( rat2cent(Ratios),levelOfDissonance)
title(['Base F0 = ' num2str(LowerToneFrequency) ' Hz'])
xlabel('F0 Interval [cents]')
ylabel('Level of Dissonance')
set(gca, 'XTick', 0:200:2000);
xlim([0 1400])




