function [HtmlData, MatrixScores, AllStrainNames, MatrixScoresRank] = loadHtmlMaldi(Archivo) %"C:\Users\jabra\Downloads\LevadurasMezcalerasCINVESTAV20210509Extraccionesselec45B-52B.csv";
html24x=Archivo%
[numC, txtC]=xlsread(html24x);
firstwell=find(strcmp(txtC(:,2), 'A1'));

HtmlData(1).filename=Archivo;
tempMatrix=zeros(length(txtC),10);
con=0;
if contains(Archivo,'LevadurasMezcalerasCINVESTAV20210508CLM49B')
    con; %Nada más para hacer degbugging
end

if (length(txtC)-firstwell+1)/17 < numC(1,1)
    HtmlData=[];
    MatrixScores=[];
    AllStrainNames=[] ;
    MatrixScoresRank=[];
    return
end

for i= firstwell:17:length(txtC) % Captura las 96 mediciones
    con=con+1;
    HtmlData(con).Names=txtC(i+7:i+16,2);
    if size(numC,2)>2
        HtmlData(con).Score=numC(firstwell+3:firstwell+12,2);
    else
        HtmlData(con).Score=zeros(1,10);
    end
	for j=1:length(HtmlData(con).Names) % Hacer un diccionario con todas las especies presentes
        ThisSpecies=strrep(cell2mat(HtmlData(con).Names(j)), ' ', '');
        ThisSpecies=strrep(ThisSpecies, '(', '');
        ThisSpecies=strrep(ThisSpecies, ')', '');
        ThisSpecies=strrep(ThisSpecies, '[', '');
        ThisSpecies=strrep(ThisSpecies, ']', '');
        if ~isempty(ThisSpecies)
            SpeciesDictionary.(str2mat(ThisSpecies))=[];
        end
    end
end

AllStrainNames=fieldnames(SpeciesDictionary);
for i= 1:length(HtmlData) %
    for j = 1:length(1:length(HtmlData(i).Names))
        ThisSpecies=strrep(cell2mat(HtmlData(i).Names(j)), ' ', '');
        x=find(strcmp(AllStrainNames, ThisSpecies));
        MatrixScores(x,i)=HtmlData(i).Score(j);
        MatrixScoresRank(x,i)=j;
    end
end


