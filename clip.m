function [C]=clip(y)

N=length(y);
Cl=0.3*max(y);
C=zeros(1,N); %preallocating for speed

for n=1:1:N
    if (y(1,n)>Cl)
        C(1,n)=1;
    elseif (y(1,n)<-Cl)
        C(1,n)=-1;
    else
        C(1,n)=0;
    end
end
