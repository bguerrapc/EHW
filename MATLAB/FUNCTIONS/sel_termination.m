function [gout,gener,fitvec,ngvec] = sel_termination(pgenerations,ngmin,tv,mutrate,mutnb)
[gtype,generations,fitvec,ngvec] = population(pgenerations,tv);
l = size(fitvec);
gout=0;
gen = 0;
fitmax = fitvec(l);
nmin = ngvec(l);
count = 0;
superou = 0;
while (fitmax<4 | (fitmax == 4 & nmin>ngmin))
    count = count + 1;
    g = hex2dec(gtype);
    genotype = mutation(g,mutnb,mutrate);
    gmutbest = g;
    [fitness,ngates] = vcr(genotype,tv);
    if((fitmax < fitness ) | ((fitmax==fitness)&(nmin>ngates)))
        superou = superou + 1;
        fitmax = fitness;
        nmin = ngates;
        gmutbest = genotype;
        gout = dec2hex(gmutbest);
        gen(superou) = count;
        fitvec(l+superou) = fitmax;
        ngvec(l+superou) = nmin;
    end
end
gener = [generations,gen];
