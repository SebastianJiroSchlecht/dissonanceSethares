function ratios=cent2rat(cents)
%
% convert cents to ratios
%
ratios=10.^((log10(2)/1200)*cents);
