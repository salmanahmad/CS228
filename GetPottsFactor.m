%GETPOTTSFACTOR returns a square Potts energy matrix
%
% energies = GETPOTTSFACTOR(weight,segm_params) returns a segm_params.LK by
% segm_params.LK matrix with potts energies.  Thus, we have energies(i,j) with
% value 0 wherever the two labels would be same and weight otherwise.
% 
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University


function [energies] = GetPottsFactor(weight,segm_params)
  energies = zeros(segm_params.LK);
  
  %%%YOUR CODE HERE
  

  
  %%%END YOUR CODE
end
