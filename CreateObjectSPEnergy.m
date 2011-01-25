%CREATEOBJECTSPENERGY returns an energy matrix between a superpixel and object
%
% energies = CREATEOBJECTSPENERGY(SPs,theSP,theObj,bb,weight) returns energy
%   matrix energies between object detection 'theObj' and superpixel 'theSP'
%   SPs is our matrix of superpixel labels so SP(i,j) is the label for pixel (i,j)
%   bb is the bounding box the object theObj
%   energies is a 2xNumClasses matrix where energies(1,i) is the energy for
%     theObj not being detected as an object and superpixel theSP having label i.
%     energies(2,i) is equivalent for theObj being a true object detection
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University  

function [energies] = CreateObjectSPEnergy(SPs,theSP,bb,segm_params,weight)
  %% %overlap
  if(~exist('weight','var'))
    weight = 1;
  end
  
  

  energies = zeros(2,8);
  
  %%% YOUR CODE HERE -- fill energy matrix

  
  %%% END YOUR CODE

end
