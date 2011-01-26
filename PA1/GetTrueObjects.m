%GETTRUEOBJECTS returns the true objects in an image
%
% objects = GetTrueObjects(imgNum) reads in the true objects in imgNum
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


function [objects] = GetTrueObjects(imgNum)
if(~ischar(imgNum))
  imgNum = num2str(imgNum);
end
fid = fopen(['data/' imgNum '.objects.txt']);
line = fgetl(fid);
objects = [];
while(ischar(line))
  allFields = regexp(line,' ','split');
  subFields = cell(0);
  for i = 1:length(allFields)
      if(~strcmp(allFields{i},''))
         subFields{end+1} = allFields{i}; 
      end
  end
if(strcmp(subFields{1},'person')||strcmp(subFields{1},'car'))
  objects(end+1).type = subFields{1};
  objects(end).x = str2num(subFields{2});
  objects(end).y = str2num(subFields{3});
  objects(end).w = str2num(subFields{4});
  objects(end).h = str2num(subFields{5});
  objects(end).p = str2num(subFields{6});
  line = fgetl(fid);
else
  line = fgetl(fid);
end

end

fclose(fid);

end