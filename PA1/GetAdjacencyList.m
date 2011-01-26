%GETADJACENCYLIST
%
% [FirstVars SecondVars] = GetAdjacencyList(adjacency)
% Takes a superpixel matrix and returns two lists of
% variable indices.  For an index i, FirstVars(i) gives
% the first variable of the ith pairwise factor and
% SecondVars(i) should be the second variable.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [pairs] = GetAdjacencyList(SPs)
  pairs = cell(0);
  
  %pairs = {[], []};
  %spLabels is a list of all the superpixel labels
  %spLabels = unique(SPs);
  
  counter = 1;
  
  adjacency = GetSuperpixelAdjacencies(SPs);
  for i=1:size(adjacency, 1)
      for j=i:size(adjacency, 2)
        if(adjacency(i,j) == 1)
           pairs{counter} = [i,j];
           counter = counter + 1;
        end
      end
    end
 
end
