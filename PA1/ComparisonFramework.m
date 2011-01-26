%%%General testing framework
function [confusion] = ComparisonFramework(iNum,potts_lambda,contrast_lambda,...
  full_lambda,object_weight,new_ob_weight,SPnum)
initializeSEG;

imgNums = cell(0);
imgNums{1} = '0000047';
imgNums{end+1} = '0005468'; %<--- 2% improvement w/contrast model
imgNums{end+1} = '0100061'; %<---terrible
imgNums{end+1} = '0000697'; %<---pretty good (potts and contrast)
imgNums{end+1} = '0000759'; %<---improve w/contrast model
imgNums{end+1} = '0004498';

%%%%VALUES TO BE DEFINED
%Define weights
%potts_lambda = .05;
%.01 and .0001 (.00005) for SPs
%contrast_lambda = .0005;
%full_lambda = 2;
%Specify 0-4, 0 indicating pixels, larger numbers indicating larger superpixels
if(object_weight>0)
  useObjects=1;
else
  useObjects = 0;
end
%%%%%END VALUES TO BE DEFINED

imgNum = imgNums{iNum};
theImg = imread(['data/' imgNum '.jpg']);
segm_params.img_dim(1) = size(theImg,1);
segm_params.img_dim(2) = size(theImg,2);
GT = LoadGT(imgNum);

subplot(3,3,1);
imagesc(theImg);
title('Base image');
trueObjects = GetTrueObjects(imgNum);
obArray = [];
for i=1:length(trueObjects)
    obArray(i).value = 2;
    obArray(i).var = i;
end
DrawDetections(trueObjects,obArray,0,theImg,1);

subplot(3,3,2);
SPs = GetSuperpixels(imgNum,SPnum,segm_params);
imagesc(SPs);
title('Superpixels');

subplot(3,3,3);
GTImg = VisualizeSegLabeling(GT,segm_params);
imagesc(GTImg);
title('Ground Truth');

%%Load energies, objects, and adjacencies
adjacency = GetSuperpixelAdjacencies(SPs,'All');
E = LoadSingletonEnergies(['data/' imgNum '.txt'],segm_params.img_dim);
objects = GetObjects(imgNum);

%%%Do just singletons
single_factors = PopulateSingletonEnergies(E,SPs,segm_params);
singleVals = 1:length(single_factors);
factors = [single_factors];
output = PerformInference(factors);
Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
resImg = VisualizeSegLabeling(Assign,segm_params);
subplot(3,3,4);
imagesc(resImg);
for i = 1:8
for j = 1:8
match(i,j) = sum(sum((GT==i)&(Assign==j)));
end
end
cur_acc = sum(sum(diag(match)))/sum(sum(match));
title(['Single: ' num2str(cur_acc)]);

%%%Do potts
if(potts_lambda>0)
    weights = [potts_lambda 0 0];
    potts_factors = CreatePairwiseFactors(theImg,adjacency,SPs,segm_params,weights);
    factors = [single_factors; potts_factors];
    obStart = length(factors);
    output = PerformInference(factors);
    Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
    resImg = VisualizeSegLabeling(Assign,segm_params);
    subplot(3,3,5);
    imagesc(resImg);
    for i = 1:8
    for j = 1:8
    match(i,j) = sum(sum((GT==i)&(Assign==j)));
    end
    end
    cur_acc = sum(sum(diag(match)))/sum(sum(match));
    title(['Potts: ' num2str(cur_acc)]);
end


%%%Do contrast
if(contrast_lambda>0)
    weights = [potts_lambda contrast_lambda 0];
    pair_factors = CreatePairwiseFactors(theImg,adjacency,SPs,segm_params,weights);
    factors = [single_factors; pair_factors];
    obStart = length(factors);
    output = PerformInference(factors);
    Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
    resImg = VisualizeSegLabeling(Assign,segm_params);
    subplot(3,3,6);
    imagesc(resImg);
    for i = 1:8
    for j = 1:8
    match(i,j) = sum(sum((GT==i)&(Assign==j)));
    end
    end
    cur_acc = sum(sum(diag(match)))/sum(sum(match));
    title(['Contrast: ' num2str(cur_acc)]);
end


%%%Do full
if(full_lambda>0)
    weights = [potts_lambda contrast_lambda full_lambda];
    pair_factors = CreatePairwiseFactors(theImg,adjacency,SPs,segm_params,weights);
    factors = [single_factors; pair_factors];
    obStart = length(factors);
    output = PerformInference(factors);
    Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
    resImg = VisualizeSegLabeling(Assign,segm_params);
    subplot(3,3,7);
    imagesc(resImg);
    for i = 1:8
    for j = 1:8
    match(i,j) = sum(sum((GT==i)&(Assign==j)));
    end
    end
    cur_acc = sum(sum(diag(match)))/sum(sum(match));
    title(['Full: ' num2str(cur_acc)]);
end

if(1==2)%useObjects==1)
%%%Object singletons
weights = [potts_lambda contrast_lambda full_lambda];
pair_factors = CreatePairwiseFactors(theImg,adjacency,SPs,segm_params,weights);
factors = [single_factors; pair_factors];
obStart = length(factors);
obj_factors = GetObjectSingletons(objects,length(single_factors));
factors = [factors; obj_factors];
output = PerformInference(factors);
Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
resImg = VisualizeSegLabeling(Assign,segm_params);
subplot(3,3,8);
imagesc(resImg);
trueObjects = GetTrueObjects(imgNum);
DrawDetections(objects,output,obStart,theImg,1);
display('-----------------------');
display('Object Singletons Only');
display('-----------------------');
EvaluateDetections(objects,trueObjects,output,obStart)
for i = 1:8
for j = 1:8
match(i,j) = sum(sum((GT==i)&(Assign==j)));
end
end
cur_acc = sum(sum(diag(match)))/sum(sum(match));
title(['Obj singles: ' num2str(cur_acc)]);
end

if(useObjects==1)
%%%Object full
weights = [potts_lambda contrast_lambda full_lambda];
pair_factors = CreatePairwiseFactors(theImg,adjacency,SPs,segm_params,weights);
factors = [single_factors; pair_factors];
obStart = length(factors);
obj_factors = GetObjectSingletons(objects,length(single_factors));
ob_sp_factors = GetObjectSPFactors(objects,SPs,length(unique(SPs)),segm_params,...
  object_weight,new_ob_weight);
factors = [factors; obj_factors; ob_sp_factors];
output = PerformInference(factors);
Assign = OutputMAPAssignment(output,singleVals,SPs,segm_params);
resImg = VisualizeSegLabeling(Assign,segm_params);
subplot(3,3,9);
imagesc(resImg);

DrawDetections(objects,output,obStart,theImg,1);
display('-----------------------');
display('Object-Superpixel interactions included');
display('-----------------------');
EvaluateDetections(objects,trueObjects,output,obStart)
for i = 1:8
for j = 1:8
match(i,j) = sum(sum((GT==i)&(Assign==j)));
end
end
cur_acc = sum(sum(diag(match)))/sum(sum(match));
title(['All: ' num2str(cur_acc)]);
end
confusion = match;

