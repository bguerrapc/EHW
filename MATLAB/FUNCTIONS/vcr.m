%  +----------------------------------------------------------------+
%  | Author: Bernardo G.P. Cunha                                    |
%  | Function Name: vcr                                             |
%  | Function Purpose: represent the combinational circuit testbench|
%  | Inputs: Genotype, Truth table (ref)                            |
%  | Output: Fitness value, Number of logic gates                   |
%  +----------------------------------------------------------------+
function [fitness,ngates] = vcr(genotype,ref)
a = hexToBinaryVector(genotype);
s1 = size(a);
nsize = 22-s1(2);
r = zeros(1,nsize);
gen_in = horzcat(r,a);
tt = ref;
s=size(gen_in);
I0 = [0 1 0 1];
I1 = [0 0 1 1];
%L1 - First Layer
if(gen_in(23-1)== 1)
    J0 = "not I0";
    p0 = ~I0;
    ng0 = 1;
    "J0 = not I0";
elseif(gen_in(23-1)== 0)
    J0 = "I0";
    p0 = I0;
    ng0 = 0;
    "J0 =  I0";

end
if(gen_in(23-2)== 1)
    J1 = "not I1";
    p1 = ~I1;
    ng1 = 1;
    "J1 = not I1";

elseif(gen_in(23-2)== 0)
    J1 = "I1";
    p1 = I1;
    ng1 = 0;
    "J1 = I1";

end
if(gen_in(23-3)== 1)
    J2 = "not I0";
    p2 = ~I0;
    ng2= 1;
    "J2 = not I0";

elseif(gen_in(23-3)== 0) 
    J2 = "I0";
    p2 = I0;
    ng2= 0;
    "J2 = I0";
end
if(gen_in(23-4)== 1)
    J3 = "not I1";
    p3 = ~I1;
    ng3= 1;
    "J3 = not I1";

elseif(gen_in(23-4)== 0) 
    J3 = "I1";
    p3 = I1;
    ng3= 0;
    "J3 = I1";
end
%op1 - Operator 1 of Layer 1
if(gen_in(23-5) == 0 & gen_in(23-6) == 0)
    op1 = J0;
    Operation1 = p0;
    ngop1 = ng0;
    cop1=0;
elseif (gen_in(23-5) == 0 & gen_in(23-6) == 1)
    op1 = J1;
    Operation1 = p1;
    ngop1 = ng1;
    cop1=1;
elseif (gen_in(23-5) == 1 & gen_in(23-6) == 0)
    op1 = J2;
    Operation1 = p2;
    ngop1 = ng2;
    cop1=2;
elseif (gen_in(23-5) == 1 & gen_in(23-6) == 1)
    op1 = J3;
    Operation1 = p3;
    ngop1 = ng3;
    cop1=3;
end 
%op2 - Operator 2 of Layer 1
if(gen_in(23-7) == 0 & gen_in(23-8) == 0)
    op2 = J0;
    Operation2 = p0;
    ngop2 = ng0;
    cop2=0;
elseif (gen_in(23-7) == 0 & gen_in(23-8) == 1)
    op2 = J1;
    Operation2 = p1;
    ngop2 = ng1;
    cop2=1;
elseif (gen_in(23-7) == 1 & gen_in(23-8) == 0)
    op2 = J2;
    Operation2 = p2;
    ngop2 = ng2;
    cop2=2;
elseif (gen_in(23-7) == 1 & gen_in(23-8) == 1)
    op2 = J3;
    Operation2 = p3;
    ngop2 = ng3;
    cop2=3;
end 
%L2 - Operation of Layer 2
if(gen_in(23-9) == 0)
    L2 = strcat("( ", op1," AND ",op2, " ) ");
    Layer2 = Operation1 & Operation2;
    cL2=0;
elseif (gen_in(23-9) == 1)
    L2 = strcat("( ", op1," OR ",op2, " ) "); 
    Layer2 = Operation1 | Operation2;
    cL2=1;
end
ngL2 = ngop1+ngop2+1;
%op3 - Operator 1 of Layer 3
if    (gen_in(23-10) == 0 & gen_in(23-11) == 0 & gen_in(23-12) == 0)
    op3 = " 0 ";
    Operation3 = [0 0 0 0];
    ngop3 = 0;
    cop3=0;
elseif(gen_in(23-10) == 0 & gen_in(23-11) == 0 & gen_in(23-12) == 1)
    op3 = op2;
    Operation3 = Operation2;
    ngop3 = ngop2;
    cop3=1;
elseif(gen_in(23-10) == 0 & gen_in(23-11) == 1 & gen_in(23-12) == 0)
    op3 = J2;
    Operation3 = p2;
    ngop3 = ng2;
    cop3=2;
elseif(gen_in(23-10) == 0 & gen_in(23-11) == 1 & gen_in(23-12) == 1)
    op3 = J3;
    Operation3 = p3;
    ngop3 = ng3;
    cop3=3;
elseif(gen_in(23-10) == 1 & gen_in(23-11) == 0 & gen_in(23-12) == 0)
    op3 = " 1 ";
    Operation3 = [1 1 1 1];
    ngop3 = 0;
    cop3=4;
