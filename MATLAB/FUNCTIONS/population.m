function [gbest,generations,fitvec,ngvec,eval] = population(npop,tv)
nmin = 10;
fitmax = 0;
count = 0;
generations = 0;
superou = 0;
for i = 1:npop
    count = count + 1;
    genotype = genotype_generator(i);
    [v,fitness,ngates] = evalfhex(genotype,tv);
    if(fitmax < fitness) | ((fitmax == fitness ) & (nmin>ngates))
        superou = superou + 1;
        fitmax = fitness;
        nmin = ngates;
        fitvec(superou) = fitmax;
        ngvec(superou) = nmin;
        gbest = genotype;
        generations(superou) = count;
        eval(superou)=v;
    end
end
load gong.mat;
sound(y);