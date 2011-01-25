%LOADSINGLETONENERGIES loads singleton energies from precomputed pixel model
%
%   E = LOADSINGLETONENERGIES(fileLoc,dimension)
%   loads the singleton energies for an image from
%   the output file in fileLoc and populates
%   an energy matrix Es with size H x W x C.
%   C is the number of classes, H is image heigh, and W is width.
%
%   Es(i,j,c) is the energy for pixel i,j
%   assigned to class c.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2011, Stanford University

function Es = LoadSingletonEnergies(fileLoc,dimension)

%Dimension converted to [Width Height] form
dimension = dimension(2:-1:1);
allEnergies = load(fileLoc);
allEnergies(:,9) = allEnergies(:,9)*2;
Es = reshape(allEnergies(:,2:9),[dimension 8]);
Es = permute(Es,[2 1 3]);
end