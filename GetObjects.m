%GETOBJECTS returns the objects detected in an image
%
% objects = GetObjects(imgNum) reads in the objects detected in imgNum
%   objects is an array of these detected objects
%   objects(i).type = type of object i
%   objects(i).x = x coordinate of upper left corner of object i
%   objects(i).y = y coordinate of upper left corner of object i
%   objects(i).h = heigh of object i
%   objects(i).w = width of object i
%   objects(i).p = probability from independent object detector
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University


function [objects] = GetObjects(imgNum)
if(~ischar(imgNum))
  imgNum = num2str(imgNum);
end
fid = fopen('data/ccm2008Detections1.xml');
line = fgetl(fid);
while(ischar(line)&&isempty(regexp(line,imgNum)))
  line = fgetl(fid);
end
line = fgetl(fid);
%%now we are at the appropriate line, so let's get those objects!
objects = [];
while(ischar(line)&&isempty(regexp(line,'Object2dFrame')))
  subFields = regexp(line,'"','split');
if(strcmp(subFields{2},'person')||strcmp(subFields{2},'car'))
  objects(end+1).type = subFields{2};
  objects(end).x = str2num(subFields{4});
  objects(end).y = str2num(subFields{6});
  objects(end).w = str2num(subFields{8});
  objects(end).h = str2num(subFields{10});
  objects(end).p = str2num(subFields{12});
  line = fgetl(fid);
else
  line = fgetl(fid);
end

end

fclose(fid);

end

