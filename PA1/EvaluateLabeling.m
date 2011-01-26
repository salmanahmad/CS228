function [overallAcc regionACC confusion] = EvaluateLabeling(labels,gtFile,segm_params)
GT = load(gtFile);
GT = GT+1;
confusion = zeros(segm_params.LK);
for i = 1:segm_params.LK
   for j = 1:segm_params.LK
       confusion(i,j) = sum(sum(GT==i&labels==j));
   end
end

overallAcc = sum(sum(diag(confusion)))/sum(sum(confusion));
regionACC = diag(confusion./repmat(sum(confusion,2),1,size(confusion,2)));
