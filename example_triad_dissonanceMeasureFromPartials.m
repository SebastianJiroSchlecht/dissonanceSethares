% Compute the dissonance measure for three tones with partials 
%
% (c) Sebastian Jiro Schlecht:  23. November 2018
clear; clc; close all;

NumberOfPartials = 7;
LowerToneFrequency = 500;
PartialFrequencies=LowerToneFrequency*(1:NumberOfPartials);
PartialAmplitudes = 0.88.^(1:NumberOfPartials);

NumberOfSteps = 100;
MaximumRatio = 2.1;
Ratios = linspace(1,MaximumRatio,NumberOfSteps);

levelOfDissonance=zeros(NumberOfSteps);
itAlpha = 1;
for alpha = Ratios
    itBeta = 1;
    for beta = Ratios
        f = PartialFrequencies .* [1; alpha; alpha*beta];
        a = PartialAmplitudes .* [1; 1; 1];
        d = dissonanceMeasureFromPartials(f, a);
        levelOfDissonance(itAlpha,itBeta) = d;
        itBeta = itBeta + 1;
    end
    itAlpha = itAlpha + 1;
end


%% plot
close all
figure(1); hold on; grid on; set(gcf,'color','w');
surf(rat2cent(Ratios),rat2cent(Ratios),levelOfDissonance,'EdgeColor','none')
shading interp;
title(['Base F0 = ' num2str(LowerToneFrequency) ' Hz'])
xlabel('Lower Interval [cents]')
ylabel('Upper Interval [cents]')
ch = colorbar;
ylabel(ch, 'Level of Dissonance')
axis tight



