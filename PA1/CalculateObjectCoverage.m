%FINDOBJECTCOVERAGE
%
% coverage = CALCULATEOBJECTCOVERAGE(SPs,theSP,bb)
%   calculates what ratio of the given superpixel (theSP) is within bounding
%   box bb as compared to the total size of bb.
%   SPs is our matrix of superpixel labels so SP(i,j) is the label for pixel (i,j)
%   bb has format [topleft_x bottomright_y topleft_y bottomright_y]
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University  

function [coverage] = CalculateObjectCoverage(SPs,theSP,bb)
  coverage = 1;

  totalSize = sum(sum(SPs==theSP));
  numInside = sum(sum(SPs(bb(3):bb(4),bb(1):bb(2))==theSP));
  coverage = numInside/totalSize;
  
  
end
