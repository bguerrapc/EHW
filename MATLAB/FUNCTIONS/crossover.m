%  +----------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                    |
%  | Function Name: crossover                                       |
%  | Function Purpose: Combines two genotypes and delivers the best |
%  | out of 6 children of them.                                     |
%  | Inputs: 2 genotypes, ref(truth table)                          |
%  | Outputs: 1 genotype, its evaluation, the random position, and  | 
%  | the position it happens in the children's vector               |
%  +----------------------------------------------------------------+
function [best_child,eval,r,pos] = crossover(genotype_dad,genotype_mom,ref)
rng('shuffle');
a = 1;
b = 21;
r = randi([a,b],1,1);
%============================
dad = dec2hex(genotype_dad);
dad = hexToBinaryVector(dad);
s2 = size(dad);
nsize2 = 22-s2(2);
r2 = zeros(1,nsize2);
gen_dad = horzcat(r2,dad);
gen_dad1 = gen_dad;
gen_dad1(1:r-1)=[];
gen_dad2 = gen_dad;
gen_dad2(r:22)=[];
%=============================
mom = dec2hex(genotype_mom);
mom = hexToBinaryVector(mom);
s3 = size(mom);
nsize3 = 22-s3(2);
r3 = zeros(1,nsize3);
gen_mom = horzcat(r3,mom);
gen_mom1 = gen_mom;
gen_mom1(1:r-1)=[];
gen_mom2 = gen_mom;
gen_mom2(r:22)=[];
%=============================
c1 = [gen_dad1,gen_mom2];
child(1)  = bin2dec(num2str(c1));
c(1) = evalfdec(child(1),ref);
c2 = [gen_mom2,gen_dad1];
child(2)  = bin2dec(num2str(c2));
c(2) = evalfdec(child(2),ref);
c3 = [gen_dad2,gen_mom1];
child(3)  = bin2dec(num2str(c3));
c(3) = evalfdec(child(3),ref);
c4 = [gen_mom1,gen_dad2];
child(4)  = bin2dec(num2str(c4));
c(4) = evalfdec(child(4),ref);
%crossover children
child(5) = genotype_dad;
c(5) = evalfdec(child(5),ref);
child(6) = genotype_mom;
c(6) = evalfdec(child(6),ref);
%the parents
[max_num, max_idx] = max(c(:));
[X]=ind2sub(size(c),find(c==max_num));
child(X);
best_child = child(X);
%best_child = binaryVectorToDecimal(child(X))
eval = c(X);
pos = X(1);
%if the pos (position) is less than 5, it means that the crossover
%operation was able to find a child fitter than or as fit as the best parent. 