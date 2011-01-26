function [F_new] = GetObjectSingletons(objects,prevInd)
  num_factors = length(objects);
  F_new = repmat(struct('vars', [], 'cards', 2, 'data', []), num_factors, 1);
  for i= 1:num_factors
    F_new(i).vars = i+prevInd;
    F_new(i).data = -[log(1-objects(i).p) log(objects(i).p)];
  end
end
