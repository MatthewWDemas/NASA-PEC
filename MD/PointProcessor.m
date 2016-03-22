function [ PtLoc1, PtLoc2,  TAdjust] = PointProcessor( TrainS, S, j, Data, Fs)
%PointProcessor calculates the timing errors encountered while syncing
%multiple HP and physio data files.
%   INPUT: PtLoc1, PtLoc2, TAdjust
%---------- Data Preprocess -------------------
[PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(TrainS{S,j+1},Data(:,27),Fs);
%------ Validation ----------------------------
ErrorT(S,j)=ErrorI;
LocationsT(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
[~,TLoc]=findpeaks(Data(:,35));
if ~isempty(TLoc)
    TAdjust(S,j)=(TLoc(1)-PtLoc1)/256;
else
    TAdjust(S,j)=nan;
end

end

