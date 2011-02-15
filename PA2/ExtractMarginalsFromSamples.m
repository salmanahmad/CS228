%EXTRACTMARGINALSFROMSAMPLES
%
%   ExtractMarginalsFromSamples takes in a probabilistic network G, a list of samples, and a set
%   of indices into samples that specify which samples to use in the computation of the
%   marginals.  The marginals are then computed using this subset of samples and returned.

function M = ExtractMarginalsFromSamples(G, samples, collection_indx)

collected_samples = samples(collection_indx, :);

M = repmat(struct('var', 0, 'dim', 0, 'val', []), length(G.names), 1);
for i = 1:length(G.names)
    M(i).var = i;
    M(i).dim = G.dim(i);
    M(i).val = zeros(1, G.dim(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Populate M so that M(i) contains the marginal probability over
% variable i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
