%POPULATESINGLETONENERGIES creates a list of singleton factor for the superpixels
%
% F_new = POPULATESINGLETONENERGIES(E,SPs,segm_params) creates a list of factors
%   F_new that can be used for mexFactorGraphInference.  E is the pixel-wise
%   class energies for the current image and SPs is the matrix where SPs(i,j)
%   is the superpixel label of pixel (i,j) in the current image.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [F_new] = PopulateSingletonEnergies(E,SPs,segm_params)
  num_factors = length(unique(SPs));
  Inds = unique(SPs);
  
  F_new = repmat(struct('vars', [], 'cards', segm_params.LK, 'data', []), num_factors, 1);
  
  
  for i = 1:num_factors
    F_new(i).vars = Inds(i);
    matches = find(SPs==i);
    Es = reshape(E,[size(E,1)*size(E,2) segm_params.LK]);
    F_new(i).data = -sum(Es(matches,:),1)/length(matches);
  end
end