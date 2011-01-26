%GETOBJECTSPFACTORS creates a list of factors between the objects and superpixels
%
% F_new = GetObjectSPFactors(objects,SPs,objStart,segm_params)
%   populates a list of factors 'F_new' with factors between the potential
%   object detections and superpixels
%   objects is the array of potential objects
%   SPs is a matrix of superpixel labels. SPs(i,j) gives the label for pixel (i,j)
%   objStart is the variable number of the first object in the full factor list
%   segm_param is the segmentation parameter data structure
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [F_new] = GetObjectSPFactors(objects,SPs,objStart,segm_params,weight,new_weight)
  if(~exist('weight','var'))
    weight = 1;
  end
  
  F_new = [];
  h = size(SPs,1);
  w = size(SPs,2);
  for i = 1:length(objects)
    xmin = max([1 floor(objects(i).x)]);
    ymin = max([1 floor(objects(i).y)]);
    xmax = min([xmin+ floor(objects(i).w) w]);
    ymax = min([ymin+floor(objects(i).h) h]);
    bb = [xmin xmax ymin ymax];
    
    overlappedSPs = unique(SPs(ymin:ymax,xmin:xmax));
    
    num_factors = length(overlappedSPs);
    lastO = length(F_new);
    F_new = [F_new; repmat(struct('vars', [], 'cards', [2 segm_params.LK], 'data', []), num_factors, 1)];
    for j = 1:length(overlappedSPs)
      %now create the factor over the object and SP
      F_new(lastO+j).vars = [objStart+i overlappedSPs(j)];
      F_new(lastO+j).data = CreateObjectSPEnergy(SPs,overlappedSPs(j),...
        bb,segm_params,weight);
    end
    
    %%%YOUR CODE HERE
    
    %use new_weight to weight your energies.
    
    %num_relations_you_add = ?
    %YOUR_SUPERPIXEL = ?
    %YOUR_ENERGY = ?
    %
    %
    %F_new = [F_new; repmat(struct('vars', [], 'cards', [2 segm_params.LK], 'data', []),...
    %  num_relations_you_add, 1)];
    %for each factor you want to add
    %  %now create the factor over the object and SP
    %  F_new(lastO+j).vars = [objStart+i YOUR_SUPERPIXEL];
    %  F_new(lastO+j).data = YOUR_ENERGY
    %end
    
    %%%END YOUR CODE
  end
end
