%GETSPOBJECTRELATION returns the relation between a superpixel and a bounding box
%
%
%
% [coverage distance angle] = GETOBJECTSUPERPIXELRELATION(SPs,sp,bb)
%   SPs is the matrix of superpixel labelings, with SPs(i,j) = superpixel of pixel (i,j)
%   sp is our superpixel of interest
%   bb is our current bounding box
%
%   COVERAGE indicates the fracton of sp within the bounding box bb.
%   DISTANCE gives the distance between the centroids of the superpixel and object
%   ANGLE gives the centroid angle (in radians) between sp and bb.  If sp is directly
%   below bb, ANGLE is pi/2.  If sp is directly left, ANGLE is 0.

function [coverage distance angle] = GetObjectSPRelation(SPs,sp,bb)
  coverage = CalculateObjectCoverage(SPs,theSP,bb);
  cent2 = [(bb(1)+bb(3))/2 (bb(2)+bb(4))/2];
  [is js] = find(SPs==sp);
  cent1 = [sum(is)/length(is) sum(js)/length(js)];
  
  distance = sqrt(sum((cent1-cent2).^2));
  if(cent1(1)>cent2(1))
    angle = pi+atan((cent2(2)-cent1(2))/(cent2(1)-cent1(1)));
  else
    angle = atan((cent2(2)-cent1(2))/(cent2(1)-cent1(1)));
  end
  
end
