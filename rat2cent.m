function cents=rat2cent(ratios)
%
% convert ratios to cents
%
cents=1200/log10(2)*log10(ratios);