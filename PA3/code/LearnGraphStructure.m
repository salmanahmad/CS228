% CS228 PA3 Winter 2011
% File: LearnGraphStructure.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function [A W] = LearnGraphStructure(dataset, visualize)

% Compute weight matrix W
W = zeros(10,10);

N = size(dataset,1);

%for i=1:10
%    dataset(:,i,3) = AdjustAngleRange(dataset(:,i,3), 'auto');
%end

for i=1:10

    for j=i+1:10

        W(i,j) = rand(1,1);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        % YOUR CODE HERE
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
end

% make it symmetric
W = W+W';

% Compute maximum spanning tree
A = MaxSpanningTree(W);

% Visualize the learned graph
if visualize
    figure
    DrawGraph(A);
end


