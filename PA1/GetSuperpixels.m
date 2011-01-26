%GETSUPERPIXELS Returns a superpixel labeling for an image
%
%   SPs = GETSUPERPIXELS(imgNum,type) returns a matrix
%   SPs such that SPs(i,j) is the superpixel to which pixel
%   (i,j) is assigned in image imgNum. Type specifies what
%   superpixel labeling to use.
%   
%   type = 0 indicates use of small rectangular superpixels
%   type = 1 through 4 indicates use of prepcomputed superpixels
%     increasing in sizes as the type number increases
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University


function SPs = GetSuperpixels(imgNum,type,segm_params)

theImg = imread(['data/' imgNum '.jpg']);

if(~exist('type','var')||type==0)
  SPs = GranularSuperpixel(segm_params,[2 2]);
  SPs = SPs(1:size(theImg,1),1:size(theImg,2));
end
if(type==1)
  SPs = load(['data/' imgNum '.S7.R6.seg.int']);
end
if(type==2)
  SPs = load(['data/' imgNum '.S11.R6.seg.int']);
end
if(type==3)
  SPs = load(['data/' imgNum '.S19.R6.seg.int']);
end
if(type==4)
  SPs = load(['data/' imgNum '.S31.R6.seg.int']);
end
SPs = SPs+1;
