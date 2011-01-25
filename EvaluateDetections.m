%EVALUATEDETECTIONS draws the object detections for a given image
%
% EVALUATEDETECTIONS(objects,trueObjects,output,obStart) draws rectangles around
%   detected objects in the image.  Red for no object and green for object detected
%   objects is our list of objects for this image
%   trueObjects is our list of objects actually in the image
%   output is the result of PERFORMINFERENCE
%   obStart is the index of the first object in the factor list for
%   PERFORMINFERENCE
%   numMissed is the number of true objects missed
%   numMatched is the number of true objects that are matched
%   numRepeated is the number of detections that are repeats of already
%   detected objects
%   numFalse is the number of false detections
%
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [numMatched numMissed numRepeated numFalse] = EvaluateDetections(objects,trueObjects,output,obStart)

if(~exist('onlyTrue','var'))
  onlyTrue = 0;
end
%imagesc(theImg);
detObjects = [];
for i = 1:length(objects)
  if(output(obStart+i).value==2)
     detObjects(end+1).x = objects(i).x;
     detObjects(end).y = objects(i).y;
     detObjects(end).h = objects(i).h;
     detObjects(end).w = objects(i).w;
     detObjects(end).type = objects(i).type;
  end
end
numRepeated = 0;
numFalse = 0;
matched = zeros(1,length(trueObjects));
for i = 1:length(detObjects)
   matchedTrue = [];
   for j = 1:length(trueObjects)
       ob1Mat = [];
       ob2Mat = [];
      if(strcmp(trueObjects(j).type,detObjects(i).type))
          ob1Mat(max([1 round(trueObjects(j).y)]):round(trueObjects(j).h+trueObjects(j).y),...
              max([1 round(trueObjects(j).x)]):round(trueObjects(j).w+trueObjects(j).x))=1;
          ob2Mat(max([1 round(detObjects(i).y)]):round(detObjects(i).h+detObjects(i).y),...
              max([1 round(detObjects(i).x)]):round(detObjects(i).w+detObjects(i).x))=1;
          if(size(ob1Mat,1)>size(ob2Mat,1))
              ob2Mat(size(ob1Mat,1),1) = 0;
          end
          if(size(ob1Mat,2)>size(ob2Mat,2))
              ob2Mat(1,size(ob1Mat,2)) = 0;
          end
          if(size(ob2Mat,1)>size(ob1Mat,1))
              ob1Mat(size(ob2Mat,1),1) = 0;
          end
          if(size(ob2Mat,2)>size(ob1Mat,2))
              ob1Mat(1,size(ob2Mat,2)) = 0;
          end
          numMatch = sum(sum(ob1Mat==1&ob2Mat==1));
          num1 = sum(sum(ob1Mat));
          num2 = sum(sum(ob2Mat));
          if((numMatch>.3*num1)&&(numMatch>.3*num2))
             matchedTrue(end+1) = j; 
          end
      end
      if(length(matchedTrue)==0)
         numFalse = numFalse+1; 
      end
      for k = 1:length(matchedTrue)
         if(matched(matchedTrue(k))==1)
             continue;
         else
            matched(matchedTrue(k))=1; 
         end
         if(j==length(matchedTrue))
             numRepeated = numRepeated+1;
         end
      end
   end
end

numMatched = sum(matched);
numMissed = length(matched)-numMatched;
display(['Total number of true objects in image: ' num2str(length(trueObjects)) '']);
display(['Number of objects accurately detected: ' num2str(numMatched) '']);
display(['Number of objects not detected/missed: ' num2str(numMissed) '']);
display(['Number of redundant detections: ' num2str(numRepeated) '']);
display(['Number of false detections: ' num2str(numFalse) '']);

end