elseif(gen_in(23-10) == 1 & gen_in(23-11) == 0 & gen_in(23-12) == 1)
    op3 = strcat("(NOT ", op2,  " )");
    Operation3 = ~Operation2;
    ngop3 = ngop2+1;
    cop3=5;
elseif(gen_in(23-10) == 1 & gen_in(23-11) == 1 & gen_in(23-12) == 0)
    op3 = strcat("(NOT ", J2,  " )");
    Operation3 = ~p2;
    ngop3 = ng2+1;
    cop3=6;
elseif(gen_in(23-10) == 1 & gen_in(23-11) == 1 & gen_in(23-12) == 1)
    op3 = strcat("(NOT ", J3,  " )");
    Operation3 = ~p3;
    ngop3 = ng3+1;
    cop3=7;
end
%op4 - Operator 2 of Layer 3
if    (gen_in(23-13) == 0 & gen_in(23-14) == 0 & gen_in(23-15) == 0)
    op4 = J0;
    Operation4 = p0;
    ngop4 = ng0;
    cop4=0;
elseif(gen_in(23-13) == 0 & gen_in(23-14) == 0 & gen_in(23-15) == 1)
    op4 = J1;
    Operation4 = p1;
    ngop4 = ng1;
    cop4=1;
elseif(gen_in(23-13) == 0 & gen_in(23-14) == 1 & gen_in(23-15) == 0)
    op4 = op1;
    Operation4 = Operation1;
    ngop4 = ngop1;
    cop4=2;
elseif(gen_in(23-13) == 0 & gen_in(23-14) == 1 & gen_in(23-15) == 1)
    op4 = " 0 ";
    Operation4 = [0 0 0 0];
    ngop4 = 0;
    cop4=3;
elseif(gen_in(23-13) == 1 & gen_in(23-14) == 0 & gen_in(23-15) == 0)
    op4 = strcat("(NOT ", J0,  " )");
    Operation4 = ~p0;
    ngop4 = ng0+1;
    cop4=4;
elseif(gen_in(23-13) == 1 & gen_in(23-14) == 0 & gen_in(23-15) == 1)
    op4 = strcat("(NOT ", J1,  " )");
    Operation4 = ~p1;
    ngop4 = ng1+1;
    cop4=5;
elseif(gen_in(23-13) == 1 & gen_in(23-14) == 1 & gen_in(23-15) == 0)
    op4 = strcat("(NOT ", op1,  " )");
    Operation4 = ~Operation1;
    ngop4 = ngop1+1;
    cop4=6;
elseif(gen_in(23-13) == 1 & gen_in(23-14) == 1 & gen_in(23-15) == 1)
    op4 = " 1 ";
    Operation4 = [1 1 1 1];
    ngop4 = 0;
    cop4=7;
end
%op5 - Operator 3 of Layer 3
if (gen_in(23-16) == 0 & gen_in(23-17) == 0 & gen_in(23-18) == 0 & gen_in(23-19) == 0)
    op5 = strcat("( ",L2, " AND ",op1," )");
    Operation5 = Layer2 & Operation1;
    ngop5 = ngL2 + ngop1 + 1;
    cop5=0;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 0 & gen_in(23-18) == 0 & gen_in(23-19) == 1)
    op5 = strcat("( ",L2, " AND ",op2," )");
    Operation5 = Layer2 & Operation2;
    ngop5 = ngL2 + ngop2 + 1;
    cop5=1;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 0 & gen_in(23-18) == 1 & gen_in(23-19) == 0)
    op5 = strcat("( ",L2, " OR ",op1," )");
    Operation5 = Layer2 | Operation1;
    ngop5 = ngL2 + ngop1+ 1;
    cop5=2;
elseif(gen_in(23-16) == 0 && gen_in(23-17) == 0 & gen_in(23-18) == 1 & gen_in(23-19) == 1)
    op5 = strcat("( ",L2, " OR ",op2," )");
    Operation5 = Layer2 | Operation2;
    ngop5 = ngL2 + ngop2 + 1;
    cop5=3;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 1 & gen_in(23-18) == 0 & gen_in(23-19) == 0)
    op5 = L2;
    Operation5 = Layer2;
    ngop5 = ngL2;
    cop5=4;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 1 & gen_in(23-18) == 0 & gen_in(23-19) == 1)
    op5 = strcat("( NOT( ",L2," )");
    Operation5 = ~Layer2;
    ngop5 = ngL2 + 1;
    cop5=5;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 1 && gen_in(23-18) == 1 & gen_in(23-19) == 0)
    op5 = op4;
    Operation5 = Operation4;
    ngop5 = ngop4;
    cop5=6;
