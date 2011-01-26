%GETSUPERPIXELRELATION returns the distance relation between two superpixels
%
%
% [adjacent distance angle] = GETSUPERPIXELRELATION(SPs,sp1,sp2)
%   SPs is the matrix of superpixel labelings, with SPs(i,j) = superpixel of pixel (i,j)
%   sp1 and sp2 denote which superpixels we are evaluating
%
%   ADJACENT indicates whether the two superpixels are adjacent. 1 if so, 0 if not
%   DISTANCE gives the distance between the two superpixels' centroids
%   ANGLE gives the centroid angle (in radians) from sp1 to sp2.  If sp1 is directly
%   below sp2, ANGLE is pi/2.  If sp1 is directly left, ANGLE is 0.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [adjacent distance angle] = GetSuperpixelRelation(SPs,sp1,sp2)
adjacent = 0;
if(sum(sum(SPs(1:end-1,:)==sp1&SPs(2:end,:)==sp2))>0)
  adjacent = 1;
end
if(sum(sum(SPs(1:end-1,:)==sp2&SPs(2:end,:)==sp1))>0)
  adjacent = 1;
end
if(sum(sum(SPs(:,1:end-1)==sp1&SPs(:,2:end)==sp2))>0)
  adjacent = 1;
end
if(sum(sum(SPs(:,1:end-1)==sp2&SPs(:,2:end)==sp1))>0)
  adjacent = 1;
end

[is js] = find(SPs==sp1);
cent1 = [sum(is)/length(is) sum(js)/length(js)];
[is js] = find(SPs==sp2);
cent2 = [sum(is)/length(is) sum(js)/length(js)];

distance = sqrt(sum((cent1-cent2).^2));

if(cent1(1)>cent2(1))
  angle = pi+atan((cent2(2)-cent1(2))/(cent2(1)-cent1(1)));
else
  angle = atan((cent2(2)-cent1(2))/(cent2(1)-cent1(1)));
end
