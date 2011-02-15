% Takes in variables, variable dimensions, and factors. Returns a Bethe cluster graph
function C = CreateClusterGraph(V, D, F)
assert(length(V) == length(D));

C.nodes = {};
C.edges = zeros(length(F) * 2);

% Single variable clusters
for i = 1:length(V)
    C.nodes{i} = i;
    % C.factorInds{i} = [];
end

% Bethe Factor clusters
C.factorToCluster = zeros(1, length(F));
for i = 1:length(F)
    if length(F(i).var) > 1
        newC = length(C.nodes) + 1;
        C.nodes{newC} = F(i).var;
        % C.factorInds{newC} = i;
        C.factorToCluster(i) = newC;
        
        for j = 1:length(F(i).var)
            C.edges(F(i).var(j),newC) = 1;
            C.edges(newC,F(i).var(j)) = 1;
        end
    else 
        C.factorToCluster(i) = i;
    end
end

% % Larger Factor clusters
% C.factorToCluster = zeros(1, length(F));
% num_factors_per_clique = 1;
% for k = 1:ceil(length(F) / num_factors_per_clique)
%     i = [];
%     doSingleton = true;
%     for n = 1:num_factors_per_clique
%         i_this = num_factors_per_clique * (k - 1) + n;

%         if i_this > length(F), break, end;
%         if length(F(i_this).var) > 1, doSingleton = false; end;
%         i = [i, i_this];
%     end

%     if doSingleton
%         for j = 1:length(i)
%             C.factorToCluster(i(j)) = i(j);
%         end
%     else
%         newC = length(C.nodes) + 1;
%         cluster_vars = [];
%         for j = 1:length(i)
%             cluster_vars = union(cluster_vars, F(i(j)).var);
%             C.factorToCluster(i(j)) = newC;
%         end
%         C.nodes{newC} = cluster_vars;
        
%         for j = 1:length(cluster_vars)
%             v = cluster_vars(j);
%             C.edges(v, newC) = 1;
%             C.edges(newC, v) = 1;
%         end
%     end

%     % if length(F(i1).var) > 1 || length(F(i2).var) > 1
%     %     newC = length(C.nodes) + 1;
%     %     C.nodes{newC} = union(F(i1).var, F(i2).var);
%     %     % C.factorInds{newC} = [i1, i2];
%     %     C.factorToCluster(i1) = newC;
%     %     C.factorToCluster(i2) = newC;        
%     %     node_vars = C.nodes{newC};
%     %     for j = 1:length(node_vars)
%     %         v = node_vars(j);
%     %         C.edges(v, newC) = 1;
%     %         C.edges(newC, v) = 1;
%     %     end
%     % else 
%     %     C.factorToCluster(i1) = i1;
%     %     C.factorToCluster(i2) = i2;
%     % end
% end

C.edges = C.edges(1:length(C.nodes),1:length(C.nodes));
C.names = V;
C.dim = D;
