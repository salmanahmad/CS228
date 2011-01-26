%GRANULARSUPERPIXEL returns a granular superpixel labeling of an image
%
%   SP = GranularSuperpixel(segm_params,SPdim) creates
%   a matrix SP where SP(i,j) is the superpixel that
%   pixel (i,j) in the image belongs to for a rectangular
%   superpixel labeling of the image.  SPdim specifies
%   the size of superpixels to be used with SPdim(1) = height
%   and SPdim(2) = width
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [SP] = GranularSuperpixel(segm_params,SPdim)
SP = zeros(segm_params.img_dim);
SPnum = 0;
for i = 1:SPdim(1):segm_params.img_dim(1)
  for j = 1:SPdim(2):segm_params.img_dim(2)
  SP(i:i+SPdim(1)-1,j:j+SPdim(2)-1)=SPnum;
  SPnum = SPnum+1;
  end
end
