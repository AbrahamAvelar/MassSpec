function [HtmlData, MatrixScores, AllStrainNames, MatrixScoresRank] = loadHtmlMaldi(Archivo)
% [HtmlData, MatrixScores, AllStrainNames, MatrixScoresRank] = loadHtmlMaldi(Archivo) 
%
% Recibe un archivo .csv que se hizo desde los htmls del brucker maldi
% Yo los convertí con  https://www.convertcsv.com/html-table-to-csv.htm
% Abre con xlsread y también con csvimport. Usa los ‘Analyte Name:’ para
% irse bajando los HtmlData.Names y los NtmlData.Score de cada analito 
% del archivo. 
%
% También regresa otros tres outputs:
% AllStrainNames tiene todos los nombres que salieron como top-10 hit en
% al menos uno de los analitos. Están en el mismo orden que las siguientes
% dos matrices
% MatrixScores es una matriz que tiene numero de especies en un eje 
% y los analitos ordenados y en el otro eje con el valor del score 
% que que se asignó para cada especie-analito
% MatrixScoresRank tiene una matriz del mismo tamaño que MatrixScores
% pero en vez de guardar el valor del score guarda el rank del 1 al 10.

html24x=Archivo%
[numC, txtC,rawC]=xlsread(html24x);
firstwell=find(strcmp(txtC(:,2), 'A1'));

T=csvimport(Archivo); %esto fue necesario porque xlsread convierte los del pozo 11E4 en 11*10^4
an=find(strcmp(T(:,1), 'Analyte Name:'));

HtmlData(1).filename=Archivo;
tempMatrix=zeros(length(txtC),10);
con=0;
if contains(Archivo,'LevadurasMezcalerasCINVESTAV20210508CLM49B.csv')
    con; %Nada más para hacer degbugging
end
analytes=find(strcmp(txtC(:,1), 'Analyte Name:'));
numberofanalytes=size(analytes,1);
if (length(txtC)-firstwell+1)/17<numC(1,1) %(length(txtC)-firstwell+1)/17 < numC(1,1)
    HtmlData=[];
    MatrixScores=[];
    AllStrainNames=[] ;
    MatrixScoresRank=[];
    return
end
tam=firstwell:17:length(txtC);
for i = analytes'%firstwell:17:length(txtC) % Captura las 96 mediciones
    con=con+1;
    HtmlData(con).Names=txtC(i+7:i+16,2);
    if size(numC,2)>2 && size(numC,1)>i+3
        HtmlData(con).Score=numC(i+3:i+12,2);
    else
        HtmlData(con).Score=zeros(1,10);
    end
	for j=1:length(HtmlData(con).Names) % Hacer un diccionario con todas las especies presentes
        ThisSpecies=strrep(cell2mat(HtmlData(con).Names(j)), ' ', ''); %caracteres especiales que hay que quitar
        ThisSpecies=strrep(ThisSpecies, '(', '');
        ThisSpecies=strrep(ThisSpecies, ')', '');
        ThisSpecies=strrep(ThisSpecies, '[', '');
        ThisSpecies=strrep(ThisSpecies, ']', '');
        ThisSpecies=strrep(ThisSpecies, '+', '');
        ThisSpecies=strrep(ThisSpecies, '-', '');
        ThisSpecies=strrep(ThisSpecies, '_', '');
        ThisSpecies=strrep(ThisSpecies, '#', '');
        if ~isempty(ThisSpecies)
            SpeciesDictionary.(str2mat(ThisSpecies))=[];
        end
    end
    %HtmlData(con).AnalyteNames=txtC(i,2);
    %HtmlData(con).AnalyteNames=rawC(i,2);
    HtmlData(con).AnalyteNames=T(an(con),2);
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


