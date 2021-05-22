function [IntensityMatrix, BaseIntMat, AlignedSpectra, MZ] = BaseLineAndAlign(Samples, Peaks)
TOF=1;
MASS=2;
INTENSITY=3;
MZ=Samples(1).data(:,MASS);

for i=1:length(Samples)
    IntensityMatrix(:,i) = Samples(i).data(:,INTENSITY); % Poner todas las intensidades en una sola matriz
    y=IntensityMatrix(:,i);
    BaseIntMat(:,i) = msbackadj(MZ,y,'WINDOWSIZE',500,'QUANTILE',0.20,'SHOWPLOT',2); % Baseline
end

% Align
figure()
msheatmap(MZ, BaseIntMat)
title('BeforeAlignment')
AlignedSpectra = msalign(MZ,BaseIntMat,Peaks);
msheatmap(MZ,AlignedSpectra,'MARKERS',Peaks)
title('AfterAlignment')
