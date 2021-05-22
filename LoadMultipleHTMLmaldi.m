function AllData = LoadMultipleHTMLmaldi(directorio)
cwd=pwd;
cd(directorio)
Archivos=dir('*.csv');
for i = 1:length(Archivos)
    i/length(Archivos)
    Archivo=Archivos(i).name;
    [HtmlData, MatrixScores, AllStrainNames, MatrixScoresRank] = loadTophit(Archivo);
    AllData(i).filename=Archivo;
    AllData(i).Names=HtmlData;
    AllData(i).Scores=MatrixScores;
end
cd(cwd)
