function [x,l,u]=init(N,pd,paramVals) % Function for initialization

for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=paramVals(i)+ rand * (0.05 - 0.001);
    end
end
l=min(x,[],'all'); 
u=max(x,[],'all');
