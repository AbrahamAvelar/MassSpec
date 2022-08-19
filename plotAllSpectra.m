function plotAllSpectra(MZ,YN1,filenames, separation, rgb, grupos)
if nargin<5
    rgb=[1 1 1];
    grupos = 0;
end
if grupos > 0
    for i=1:grupos:size(YN1,2)
        for j= 0:grupos-1
            plot( MZ, separation*i+YN1(:,i+j), 'color', rgb);
            maximo=max(separation*i+YN1(:,i+j))+separation;
            hold on
        end
    end
    set(gca, "ytick", 1*separation:separation*grupos:size(YN1,2)*separation+1, 'yticklabel', (filenames(1:grupos:end)))
else
    for i=1:size(YN1,2)
        i
        plot( MZ, separation*i+YN1(:,i), 'color', rgb);
        maximo=max(separation*i+YN1(:,i))+separation;
        hold on
    end
    set(gca, "ytick", 1*separation:separation:size(YN1,2)*separation+1, 'yticklabel', (filenames(1:end)))

end
%xlim([2000 20000])
%ylim([0 max(separation*i+YN1(:,i))+separation]) %1+size(YN1,2)*(separation+2)
1+size(YN1,2)*(separation);
separation;
box off
end
