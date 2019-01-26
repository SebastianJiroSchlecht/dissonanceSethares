function d = dissonanceMeasureFromPartials(fvec,amp)
% Sethares, W. A. (1993). Local consonance and the relationship between timbre and scale.
% J. Acoust. Soc. Amer., 94(3), 1218–1228. http://doi.org/10.1121/1.408175

%
% given a set of partials in fvec,
% with amplitudes in amp,
% this routine calculates the dissonance
%

%% Constants
Dstar=0.24; S1=0.0207; S2=18.96; A1=-3.51; A2=-5.75;

%% Sort
fvec = fvec(:).';
amp = amp(:).';
[fvec,ind]=sort(fvec);
amp=amp(ind);

%% Compute
index = nchoose2(1:length(fvec));

f = fvec(index);
a = amp(index);
Fdif = f(:,2)-f(:,1);
Fmin = f(:,1);

S = Dstar./(S1*Fmin+S2);
Fdiss = exp(A1*S.*Fdif)-exp(A2*S.*Fdif);
A = a(:,1) .* a(:,2);
D = A .* Fdiss;
d = sum(D) / sqrt(sum(amp));
