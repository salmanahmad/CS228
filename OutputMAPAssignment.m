%OUTPUTMAPASSIGNMENT takes the result of PERFORMINFERENCE and gets the
% corresponding MAP assignment
%
% Assignment = OUTPUTMAPASSIGNMENT(output,singleVals,SPs,seg_params)
%   returns the matrix Assignment where Assignment(i,j) is the MAP value of
%   pixel (i,j)
%   singleVals is a list of the indices of the singleton superpixel factors in
%     the factor list.  singleVals(i) gives the index for superpixel i's factor
%   SPs is the matrix of superpixel labels. SPs(i,j) is the superpixel number of
%     pixel (i,j)
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function Assignment = OutputMAPAssignment(output,singleVals,SPs,seg_params)
    Assignment = zeros(seg_params.img_dim);
    
    for i = 1:length(singleVals)
      Assignment(SPs==i) = output(singleVals(i)).value;
    end    
end