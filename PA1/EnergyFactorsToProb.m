function [factors] = EnergyFactorsToProb(factors)
for i = 1:length(factors)
  factors(i).data = -reshape(factors(i).data,[1 prod(factors(i).cards)]);
  %factors(i).data = ConvertEnergyToProb(factors(i).data);
end