elseif(gen_in(23-16) == 0 & gen_in(23-17) == 1 & gen_in(23-18) == 1 & gen_in(23-19) == 1)
    op5 = op3;
    Operation5 = Operation3;
    ngop5 = ngop3;
    cop5=7;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 0 & gen_in(23-18) == 0 & gen_in(23-19) == 0)
    op5 = strcat("( NOT( ",L2, " AND ",op1," )");
    Operation5 = ~(Layer2 & Operation1);
    ngop5 = ngL2 + ngop1 + 2;
    cop5=8;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 0 & gen_in(23-18) == 0 & gen_in(23-19) == 1)
    op5 = strcat("( NOT( ",L2, " AND ",op2," )");
    Operation5 = ~(Layer2 & Operation2);
    ngop5 = ngL2 + ngop2 + 2;
    cop5=9;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 0 & gen_in(23-18) == 1 & gen_in(23-19) == 0)
    op5 = strcat("( NOT( ",L2, " OR ",op1," )");
    Operation5 = ~(Layer2 | Operation1);
    ngop5 = ngL2 + ngop1 + 2;
    cop5=10;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 0 & gen_in(23-18) == 1 & gen_in(23-19) == 1)
    op5 = strcat("( NOT( ",L2, " OR ",op2," )");
    Operation5 = ~(Layer2 | Operation2);
    ngop5 = ngL2 + ngop2 + 2;
    cop5=11;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 1 & gen_in(23-18) == 0 & gen_in(23-19) == 0)
    op5 = strcat("( ",J0," AND ",J3," )");
    Operation5 = p0 & p3;
    ngop5 = ng0 + ng3 + 1;
    cop5=12;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 1 & gen_in(23-18) == 0 & gen_in(23-19 )== 1)
    op5 = strcat("( ",J1," AND ",J2," )");
    Operation5 = p1 & p2;
    ngop5 = ng1 + ng2 + 1;
    cop5=13;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 1 & gen_in(23-18) == 1 & gen_in(23-19) == 0)
    op5 = strcat("( ",J0," OR ",J1," )");
    Operation5 = p0 | p1;
    ngop5 = ng0 + ng1 + 1;
    cop5=14;
elseif(gen_in(23-16) == 1 & gen_in(23-17) == 1 & gen_in(23-18) == 1 & gen_in(23-19) == 1)
    op5 = strcat("( ",J2," OR ",J3," )");
    Operation5 = p2 | p3;
    ngop5 = ng2 + ng3 + 1;
    cop5=15;
end
%L3 - Operation of Layer 3

if  (gen_in(23-20) == 0 & gen_in(23-21) == 0 & gen_in(23-22) == 0)
    L3 = strcat("( ",op3," AND ", op4, ") AND ",op5," )");
    Layer3 = (Operation3 & Operation4) & Operation5;
    ngL3 = ngop3 + ngop4 + ngop5 + 2;
    cL3=0;
elseif(gen_in(23-20) == 0 & gen_in(23-21) == 0 & gen_in(23-22) == 1)
    L3 = strcat("( ",op3," AND ", op4, ") OR ",op5," )");
    Layer3 = (Operation3 & Operation4) | Operation5;
    ngL3 = ngop3 + ngop4 + ngop5 + 2;
    cL3=1;
elseif(gen_in(23-20) == 0 & gen_in(23-21) == 1 & gen_in(23-22) == 0)
    L3 = strcat("( ",op3," OR ", op4, ") AND ",op5," )");
    Layer3 = (Operation3 | Operation4) & Operation5;
    ngL3 = ngop3 + ngop4 + ngop5 + 2;
    cL3=2;
elseif(gen_in(23-20) == 0 && gen_in(23-21) == 1 && gen_in(23-22) == 1)
    L3 = strcat("( ",op3," OR ", op4, ") OR ",op5," )");
    Layer3 = (Operation3 | Operation4) | Operation5;
    ngL3 = ngop3 + ngop4 + ngop5 + 2;
    cL3=3;
elseif(gen_in(23-20) == 1 & gen_in(23-21) == 0 & gen_in(23-22) == 0)
    L3 = op5;
    Layer3 = Operation5;
    ngL3 = ngop5;
    cL3=4;
elseif(gen_in(23-20) == 1 & gen_in(23-21) == 0 & gen_in(23-22) == 1)
    L3 = strcat(op4," AND ", op3);
    Layer3 = Operation4 & Operation3;
    ngL3 = ngop4 + ngop3 + 1;
    cL3=5;
elseif(gen_in(23-20) == 1 & gen_in(23-21) == 1 & gen_in(23-22) == 0)
    L3 = strcat("( "," NOT ",op5," )");
    Layer3 = ~Operation5;
    ngL3 = ngop5 + 1;
    cL3=6;
elseif(gen_in(23-20) == 1 & gen_in(23-21) == 1 & gen_in(23-22) == 1)
    L3 = strcat(op3," OR ", op4);
    Layer3 = Operation3 | Operation4;
    ngL3 = ngop3 + ngop4 + 1;
    cL3=7;
end
%fprintf('The boolean equation is: %s\n\n',L3)
%g=sprintf('%d ', Layer3);
%fprintf('The phenotype is: %s\n\n', g)
fit = 0;
for i=1:4
    if(tt(i) == Layer3(i))
        fit=fit+1;
    end
end
%fprintf('The fitness is: %d\n\n', fitness)
%fprintf('The number of logic gates used is: %d\n\n', ngL3)
fitness=fit;
ngates=ngL3;
