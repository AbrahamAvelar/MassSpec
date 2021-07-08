function AllData = LoadMultipleHTMLmaldi(directorio)
% AllData = LoadMultipleHTMLmaldi(directorio)
% Acumula en AllData los 4 outputs de loadHtmlMaldi para todos los .csv que
% esten en el directorio input
cwd=pwd;
cd(directorio)
Archivos=dir('*.csv');
for i = 1:length(Archivos)
    i/length(Archivos)
    Archivo=Archivos(i).name;
    [HtmlData, MatrixScores, AllStrainNames, MatrixScoresRank] = loadHtmlMaldi(Archivo);
    AllData(i).filename=Archivo;
    AllData(i).Names=HtmlData;
    AllData(i).Scores=MatrixScores;
    AllData(i).MatrixScoresRank=MatrixScoresRank;
	AllData(i).AllStrainNames=AllStrainNames;
end
cd(cwd)
