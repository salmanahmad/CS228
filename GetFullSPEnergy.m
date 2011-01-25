%GETFULLSPENERGY returns a full energy matrix 
%
%
% energies = GETFULLSPENERGY(weight,segm_params) returns a segm_params.LK by
% segm_params.LK matrix with user defined energies.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function [energies] = GetFullSPEnergy(sp1,sp2,SPs,weight,segm_params)

%%Define the base energies
energies = zeros(segm_params.LK);

%%%YOUR CODE HERE

%%sky energies
energies(1,[]) = 1;
%%tree energies
energies(2,[]) = 1;
%%road energies
energies(3,[]) = 1;
%%grass energies
energies(4,[]) = 1;
%%water energies
energies(5,[]) = 1;
%%building energies
energies(6,[]) = 1;
%%mountain energies
energies(7,[]) = 1;
%%foreground energies
energies(8,[])= 1;

%%%END YOUR CODE


n1above = sum((SPs(1:end-1,:)==sp1)&(SPs(2:end,:)==sp2));
n1below = sum((SPs(1:end-1,:)==sp2)&(SPs(2:end,:)==sp1));

if(n1above>=n1below)
  energies = energies*weight;
else
  energies = energies'*weight;  
end


