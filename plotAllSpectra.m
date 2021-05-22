function plotAllSpectra(MZ,YN1,filenames, separation)
figure()
for i=1:size(YN1,2)
    plot( MZ, separation*i+YN1(:,i) );
    hold on
end
set(gca, "ytick", 1*separation:separation:size(YN1,2)*separation+1, 'yticklabel', (filenames))
xlim([2000 20000])
ylim([0 1+size(YN1,2)*(separation)])