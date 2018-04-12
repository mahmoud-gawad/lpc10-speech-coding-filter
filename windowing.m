function[speech_window]=windowing(frame,frame_size)

n=0:frame_size-1;
window=0.54-0.46*cos(2*pi*n/(frame_size-1));

for k=1:frame_size
    speech_window(k)=window(k)*frame(k); 
end
end
