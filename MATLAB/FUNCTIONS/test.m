clear all;
clc
n=10;
nbest=2;
tv=[0 1 1 0];
for i=1:n
for j=1:i
    g = genotype_generator(i);
    [f,ng]=vcr(g,tv);
    fitness(i)=f;
    ngates(i)=ng;
    genotype(i)=hex2dec(g);
    if((fitness(i)<fitness(j)) | (fitness(i)==fitness(j)) & (ngates(i)>ngates(j)))
      
end