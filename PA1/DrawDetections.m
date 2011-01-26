%DRAWDETECTIONS draws the object detections for a given image
%
% DRAWDETECTIONS(objects,output,obStart,theImg,onlyTrue) draws rectangles around
%   detected objects in the image.  Red for no object and green for object detected
%   objects is our list of objects for this image
%   output is the result of PERFORMINFERENCE
%   obStart is the index of the first object in the factor list for PERFORMINFERENCE
%   theImg is the current RGB image matrix
%   onlyTrue indicates whether to only draw detected objects
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [] = DrawDetections(objects,output,obStart,theImg,onlyTrue)

if(~exist('onlyTrue','var'))
  onlyTrue = 0;
end
%imagesc(theImg);

for i = 1:length(objects)
  detected = output(obStart+i).value;
  if((onlyTrue~=1)&&(detected~=2))
    rectangle('Position',[objects(i).x objects(i).y objects(i).w objects(i).h],...
    'EdgeColor',[1 0 0]);
  end
  if((onlyTrue~=0)&&(detected==2))
    rectangle('Position',[objects(i).x objects(i).y objects(i).w objects(i).h],...
    'EdgeColor',[0 1 0]);
  end
end
