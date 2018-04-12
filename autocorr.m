function [R]=autocorr(x,p)

N=length(x);
R=zeros(1,p);

for i=0:p
    Rs=0;
    for n=1:(N-i)
        Rs=Rs+(x(n)*x(n+i));
    end
    R(i+1)=Rs;
end
