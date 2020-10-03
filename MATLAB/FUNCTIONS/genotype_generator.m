%  +------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                |
%  | Function Name: genotype_generator                          |
%  | Function Purpose: generate a random vector of 22 positions |
%  | Input: index (n)                                 |
%  | Output: Genotype                                   |
%  +------------------------------------------------------------+

function [genotype] = genotype_generator(n)
rng('shuffle');
a = 0;
b = 4194303;%2^22-1
r = randi([a b],10000000,1);
r_range = [min(r) max(r)];
b1 = de2bi(r(n));
%gets the nth element of the random vector r, convert to decimal and
%atributes to b1
genotype = binaryVectorToHex(b1);
%exports the genotype as a binary vector 