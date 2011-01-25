%APPLYCONTRASTWEIGHT updates an energies matrix by the contrast weight.
%
% energies = APPLYCONTRASTWEIGHT(energies,weight,p1,p2,theImg,SPs) multiplies
%   energies by the appropriate contrast weight and returns.
%   energies is our precontrast energies.
%   weight is the weight to use in our contrast exponent.
%   p1 and p2 are the labels of the superpixels to get contrast between.
%   theImg is an image matrix for our current image
%   SPs is the superpixel labeling of the image so SP(i,j) is the superpixel
%     of which pixel (i,j) is a member
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [energies] = ApplyContrastWeight(energies,lambda,p1,p2,theImg,SPs)
  curContrast = GetPairwiseContrast(theImg,SPs,p1,p2);
  
  %%%YOUR CODE HERE
  energies = energies*exp(-lambda*curContrast);
  %%%END YOUR CODE
end
