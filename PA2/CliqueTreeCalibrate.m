%CLIQUETREECALIBRATE Sum product algorithm for clique tree calibration.
%   P = CLIQUETREECALIBRATE(T, F) calibrates a given clique tree, T, and set
%   of factors, F. The function returns the final potentials for each clique. 
%   The clique tree data structure has the following fields:
%       .names  Cell array containing the names of each variable [M]
%       .dim    Vector containing dimensionality of each variable [M]
%       .nodes  Cell array of variables in each clique [N]
%       .edges  Adjacency graph for clique tree [N-by-N]
%
%   See also FACTORPRODUCT, FACTORMARGINALIZATION

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function [P, MESSAGES] = CliqueTreeCalibrate(T, F);

% number of cliques
N = length(T.nodes);

% compute assignment of factors to cliques
alpha = zeros(length(F), 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Assign each factor to a clique
% alpha(i) should contain the index of the clique that factor i
% belongs to
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(F),
    for j = 1:length(T.nodes),
        if (all(ismember(F(i).var, cell2mat(T.nodes(j))))),
            alpha(i) = j;
        end;
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (any(alpha == 0)),
    warning('clique tree does not have family preserving property');
end;

% initialize cliques potentials and messages
P = repmat(struct('var', [], 'dim', [], 'val', []), N, 1);
for i = 1:N,
    P(i).var = T.nodes{i};
    P(i).dim = T.dim(P(i).var);
    P(i).val = ones(1,prod(P(i).dim));
end;

MESSAGES = repmat(struct('var', [], 'dim', [], 'val', []), N, N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Populate P with the initial potentials for each clique
% P(i) should contain the initial potential for clique i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(F)
    P(alpha(i)) = FactorProduct(P(alpha(i)), F(i));
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lasti = 0; lastj = 0;
% perform clique tree calibration
num_edges = length(find(T.edges));
iter = 0;
while (1), % while ready cliques exist
    [i, j] = FindReady(T, MESSAGES); 
    if ((i == 0) || (j == 0)), break; end;
    if ((i == lasti) && (j == lastj)), break; end;
    lasti = i; lastj = j;

    iter = iter + 1;
    % disp([num2str(iter), ' of ', num2str(num_edges), ' messages passed']);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    % Clique i is ready to send a message to clique j, so compute
    % this message and put it in messages(i,j)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    delta_ij = P(i);
    
    for k = 1:length(P)
        if (T.edges(k,i) == 0), continue; end;
        if (j == k), continue; end;
        delta_ij = FactorProduct(delta_ij,MESSAGES(k,i));
    end;
    
    varsToElim = setdiff(P(i).var,P(j).var);
    MESSAGES(i,j) = FactorMarginalization(delta_ij,varsToElim);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Compute final potentials and place them in P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j = 1:size(MESSAGES, 1),
    for i = 1:size(MESSAGES, 2),
        if (T.edges(i, j) == 0), continue; end;
        P(j) = FactorProduct(P(j), MESSAGES(i,j));
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

