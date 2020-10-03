%  +----------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                    |
%  | Function Name: savrc (optimized VRC)                                            |
%  | Function Purpose: represent the combinational circuit testbench|
%  | Inputs: Genotype, Truth table (ref), security code              |
%  | Output: Phenotype                |
%  +----------------------------------------------------------------+
function [phenotype,evalue,equation] = savrc(I0,I1,genotype,ref,code,eq1,eq2)
gen_in = genotype;
tt = ref;


if (gen_in(1) ~= code(1) & gen_in(2) ~= code(2) & gen_in(3) ~= code(3) & gen_in(4) ~= code(4))
%0
    equation = "0";
    %0
    op = [0 0 0 0];
    ngates = 0; 
elseif (gen_in(1) ~= code(1) & gen_in(2) ~= code(2) & gen_in(3) ~= code(3) & gen_in(4) == code(4))
%1
    equation = strcat("( ",eq1," ) AND ( ",eq2, " )");
    %I0 AND I1
    op = I0&I1;
    ngates = 1; 
elseif (gen_in(1) ~= code(1) & gen_in(2) ~= code(2) & gen_in(3) == code(3) & gen_in(4) ~= code(4))
%2
    equation = strcat("( ",eq2," ) AND NOT( ",eq1, " )");
    %I1 AND NOT I0
    op = I1&~I0;
    ngates = 2; 
elseif (gen_in(1) ~= code(1) & gen_in(2) ~= code(2) & gen_in(3) == code(3) & gen_in(4) == code(4))
%3
    equation = eq2;
    %I1
    op = I1;
    ngates = 0; 
elseif (gen_in(1) ~= code(1) & gen_in(2) == code(2) & gen_in(3) ~= code(3) & gen_in(4) ~= code(4))
%4
    equation = strcat("( ",eq1," ) AND NOT( ",eq2, " )");
    %I0 AND NOT I1
    op =  I0 & (~I1);
    ngates = 2; 
elseif (gen_in(1) ~= code(1) & gen_in(2) == code(2) & gen_in(3) ~= code(3) & gen_in(4) == code(4))
%5
    equation = eq1;
    %I0
    op = I0;
    ngates = 0; 
elseif (gen_in(1) ~= code(1) & gen_in(2) == code(2) & gen_in(3) == code(3) & gen_in(4) ~= code(4))
%6
    equation = strcat("(( ",eq1," ) OR ( ",eq2, " ))", "AND NOT (",eq1," AND ",eq2," )");
    %(I0 OR I1) AND NOT (I0 AND I1);
    op = (I0|I1)&~(I0&I1);
    ngates = 4;
elseif (gen_in(1) ~= code(1) & gen_in(2) == code(2) & gen_in(3) == code(3) & gen_in(4) == code(4))
%7
    equation = strcat("( ",eq1," ) OR ( ",eq2, " )");
    %I0 OR I1;
    op = I0|I1;
    ngates = 2; 
elseif (gen_in(1) == code(1) & gen_in(2) ~= code(2) & gen_in(3) ~= code(3) & gen_in(4) ~= code(4))
%8
    equation = strcat("NOT ( ",eq1," ) OR ( ",eq2, " )");
    %NOT (I0 OR I1);
    op = ~(I0|I1);
    ngates = 2;  
elseif (gen_in(1) == code(1) & gen_in(2) ~= code(2) & gen_in(3) ~= code(3) & gen_in(4) == code(4))
%9
    equation = strcat("(NOT (",eq1," ) AND NOT (",eq2, " ))","OR ( (",eq1,") AND ( ",eq2, "))");
    %(NOT I0 AND NOT I1) OR (I0 AND I1);
    op = (~I0&~I1)|(I0&I1);
    ngates = 5;
elseif (gen_in(1) == code(1) & gen_in(2) ~= code(2) & gen_in(3) == code(3) & gen_in(4) ~= code(4))
%10
    equation = strcat("( NOT ( ",eq1," ))");
    %NOT I0;
    op = ~I0;
    ngates = 1;   
elseif (gen_in(1) == code(1) & gen_in(2) ~= code(2) & gen_in(3) == code(3) & gen_in(4) == code(4))
%11
    equation = strcat("( NOT ( NOT (",eq2," ) AND ( ",eq1, " )))");
    %"NOT (NOT I1 AND I0)";
    op = ~(~I1&I0);
    ngates = 3;
elseif (gen_in(1) == code(1) & gen_in(2) == code(2) & gen_in(3) ~= code(3) & gen_in(4) ~= code(4))
%12
    equation = strcat("( NOT ( ",eq2," ) )");
    %NOT I1;
    op = ~I1;
    ngates = 1;  
elseif (gen_in(1) == code(1) & gen_in(2) == code(2) & gen_in(3) ~= code(3) & gen_in(4) == code(4))
%13
    equation = strcat("( NOT ( ( ",eq2," ) AND NOT( ",eq2, " )))");
    %NOT (I1 AND NOT I0);
    op = ~(I1 & ~I0);
    ngates = 3;
elseif (gen_in(1)== code(1) & gen_in(2) == code(2) & gen_in(3) == code(3) & gen_in(4) ~= code(4))
%14
    equation = strcat("( NOT (( ",eq2," ) AND ( ",eq1, " ) ) )");
    %NOT (I1 AND I0);
    op = ~(I1&I0);
    ngates = 2;    
elseif (gen_in(1) == code(1) & gen_in(2) == code(2) & gen_in(3) == code(3) & gen_in(4) == code(4))
%15
    equation = "1";
    %1
    op = [1 1 1 1];
    ngates = 0; 
end 
%

fprintf('The boolean equation is: %s\n\n',equation)
g=sprintf('%d ', op);
fprintf('The phenotype is: %s\n\n', g)
fit = 0;
for i=1:4
    if(tt(i) == op(i))
        fit=fit+1;
    end
end
fprintf('The fitness is: %d\n\n', fit)
fprintf('The number of logic gates used is: %d\n\n', ngates)
phenotype=op;
evalue = fit + ( 1 / (ngates + 1 ) );