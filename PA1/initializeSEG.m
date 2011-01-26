%Initialize environment for image detection

addpath('SVL');
segm_params.img_dim = [213 320];
segm_params.LK = 8;                 %cardinality of segmentation variable
                                    %as we have 8 classes
segm_params.factors = [];
segm_params.Labels = {'sky','tree','road','grass','water','building',...
    'mountain','foreground'};
segm_params.ST = [0 2 1 1 1 2 2 2];
segm_params.LN = 1:8;
segm_params.LC = [128 128 128; 128 128 0; 128 64 128; 0 128 0;...
                    0 0 128; 128 0 0; 128 50 0; 255 128 0];