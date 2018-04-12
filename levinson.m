function [filter_cofficients P]=levinson(R)

%Define parameters for levinson-drbin algorithm

M=length(R)-1;              %filter order
a=zeros(0,0);               %filter cofficients


P=R(1);

for i=1:M
    
    cross_correlation=R(i+1);
    
    %calculation of reflecion cofficient
    for j=1:i-1
        cross_correlation=cross_correlation+R(i-j+1)*a(j);
    end
    
    K=(-1)* (cross_correlation/P);
    %Save cofficients of filter of order (m-1) in a
    a_old=a;
    a(i)=K;

    %calculate prediction_error_filter_cofficients
    for k=1:i-1
        a(k)=a_old(k)+a_old(i-k)*K;
    end


    %calculate prediction_error_power
    P=(1-K^2)*P;
end
filter_cofficients=-a;
end
