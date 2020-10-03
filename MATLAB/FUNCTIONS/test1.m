clear all;
clc
n=10;
nbest=2;
bestf=zeros(1,nbest);
bestng=63*ones(1,nbest);
bestpos=zeros(1,nbest)
tv=[0 1 1 0];
for j=1:nbest
for i=1:n
    g = genotype_generator(i);
    [f,ng]=vcr(g,tv);
    fitness(i)=f;
    ngates(i)=ng;
    genotype(i)=hex2dec(g);
    if(((fitness(i) > bestf(j))) | ((fitness(i)==bestf(j)) & (ngates(i) < bestng(j))))
      bestf(j)=fitness(i);
      bestng(j)=ngates(i);
      bestpos(j)=i;
    end
end