%VIEWGRAPH Visualize Bayesian Network and Cluster Graphs.
%   VIEWGRAPH(G, jpgName, dotName) produces a visualization of the
%   graph G.
%
%   G must contain the following fields:
%       .names      Variable names.
%       .nodes      Clique (node) definitions.
%       .edges      Adjacency graph of directed edges.
%
%   jpgName and dotName (optional) are the file names to write the
%   resulting jpeg and graph definition file, respectively. Their
%   default values are /tmp/graph.jpg and /tmp/graph.dot,
%   respectively.
%
%   This function uses the external application "dot".

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function ViewGraph(G, jpgName, dotName);

if ~exist('jpgName')
    jpgName = '/tmp/graph.jpg';
end

if ~exist('dotName')
    dotName = '/tmp/graph.dot';
end

% constants
GRAPHEXE = '/afs/ir.stanford.edu/class/cs228/ProgrammingAssignments/bin/dot -Tjpg';

% check valid graph
N = length(G.nodes);
if (size(G.edges, 1) ~= N) || (size(G.edges, 2) ~= N),
    error('invalid graph structure');
end;

undirected = all(all(G.edges == G.edges'));

% create dot file
fid = fopen(dotName, 'w');
if (undirected),
    fprintf(fid, 'graph cs228 {');
    for i = 1:N,
        for j = i + 1:N,
            if (G.edges(i,j) == 1),
                fprintf(fid, '  %s -- %s;\n', ...
                    CliqueName(G, i), CliqueName(G, j));
            end;
        end;
    end;

else
    fprintf(fid, 'digraph cs228 {');
    for i = 1:N,
        for j = 1:N,
            if (G.edges(i,j) == 1),
                fprintf(fid, '  %s -> %s;\n', ...
                    CliqueName(G, i), CliqueName(G, j));
            end;
        end;
    end;
end;

fprintf(fid, '}');
fclose(fid);

% create graph
delete(jpgName);
system([GRAPHEXE, ' ', dotName, ' >', jpgName]);

% show graph
figure;
img = imread(jpgName);
image(img);
axis off;

% CliqueName --------------------------------------------------------
function n = CliqueName(G, i)

n = G.names{G.nodes{i}(1)};
for k = 2:length(G.nodes{i}),
    n = [n, ', ', G.names{G.nodes{i}(k)}];
end;
n = ['"', n, '"'];

return;
