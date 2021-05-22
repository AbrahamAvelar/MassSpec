function [Samples, filenames] = readMassSpec(directorio)
cwd = pwd;
cd(directorio);
files = dir('*.csv')

for i=1:length(files)
    Samples(:,i) = importdata(files(i).name)
    filenames{i}=strrep(files(i).name, '_', '-' )
end
cd(cwd)
