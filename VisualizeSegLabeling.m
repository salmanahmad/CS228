%VISUALIZESEGLABELING returns an image of a given segmentation labeling
%
% img = VISUALIZESEGLABELING(labels,segm_params)
%   img is the RGB image for the given labeling 'labels'
%   segm_params.LC(l,:) is the rgb value for label l
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [img] = VisualizeSegLabeling(labels,segm_params)
    img = zeros([size(labels) 3]);
    for l = 1:segm_params.LK
        for d = 1:3
        IL1 = reshape(img(:,:,d),[size(img,1) size(img,2)]);
        IL1(labels==l) = segm_params.LC(l,d);
        img(:,:,d) = reshape(IL1,[size(img,1) size(img,2) 1]);
        end
    end
    img = uint8(img);

end