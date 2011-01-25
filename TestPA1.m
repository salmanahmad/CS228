%%%Load test stuff
load('TestValsMat.mat');
THRESH = 1e-10;

Points = 0;
adjacency = GetSuperpixelAdjacencies(SPs);
[List] = GetAdjacencyList(SPs);
Result = TestAdjacency(List,adjacency);
Points = ExecuteTest('GetAdjacencyList',Result,2,Points);

%%Test that potts factor creation works
PottsBase = GetPottsFactor(.3,segm_params);
Result = ((sum(sum(PottsBase==TestPotts)))==prod(size(PottsBase)));
Points = ExecuteTest('GetPottsFactor',Result,2,Points);

 
%%Test that contrast weighting is working
CEnergyBase = GetContrastFactor(.3,.1,1,2,...
  theImg,SPs,segm_params);
Result = ((sum(sum(CEnergyBase==CEnergyTest)))==prod(size(PottsBase)));
Points = ExecuteTest('GetContrastFactor',Result,3,Points);


ObEnergiesBase = CreateObjectSPEnergy(SPs,theSP,bb,segm_params,.5);
Result = (sum(sum(ObEnergiesBase==ObEnergiesTest))==prod(size(ObEnergiesTest)));
Points = ExecuteTest('ObjectEnergies',Result,3,Points);

display(['Scored ' num2str(Points) ' out of 10 possible']);
