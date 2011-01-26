%GETPAIRWISECONTRAST finds the contrast of two superpixels
%
% contrast = GetPairwiseContrast(img,SPs,p1,p2) returns the contrast of the
%   average over superpixels p1 and p2.
%   img is the HxWx3 RGB image matrix for our current image
%   SPs is the superpixel matrix such that SPs(i,j) gives the superpixel number
%     for pixel (i,j)
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [contrast] = GetPairwiseContrast(img,SPs,p1,p2)

Limg = reshape(img,[size(img,1)*size(img,2) 3]);
Inds1 = find(SPs==p1);
Inds2 = find(SPs==p2);
C1 = sum(Limg(Inds1,:),1)/length(Inds1);
C2 = sum(Limg(Inds2,:),1)/length(Inds2);

contrast = sum((C1-C2).^2);
