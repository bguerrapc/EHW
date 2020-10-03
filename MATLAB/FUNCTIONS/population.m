function [gbest,generations,fitvec,ngvec] = population(npop,tv)
nmin = 10;
fitmax = 0;
count = 0;
generations = 0;
superou = 0;
for i = 1:npop
    count = count + 1;
    genotype = genotype_generator(i);
    [fitness,ngates] = vcr(genotype,tv);
    if(fitmax < fitness) | ((fitmax == fitness ) & (nmin>ngates))
        superou = superou + 1;
        fitmax = fitness;
        nmin = ngates;
        fitvec(superou) = fitmax;
        ngvec(superou) = nmin;
        gbest = genotype;
        generations(superou) = count;
    end
end