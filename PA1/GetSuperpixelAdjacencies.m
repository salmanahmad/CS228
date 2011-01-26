%GETSUPERPIXELADJACENCIES returns an adjacency matrix for the superpixels
%
%   adjacency = GETSUPERPIXELADJACENCIES(SPmat,direction) takes
%   a matrix 'SPmat' and infers which super pixels are adjacent
%   under a specified direction
%
%     adjacencies(i,j) is 1 if superpixels i and j border at all in
%     the image. 0 otherwise
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [adjacency] = GetSuperpixelAdjacencies(SPmat,direction)

pixelInds = unique(SPmat);
adjacency = zeros(length(pixelInds));


Left = SPmat(:,1:end-1);
Right = SPmat(:,2:end);
Above = SPmat(1:end-1,:);
Below = SPmat(2:end,:);

sideInds = find(Left~=Right);
vertInds = find(Above~=Below);

%Get left adjacencies
for i = 1:length(pixelInds)
  adjacency(i,Right(sideInds(Left(sideInds)==i)))=1;
  adjacency(Right(sideInds(Left(sideInds)==i)),i)=1;
end

for i = 1:length(pixelInds)
  adjacency(i,Above(vertInds(Below(vertInds)==i)))=1;
  adjacency(Above(vertInds(Below(vertInds)==i)),i)=1;
end

adjacency(adjacency>0)=1;
for i = 1:size(adjacency,1)
  adjacency(i,i) = 0;
end


