%GetContrastFactor updates an energies matrix by the contrast weight.
%
% energies = GetContrastFactor(potts_weight,contrast_lambda,p1,p2,...
%                                   theImg,SPs) multiplies
%   energies by the appropriate contrast weight and returns.
%   energies is our precontrast energies.
%   weight is the weight to use in our contrast exponent.
%   p1 and p2 are the labels of the superpixels to get contrast between.
%   theImg is an image matrix for our current image
%   SPs is the superpixel labeling of the image so SP(i,j) is the superpixel
%     of which pixel (i,j) is a member
%   segm_params is our segmentation parameter datastructure.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [energies] = GetContrastFactor(potts_weight,contrast_lambda,p1,p2,...
  theImg,SPs,segm_params)

  energies = zeros(segm_params.LK);
  
  %%%YOUR CODE HERE

  %%%END YOUR CODE
end
