%  +------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                |
%  | Function Name: mutation                                    |
%  | Function Purpose: apply the mutation operation             |
%  | Inputs: Input Genotype, Number of mutated bits,            | 
%  |         and Mutation Rate                                  |
%  | Output: Mutated Genotype                                   |
%  +------------------------------------------------------------+

function [genotype_out] = mutation(genotype_in,nbits,mrate)
%genotype_in is a decimal
%nbits: number of bits that will suffer mutation (1 or 2).
%mrate: integer [0,1000], where 1000 indicates "always mutate" and
% 0 "never mutates".
rng('shuffle');
%generate a random number 
%==========================
b_1 = de2bi(genotype_in);
%transforms the input genotype from decimal to binary vector
%==========================
s1 = size(b_1);
nsize = 22-s1(2);
z = zeros(1,nsize);
b_in = horzcat(z,b_1);
%obligates the genotype to have 22 positions (a project stipulation)
%==========================
a = 1;
b = 22;
r = randi([a b],1,2);
r_range = [min(r) max(r)];
%random mutation position generation, at the range [1,22]
%==========================
n1 = r(1,1);
n2 = r(1,2);
%The random positions (indexes)
%==========================
b_out = b_in;
%Genotype_out <= Genotype_in in every index
%==========================
a_mrate = 1;
b_mrate = 1000;
r_mrate = randi([a_mrate,b_mrate],1,1);
%Generates a random number to compare with the given mutation rate
%==========================
if (r_mrate < mrate)
    if(nbits == 1 | n1==n2)
        b_out(n1) = ~(b_in(n1));%when only one bit suffers mutation
    end 
    if(nbits == 2)
        if(n1 ~= n2) 
            b_out(n1) = ~(b_in(n1));
            b_out(n2) = ~(b_in(n2));%when two bits suffer mutation
        end
    end
end
genotype_out = binaryVectorToHex(b_out);
%exports an hexadecimal number as the Genotype_out
