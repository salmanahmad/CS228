function [RESULT] = TestAdjacency(List,Adjacency)

CA = zeros(size(Adjacency));
for i = 1:length(List)
  CA(List{i}(1),List{i}(2))=1;
end
CA = CA+CA';
eq = sum(sum(CA==Adjacency));
RESULT = (eq==(prod(size(Adjacency))));
