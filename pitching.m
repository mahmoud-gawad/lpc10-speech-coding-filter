%pitching & voicing
function [PP]=pitching(x,fs)

minf=floor(fs/350);
maxf=floor(fs/80);
Fc=900;                             %cut off frequency
w=Fc/(2*fs);                        %normalized frequency
[b,a]=butter(5,w,'low');            %5th order butterwort LPF

y=filter(b,a,x);                    %filtering the input signal

C=clip(y);                          %clipping the filtered signal

[Rn r]=acorrc(C,minf,maxf);         %autocorrelation of clipped signal

R=-1e11;
p=0;
for l=1:length(Rn)
    if Rn(1,l)>R
        p=l;
        R=Rn(1,l); 
    end
end

%determining the pitching period
if R>0.3*r
    PP=p;
else
    PP=0;
end
