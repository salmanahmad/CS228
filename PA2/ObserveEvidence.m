% OBSERVEEVIDENCE Modify factors given some evidence.
% F = OBSERVEEVIDENCE(F, E) sets all entries in the vector of factors, F,
% that are not consistent with the evidence, E, to zero. F is a vector of
% factors each a data structure with the following fields:
%     .var    Vector of variables in the factor, e.g. [1 2 3]
%     .dim    Vector of dimensions corresponding to .var, e.g. [2 2 2]
%     .val    Value table of size prod(.dim)
% E is an N-by-2 matrix consisting of variable/value pairs.   

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function F = ObserveEvidence(F, E)

% TO DO: could also do this by simply appending factors with 0/1 entries
% corresponding to the evidence.

% iterate through all evidence
for i = 1:size(E, 1),
    v = E(i, 1);
    x = E(i, 2);
    % check validity of evidence
    if (x == 0),
        warning(['evidence not set for variable ', int2str(v)]);
        continue;
    end;
    for j = 1:length(F),
        % does factor contain variable?
        indx = find(F(j).var == v);
        if (~isempty(indx)),
            % check validity of evidence
            if (x > F(j).dim(indx)),
                error(['invalid evidence, X_', int2str(v), ' = ', int2str(x)]);
            end;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % YOUR CODE HERE
            % Adjust the factor F(j) to account for observed evidence
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % set entries in F(j).val inconsistent with v == x to zero
            assignments = IndexToAssignment(1:prod(F(j).dim), F(j).dim);
            for k = 1:length(F(j).val),
                if (x ~= assignments(k,indx)),
                    F(j).val(k) = 0;
                end;
            end;

            %%%% end YOUR CODE HERE %%%%
            
            if (all(F(j).val == 0)),
                warning(['factor ', int2str(j), ' makes variable assignment impossible']);
            end;
        end;
    end;
end;

