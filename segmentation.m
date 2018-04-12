function [frame]=segmentation(speech,frame_number,frame_size,frame_overlap)
for i=1:frame_size
    frame(i)=speech(((frame_number-1)*(frame_size-frame_overlap))+i);
end