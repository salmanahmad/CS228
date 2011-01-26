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

    %energies = zeros(segm_params.LK);

    c = GetPairwiseContrast(theImg,SPs,p1,p2);
    energies = (ones(segm_params.LK) - eye(segm_params.LK)) * potts_weight*exp(-contrast_lambda*c);
    
  
  %%%YOUR CODE HERE
   %for i=1:size(energies,1)
   %   for j=1:size(energies,2)
   %     if(i ~= j)
   %         c = GetPairwiseContrast(theImg,SPs,p1,p2);
   %         energies(i,j) = potts_weight*exp((0-contrast_lambda)*c);
   %     else
   %         energies(i,j) = 0;
   %     end
   %   end
   %end
 

  %%%END YOUR CODE
end
