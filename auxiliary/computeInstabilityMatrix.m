function [levelOfInstability,Ratios] = computeInstabilityMatrix(NumberOfPartials, LowerToneFrequency, PartialAmplitudeDecay)

PartialFrequencies=LowerToneFrequency*(1:NumberOfPartials);
PartialAmplitudes = PartialAmplitudeDecay.^(1:NumberOfPartials);

NumberOfSteps = 200;
MaximumRatio = 1.6;
Ratios = linspace(1,MaximumRatio,NumberOfSteps);

levelOfInstability=zeros(NumberOfSteps);
itAlpha = 1;
for alpha = Ratios
    itBeta = 1;
    for beta = Ratios
        f = PartialFrequencies .* [1; alpha; alpha*beta];
        a = PartialAmplitudes .* [1; 1; 1];
        dSethares = dissonanceMeasureFromPartials(f, a);
        levelOfInstability(itAlpha,itBeta) = dSethares;
        itBeta = itBeta + 1;
    end
    itAlpha = itAlpha + 1;
end