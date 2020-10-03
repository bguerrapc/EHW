%  +------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                |
%  | Function Name: selection                                    |
%  | Function Purpose:              |
%  | Inputs:                              |
%  | Outputs:                              |
%  +------------------------------------------------------------+

function [gout,gener,fitvec,ngvec] = selection(pgenerations,genmut,tv,mutrate,mutnb)
[gtype,generations,fitvec,ngvec] = population(pgenerations,tv);
l = size(fitvec);
gen = 0;
fitmax = fitvec(l);
nmin = ngvec(l);
count = 0;
superou = 0;
for i = 1:genmut
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
        gen(superou) = count;
        fitvec(l+superou) = fitmax;
        ngvec(l+superou) = nmin;
    end
end
gener = [generations,gen];
gout = dec2hex(gmutbest);