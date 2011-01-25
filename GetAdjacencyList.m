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
  %spLabels is a list of all the superpixel labels
  spLabels = unique(SPs);
  
  %%%YOUR CODE HERE

  %%%


end
