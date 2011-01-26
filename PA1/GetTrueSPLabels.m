function [trueLabeling] = GetTrueSPLabels(SPs,GT,segm_params)
nums = unique(SPs);
trueLabeling = zeros(1,length(nums));
for i = 1:length(nums)
  %go through labels and check number matching.
  maxMatched = 0;
  numPossible = sum(sum(SPs==i));
  numLeft = numPossible;
  for j = 1:segm_params.LK
    numMatch = sum(sum(GT(SPs==i)==j));
    numLeft = numLeft-numMatch;
    if(numMatch>maxMatched)
      maxMatched = numMatch;
      trueLabeling(i)=j;
    end
    %early escape condition
    if(numLeft<=maxMatched)
      break;
    end
  end
end


