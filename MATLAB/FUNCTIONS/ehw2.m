%function [genotype,generation,fitness,ngates] = ehw2(npop,nmut,tv,mutrate,mutnb,n)
npop=500;
ng=4;
tv=[0 1 1 0];
mutrate=1000;
mutnb=2;
n=5;
sumgen=0;
sumfit=0;
sumng=0;
for i = 1:n
    i
    [A,B,C,D]=sel_termination(npop,ng,tv,mutrate,mutnb);
    l = size(D);
    sumgen=sumgen+B(l(2));
    sumfit=sumfit+C(l(2));
    sumng=sumng+D(l(2));
    g=hex2dec(A);
    gtype(i)=g;
    generation(i)=B(l(2));
    fitness(i)=C(l(2));
    ngates(i)=D(l(2));
    
end
medgen=sumgen/n
medfit=sumfit/n
medng=sumng/n
