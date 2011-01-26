%PIXELTOINDEX Convert pixel coordinates to variable index.
%
%   I = PIXELTOINDEX(i,j,D) converts raw matrix coordinates i,j for an
%   image with dimensions D into the corresponding variable index
%
% CS228 Structured Probabilistic Models (Winter 2010)
% Copyright (C) 2009, Stanford University

function I = PixelToVar(i,j, D)

if(~exist('D','var'))
    D = [240 320];
end

I = (i-1)*D(2)+j;
end