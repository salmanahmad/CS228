function [GT] = LoadGT(imgNum)
if(~ischar(imgNum(1)))
  imgNum = num2str(imgNum);
end
GT = load(['data/' imgNum '.regions.txt']);
GT = GT+1;

end
