classdef continuousOscillator < handle
    properties(Access = public)
      currentPhase = 0.;
      f0 = 100;
      numberOfPartials = 3;
      sampleRate = 48000;
      partialAmplitudeDecay = 1.0;
   end
   methods
      function audioOut = getSignal(obj,blockSize)
         cycle = linspace(0,2*pi,blockSize+1).';
         phase = obj.currentPhase + cycle * (blockSize/obj.sampleRate) * obj.f0;
         
         phases = phase(1:end-1) .* (1:obj.numberOfPartials);
         partialGains = obj.partialAmplitudeDecay.^(0:obj.numberOfPartials-1);
         
         audioOut = sum(sin(phases).*partialGains,2);
         obj.currentPhase = phase(end);
      end
   end
end