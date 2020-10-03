function [genotype,generation,fitness,ngates] = ehw(npop,nmut,tv,mutrate,mutnb,n)
fileID = fopen('D:\Downloads\MyFile.txt','w');
sumgen=0;
sumfit=0;
sumng=0;
for i = 1:n
    i
    [A,B,C,D]=selection(npop,nmut,tv,mutrate,mutnb);
    l = size(D);
    fprintf(fileID,'%s',A);
    fprintf(fileID,'\n');
    sumgen=sumgen+B(l(2));
    sumfit=sumfit+C(l(2));
    sumng=sumng+D(l(2));
    for j = 1:l(2)
        fprintf(fileID,' %d',B(j));
    end
    fprintf(fileID,'\n');
    for j = 1:l(2)
        fprintf(fileID,' %d',C(j));
    end
    fprintf(fileID,'\n');
    for j = 1:l(2)
       fprintf(fileID,' %d',D(j));
    end
    fprintf(fileID,'\n');
end
fclose(fileID);
medgen=sumgen/n
medfit=sumfit/n
medng=sumng/n
