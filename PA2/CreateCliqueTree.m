% Har be dragons
function C = CreateCliqueTree(V, D, F)

C.nodes = {};
E = zeros(length(V));
for i = 1:length(F)
    for j = 1:length(F(i).var)
        for k = 1:length(F(i).var)
            E(F(i).var(j), F(i).var(k)) = 1;
        end
    end
end

cliqueOrder = [];

while length(cliqueOrder) < length(V)-1
    % length(cliqueOrder)
    bestClique = 0;
    bestScore = inf;
    for i=1:size(E,1)
        score = sum(E(i,:));
        if score > 0 && score < bestScore
            bestScore = score;
            bestClique = i;
        end
    end
    
    cliqueOrder = [cliqueOrder bestClique];
    [F, C, E] = EliminateVar(F, C, E, bestClique);
end


% Prune tree
toRemove = [];
for i=1:length(C.nodes)
    % i
    for j=i+1:length(C.nodes)
        if i==j, continue, end;
        if ismember(i,toRemove) || ismember(j,toRemove), continue, end;
        if length(intersect(C.nodes{i},C.nodes{j})) == length(C.nodes{i})
            fprintf([num2str(i) ' ' num2str(j) '\n']);
            neighbors = find(C.edges(i,:));
            for k=1:length(neighbors)
                nk = neighbors(k);
                if length(intersect(C.nodes{i},C.nodes{nk})) == ...
                        length(C.nodes{i})
                    C.edges(setdiff(neighbors,[nk]),nk) = 1;
                    C.edges(nk,setdiff(neighbors,[nk])) = 1;
                    C.edges(i,:) = 0;
                    C.edges(:,i) = 0;
                    break;
                end
            end
            toRemove = [i toRemove];
        end
    end
end

toKeep = setdiff(1:length(C.nodes),toRemove);
for i=1:length(toRemove)
    C.nodes(toRemove(i)) = [];
end
if isfield(C, 'edges')
    C.edges = C.edges(toKeep,toKeep);
else
    C.edges = [];
end

C.names = V;
C.dim = D;
