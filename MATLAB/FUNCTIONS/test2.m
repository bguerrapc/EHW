clear all;
clc
tsize=0;
tv=[0 1 1 0];
n=1000;
stp_condition=4.2;
eval=0.0;
nbest=10;
i=1;
ncross=10000;
while (eval<stp_condition & i<n/2)
    g = genotype_generator(i);
    [f,ng]=vcr(g,tv);
    fitness(i)=f;
    ngates(i)=ng;
    genotype(i)=hex2dec(g);
    eval(i)=fitness(i)+(1/(ngates(i)+1));
    i=i+1;
end
%determina a ordem dos nbest melhores indivíduos
for j = 1:nbest
    [max_num, max_idx]=max(eval(:));
    [X]=ind2sub(size(eval),find(eval==max_num));
    [b,a]=size(X);
    for k=1:a
    best_pos(k+tsize)=X(k);
    end
    tsize=tsize+a;
    eval(X)=0;
    bestgen(j)=genotype(best_pos(j));
end
b_pos=best_pos(1:nbest);
%obrigatoriamente, b_pos terá os nbest melhores indivíduos 
a = 1;
b = 21;
%cruzamento e mutação

for i=1:ncross
    r = randi([a,b],1,1);
    dad = genotype(b_pos(1))
    dad = dec2hex(dad)
    dad = hexToBinaryVector(dad)
    s2 = size(dad);
    nsize2 = 22-s2(2);
    r2 = zeros(1,nsize2);
    gen_dad = horzcat(r2,dad)
    mom = genotype(b_pos(2))
    mom = dec2hex(mom)
    mom = hexToBinaryVector(mom)
    s3 = size(mom);
    nsize3 = 22-s3(2);
    r3 = zeros(1,nsize3);
    gen_mom = horzcat(r3,mom)
    %child(i)  = hex2dec(binaryVectorToHex([gen_dad(1,1:r),gen_mom(1,r+1:22)]))
    gen_dad(r:22)=[];
    gen_mom(1:r-1)=[];
    co = [gen_dad,gen_mom]
    child  = bin2dec(num2str(co));
    %child(i) = hex2dec(binaryVectorToHex(childing(i)));
    %childx(i) = mutation(child,2,500);
    %childhex(i) = lower(arrayfun(@(x) (dec2hex(i)), child, 'UniformOutput', false));
    [f,ng]=vcr(childhex(i),tv);
    fitness(i)=f;
    ngates(i)=ng;
    genotype(i)=hex2dec(childhex(i));
    evalc(i)=fitness(i)+(1/(ngates(i)+1));
end
%     
% for j = 1:nbest
%     [max_num, max_idx]=max(evalc( :));
%     [X]=ind2sub(size(evalc),find(evalc==max_num));
%     [b,a]=size(X);
%     for k=1:a
%      best_posc(k+tsize)=X(k);
%     end
%     tsize=tsize+a;
%     evalc(X)=0;
%     %bestgenc(j)=(childhex(best_posc(j)));
% end
% b_posc=best_posc(1:nbest);
max(eval)
max(evalc)
