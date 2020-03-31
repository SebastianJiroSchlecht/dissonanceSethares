% Compute the dissonance measure for two tones with partials
%
% (c) Sebastian Jiro Schlecht:  23. November 2018
clear; clc; close all;

NumberOfPartials = 7;
LowerToneFrequency = 200; % Hz
HigherToneFrequency = 360; % Hz
PartialFrequenciesLower = LowerToneFrequency*(1:NumberOfPartials);
PartialFrequenciesHigher = HigherToneFrequency*(1:NumberOfPartials);
PartialAmplitudes = 0.9 .^ (1:NumberOfPartials);

PartialFrequenciesAll = [PartialFrequenciesLower, PartialFrequenciesHigher];
PartialAmplitudesAll = [PartialAmplitudes, PartialAmplitudes];

MaximumRatio = 2.3;
Ratios = linspace(1,MaximumRatio,400);

levelOfDissonance=[];
for it = 1:length(PartialFrequenciesAll)
    for alpha = 1:length(Ratios)
        f = [PartialFrequenciesAll(it) Ratios(alpha)*PartialFrequenciesAll(it)];
        a = [PartialAmplitudes, PartialAmplitudes];
        d = dissonanceMeasureFromPartials(f, a);
        levelOfDissonance(alpha,it) = d * 7 * PartialAmplitudesAll(it);
    end
end

%% plot
figure(1); hold on; grid on; set(gcf,'color','w');
stem(PartialFrequenciesLower, PartialAmplitudes, 'g');
stem(PartialFrequenciesHigher, PartialAmplitudes, 'r');

plot( Ratios.'.*PartialFrequenciesAll,levelOfDissonance,'b')
title(['Base F0 = ' num2str(LowerToneFrequency) ' Hz'])
xlabel('Frequency [Hz]')
ylabel('Level of Dissonance')
set(gca, 'XTick', 0:200:2000);
ylim([0 1])
xlim([180 1400])




