%FINDREADY Find a pair of cliques ready for message passing
%   [i, j] = FINDREADY(T, messages) finds ready cliques in a given
%   clique tree, T, and current messages. Returns indices i and j
%   such that clique i is ready to transmit a message to clique j.
%   If no such cliques exist, returns i = j = 0
%
%   See also CLIQUETREECALIBRATE

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function [i, j] = FindReady(T, messages);

ready = 0;
for i = 1:size(T.edges, 1),
    for j = 1:size(T.edges, 2),
        if (T.edges(i, j) == 0), continue; end;
        if (~isempty(messages(i, j).var)), continue; end;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % YOUR CODE HERE
        % If clique i is ready to send a message to clique j then
        % set 'ready' to 1.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        ready = 1;
        
        for k = 1:size(T.edges, 1)
            if (T.edges(k, i) ~= 0)
                if(isempty(messages(k, i).var))
                    ready = 0;
                    break;
                end
            end
        end
        
        
        if (ready == 1),
            return;
        end;
    end;
end;

i = 0;
j = 0;

return;
