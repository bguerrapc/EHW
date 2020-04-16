%  +----------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                    |
%  | Function Name: ovcr (optimized VRC)                                            |
%  | Function Purpose: represent the combinational circuit testbench|
%  | Inputs: Genotype, Number of Input Bits, Truth table (ref), security code              |
%  | Output: Fitness value, Number of logic gates                   |
%  +----------------------------------------------------------------+
function [fitness,ngates] = ovrc(genotype,nbits,ref,code)
gen_in = genotype;
tt = ref;
I0 = [0 1 0 1];
I1 = [0 0 1 1];
%L1 - First Layer
if(gen_in(9)~= code(9))
    J0 = "I0";
    p0 = I0;
    ng0 = 0;
elseif(gen_in(9)== code(9))
    J0 = "NOT I0";
    p0 = ~I0;
    ng0 = 1;
end
if(gen_in(8)~= code(8))
    J1 = "I1";
    p1 = I1;
    ng1 = 0;
elseif(gen_in(8)== code(8))
    J1 = "NOT I1";
    p1 = ~I1;
    ng1 = 1;

end 
%op2 - Operator 1 and 2 of Layer 2
if(gen_in(7) ~= code(7) )
    L21 = strcat("( ",J0," ) OR ( ",J1, " )");
    L22 =  strcat("( ",J0," ) AND ( ",J1, " )");
    L2Op1 = p0 | p1;
    L2Op2 = p0 & p1;
    ngop21 = ng0+ng1+1;
    ngop22 = ng0+ng1+1;
elseif (gen_in(7) == code(7))
    L21 = J0;
    L22 =  J1;
    L2Op1 = p0;
    L2Op2 = p1;
    ngop21 = ng0;
    ngop22 = ng1;
end

if (gen_in(6) ~= code(6) & gen_in(5) ~= code(5) & gen_in(4) ~= code(4))
    L2 = strcat("( ",L21," ) OR ( ",L22, " )");
    L2Op = L2Op1 | L2Op2;
    ngop2 = ngop21+ngop22+1;    
elseif (gen_in(6) ~= code(6) & gen_in(5) ~= code(5) & gen_in(4) == code(4))
    L2 = strcat("( NOT (",L21," )) OR ( ",L22, " )");
    L2Op = ~L2Op1 | L2Op2;
    ngop2 = ngop21+ngop22+2;  
elseif (gen_in(6) ~= code(6) & gen_in(5) == code(5) & gen_in(4) ~= code(4))
    L2 = strcat("( ",L21," ) OR ( NOT(",L22, " ))");
    L2Op = L2Op1 | ~L2Op2;
    ngop2 = ngop21+ngop22+2;    
elseif (gen_in(6) ~= code(6) & gen_in(5) == code(5) & gen_in(4) == code(4))
    L2 = strcat("( NOT (",L21," )) OR ( NOT ( ",L22, " ))");
    L2Op = ~L2Op1 | ~L2Op2;
    ngop2 = ngop21+ngop22+3;
elseif (gen_in(6) == code(6) & gen_in(5) ~= code(5) & gen_in(4) ~= code(4))
    L2 = strcat("( ",L21," ) AND ( ",L22, " )");
    L2Op = L2Op1 & L2Op2;
    ngop2 = ngop21+ngop22+1;    
elseif (gen_in(6) == code(6) & gen_in(5) ~= code(5) & gen_in(4) == code(4))
    L2 = strcat("( NOT (",L21," )) AND ( ",L22, " )");
    L2Op = ~L2Op1 & L2Op2;
    ngop2 = ngop21+ngop22+2;  
elseif (gen_in(6) == code(6) & gen_in(5) == code(5) & gen_in(4) ~= code(4))
    L2 = strcat("( ",L21," ) AND ( NOT(",L22, " ))");
    L2Op = L2Op1 & ~L2Op2;
    ngop2 = ngop21+ngop22+2;    
elseif (gen_in(6) == code(6) & gen_in(5) == code(5) & gen_in(4) == code(4))
    L2 = strcat("( NOT (",L21," )) AND ( NOT ( ",L22, " ))");
    L2Op = ~L2Op1 & ~L2Op2;
    ngop2 = ngop21+ngop22+3;  
end 
%

%op3 - Operator 1 of Layer 3
if (gen_in(3) ~= code(3) & gen_in(2) ~= code(2) & gen_in(1) ~= code(1))
    op3 = " 0 ";
    Operation3 = zeros(1,nbits);
    ngop3 = 0;
elseif(gen_in(3) ~= code(3) & gen_in(2) ~= code(2) & gen_in(1) == code(1))
    op3 = " 1 ";
    Operation3 = ones(1,nbits);
    ngop3 = 0;
    cop3=1;
elseif(gen_in(3) ~= code(3) & gen_in(2) == code(2) & gen_in(1) ~= code(1))
    op3 = L21;
    Operation3 = L2Op1;
    ngop3 = ngop21;
elseif(gen_in(3) ~= code(3) & gen_in(2) == code(2) & gen_in(1) == code(1))
    op3 = L22;
    Operation3 = L2Op2;
    ngop3 = ngop22;
    cop3=3;
elseif (gen_in(3) == code(3) & gen_in(2) ~= code(2) & gen_in(1) ~= code(1))
    op3 = L2;
    Operation3 = L2Op;
    ngop3 = ngop2;
elseif(gen_in(3) == code(3) & gen_in(2) ~= code(2) & gen_in(1) == code(1))
    op3 = strcat("NOT (",L2,")");
    Operation3 = ~L2Op
    ngop3 = ngop2 + 1;
elseif(gen_in(3) == code(3) & gen_in(2) == code(2) & gen_in(1) ~= code(1))
    op3 = strcat("NOT (",L21,")");;
    Operation3 = ~L2Op1;
    ngop3 = ngop21 + 1;
elseif(gen_in(3) == code(3) & gen_in(2) == code(2) & gen_in(1) == code(1))
    op3 = strcat("NOT (",L22,")");
    Operation3 = ~L2Op2;
    ngop3 = ngop22 + 1;
end


fprintf('The boolean equation is: %s\n\n',op3)
g=sprintf('%d ', Operation3);
fprintf('The phenotype is: %s\n\n', g)
fit = 0;
for i=1:nbits
    if(tt(i) == Operation3(i))
        fit=fit+1;
    end
end
% fprintf('The fitness is: %d\n\n', fitness)
% fprintf('The number of logic gates used is: %d\n\n', ngop3)
fitness=fit;
ngates=ngop3;
