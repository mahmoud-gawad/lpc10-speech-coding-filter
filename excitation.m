function[u]=excitation(pitch,P,frame_size,frame_overlap)

G=sqrt(P);

offset=30;
N=(frame_size-frame_overlap)+offset;

if pitch==0
  u=G*ceil(rand(1,N)-0.5)*2-1;
else
  u=zeros(1,N);
  n=1;
  while n<=N
    u(n)=1*G;
  n=n+pitch;
  end
end

