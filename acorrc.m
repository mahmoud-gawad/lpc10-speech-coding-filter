function [Rn r]=acorrc(C,minf,maxf)

M=length(C);
Rn=zeros(1,M); %preallocating for speed
r = 0;

for k=minf:maxf
    for m=1:M-k
        if ( (C(1,m) == 0) | (C(1,m+k) == 0) )
            Rn(1,k) = Rn(1,k) + 0;
        elseif (C(1,m) == C(1,m+k))
            Rn(1,k) = Rn(1,k) + 1;
        else
            Rn(1,k) = Rn(1,k) - 1;
        end
    end
end

for i = 1:M
   if (C(1,i) == 0)
       r = r + 0;
   else
       r = r + 1;
   end
end
