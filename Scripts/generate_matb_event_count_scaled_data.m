
clear all

load('../SharedDataExport/InputOutput_v5_5_3_16.mat');

Indicators = Data(:,[39,41,40,38,37,35,109:119]);

eventCountMATB = Indicators(:,14:17);

PhysioACommOwn = PhysioA(:,1:66) .* repmat(eventCountMATB(:,1), 1, 66);
PhysioBCommOwn = PhysioB(:,1:66) .* repmat(eventCountMATB(:,1), 1, 66);
PhysioCCommOwn = PhysioC(:,1:66) .* repmat(eventCountMATB(:,1), 1, 66);

PhysioACommOther = PhysioA(:,1:66) .* repmat(eventCountMATB(:,2), 1, 66);
PhysioBCommOther = PhysioB(:,1:66) .* repmat(eventCountMATB(:,2), 1, 66);
PhysioCCommOther = PhysioC(:,1:66) .* repmat(eventCountMATB(:,2), 1, 66);

PhysioAResMan = PhysioA(:,1:66) .* repmat(eventCountMATB(:,3), 1, 66);
PhysioBResMan = PhysioB(:,1:66) .* repmat(eventCountMATB(:,3), 1, 66);
PhysioCResMan = PhysioC(:,1:66) .* repmat(eventCountMATB(:,3), 1, 66);

PhysioATotal = PhysioA(:,1:66) .* repmat(eventCountMATB(:,4), 1, 66);
PhysioBTotal = PhysioB(:,1:66) .* repmat(eventCountMATB(:,4), 1, 66);
PhysioCTotal = PhysioC(:,1:66) .* repmat(eventCountMATB(:,4), 1, 66);

save('./Data/eventCountScaledPhysioData.m')