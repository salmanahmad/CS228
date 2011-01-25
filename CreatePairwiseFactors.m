%CREATEPAIRWISEFACTORS creates a list of all appropriate pairwisefactor for an image
%
% F_new = CREATEPAIRWISEFACTORS(theimage,adjacency,SPs,segm_params,weights)
%   returns a list of pairwise factors F_new populated with variable names,
%   energies, and dimension for use with factor graph inference.
%   theImage should be a HxWx3 image matrix 
%   adjacency is the matrix of adjacencies to be used 
%   SPs is an HxW matrix where SPs(i,j) is the superpixel label for pixel (i,j)
%   segm_params is our parameters for segmentation
%   weights is a matrix of the weights to be used for these pairwise factors
%     weights(1) = weight for potts factor
%     weights(2) = weight for contrast term
%     weights(3) = weight for full energy matrix
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University


function [F_new] = CreatePairwiseFactors(theImage,adjacency,SPs,segm_params,weights)
    
    SPpairs = GetAdjacencyList(SPs);
    
    num_factors = length(SPpairs);
    F_new = repmat(struct('vars', [], 'cards', ones(1,2)*segm_params.LK, 'data', []), num_factors, 1);
    
    for i = 1:length(SPpairs)
    F_new(i).vars = SPpairs{i};
      if(weights(2)==0)
        F_new(i).data = GetPottsFactor(weights(1),segm_params);
      else
        F_new(i).data = GetContrastFactor(weights(1),weights(2),SPpairs{i}(1),...
          SPpairs{i}(2),theImage,SPs,segm_params);
      end
      if(weights(3)>0)
        F_new(i).data = F_new(i).data+GetFullSPEnergy(SPpairs{i}(1),SPpairs{i}(2),SPs,weights(3),segm_params);
      end
    end
    
   
    
end