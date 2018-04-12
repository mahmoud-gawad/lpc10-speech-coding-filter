function [syn_speech]=synthesisfilter(excitation,filter_coff,frame_size,frame_overlap)

offset=30;
N=(frame_size-frame_overlap)+offset;

p=length(filter_coff);
state=zeros(1,p);

for i=1:N
     syn_speech(i)=excitation(i);
  for k=1:p
    syn_speech(i)=syn_speech(i)+state(k)*filter_coff(k);
  end

  state=[syn_speech(i) state(1:k-1)];
end

syn_speech=syn_speech(1+offset:N);
end