%PA1_eval
initializeSEG;

imgNum = 4;  %default 4
%superpixel mode
SPnum = 0; %Set to 0 for just pixels, 1-4 for increasingly large superpixels
%potts factor weight
potts_lambda = .3; %default .1 was 0
%contrast weighting
contrast_lambda = 0; %default .0001 was 0
%user defined energy weighting
full_lambda = 0; %default 1
%object-superpixel edge weighting
object_weight = 0; %default .1
%weight for your object factor
new_object_weight = 0;

confusion = ComparisonFramework(imgNum,potts_lambda,contrast_lambda,full_lambda,...
  object_weight,new_object_weight,SPnum);


display('confusion matrix:');
display(confusion);
figure;
imagesc(confusion);
colormap('gray');
hold on;
title('Segmentation Confusion');
set(gca,'Xtick',1:8);
set(gca,'Ytick',1:8);
set(gca,'XtickLabel',segm_params.Labels);
set(gca,'YtickLabel',segm_params.Labels);
xlabel('Assigned Label');
ylabel('True Label');

